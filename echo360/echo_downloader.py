#!/usr/bin/env python3

import time
import os

from selenium import webdriver
from selenium.common.exceptions import NoSuchElementException
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.firefox.options import Options

dl_directory = "/home/kenzie/Videos/"

EMAIL = ""
PASSWORD = ""

url = input("URL: ")

options = Options()
options.headless = True
options.set_preference("browser.download.folderList", 2)
options.set_preference("browser.download.manager.showWhenStarting", False)
options.set_preference("browser.download.dir", dl_directory)
options.set_preference("browser.helperApps.neverAsk.saveToDisk", "video/mp4")
browser = webdriver.Firefox(options=options)
actions = ActionChains(browser)

browser.get(url)


assert "Email" in browser.title
email_input = browser.find_elements_by_xpath('//*[@id="email"]')[0]
email_input.send_keys(EMAIL)

submit_button = browser.find_elements_by_xpath('//*[@id="submitText"]')[0]
submit_button.click()

password_input = browser.find_elements_by_xpath('//*[@id="password"]')[0]
password_input.send_keys(PASSWORD)

submit_button = browser.find_elements_by_xpath('//*[@id="submitBtn"]')[0]
submit_button.click()

time.sleep(3)
videos = browser.find_elements_by_css_selector("div.content-wrapper")

links = dict()

ffmpeg_combine_commands = []
video_num = 1
for video in videos:
    video_title = video.find_element_by_css_selector("header.header span div").text
    try:
        video_date = video.find_element_by_css_selector("span.date-time span.date").text
    except NoSuchElementException:
        video_date = ""

    try:
        video_btn = video.find_element_by_class_name("courseMediaIndicator")
        video_btn.click()
    except NoSuchElementException:
        continue

    time.sleep(1)

    download_btn = None
    download_btns = browser.find_elements_by_tag_name("a")
    for btn in download_btns:
        if btn.text.lower() == "download original":
            download_btn = btn
            break
    download_btn.click()

    time.sleep(1)
    screen_num = 0
    filenames = []
    for a in browser.find_elements_by_css_selector("a.screenOption"):
        time.sleep(1)
        a.click()
        dl_options = browser.find_elements_by_css_selector(
            "div.downloadOption.video option"
        )
        dl_link = None
        screen_num += 1
        for option in dl_options:
            if (
                "https://content.echo360" in option.get_attribute("value")
                and "HD" in option.text
            ):
                dl_link = option.get_attribute("value")
                dl_link = dl_link.split("?")[0]
                filename = (
                    f"{str(video_num).zfill(2)}.{video_title}-{video_date}-{screen_num}"
                )
                video_num += 1
                links[filename] = dl_link
                filenames.append(filename)

    if filenames:
        ffmpeg_combine_commands.append(
            f"ffmpeg -i '{filenames[0]}.mp4' -i '{filenames[1]}.mp4' -filter_complex "
            + '"[0:v][1:v]hstack=inputs=2[v];  '
            + f'[0:a]amerge[a]" -map "[v]" -map "[a]" -ac 2 \'{filenames[0]}-combined.mp4\' || true'
        )
        ffmpeg_combine_commands.append(f"rm '{filenames[0]}.mp4' || true")
        ffmpeg_combine_commands.append(f"rm '{filenames[1]}.mp4' || true")

    time.sleep(2)
    browser.find_element_by_css_selector("a.btn.white.medium").click()

cookies = browser.get_cookies()
cookies = "; ".join([f"{c['name']}={c['value']}" for c in cookies])

browser.close()
browser.quit()

if not os.path.isfile(dl_directory + "history.txt"):
    os.mknod(dl_directory + "history.txt")

with open(dl_directory + "history.txt", "r") as f:
    lines = set(f.read().split("\n"))

new_links = []
with open(dl_directory + "dl.txt", "w") as f:
    i = 1
    for title, link in links.items():
        if link in lines:
            continue
        new_links.append(link)
        f.write(f"wget -nc -O '{title}.mp4' --header 'Cookie: {cookies}' '{link}' \n")
        i += 1

    for line in ffmpeg_combine_commands:
        f.write(line + "\n")

with open(dl_directory + "history.txt", "a") as f:
    for link in new_links:
        f.write(link + "\n")
