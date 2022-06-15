#!/usr/bin/env bash

sudo apt install python3-pip ansible
ansible-playbook setup.yml
sh ./dein_installer.sh ~/.cache/dein
