#!/usr/bin/env lua

local io = require "io"
local msg = require 'mp.msg'
local utils = require 'mp.utils'

function is_url_exist(filename)
    local handle = io.popen("curl -I -s " .. filename .. " | grep HTTP | awk '{print $2}'")
    local result = handle:read("*a")
    handle:close()

    return tonumber(result) == 200
end

function is_file_exist(filename)
    local f = io.open(filename, "r")
    if f ~= nil then 
        io.close(f) 
        return true 
    end

    return false 
end

function has_next_episode(filename)
    if string.sub(filename, 0, 4) == "http" then
        return is_url_exist(filename)
    end

    return is_file_exist(filename)
end

function get_next_episode(filename)
    local filename_len = string.len(filename)
    local epi_name = string.sub(filename, 0, filename_len-6)
    local ext = string.sub(filename, filename_len-3, filename_len)

    local epi_num = string.sub(filename, filename_len-5, filename_len-4)
    local is_num = tonumber(epi_num) ~= nil
    if not is_num then
        msg.log("info", "Unable to parse episode number")
        msg.log("info", "Exiting")
        return nil
    end
    epi_num = tostring(tonumber(epi_num) + 1)

    if string.len(epi_num) < 2 then
        epi_num = "0" .. epi_num
    end

    local next_episode = epi_name .. epi_num .. ext
    return next_episode
end

function is_trusted_server(path)
    local protocol = string.sub(path, 0, 4)
    if protocol == "http" then
        local server_name = string.sub(path, 0, 21)
        return server_name == "http://nas.nzhome.com"
    end
    return true
end

function load_next()
    local path = mp.get_property("path", "")
    if not is_trusted_server(path) then
        msg.log("info", "Not a trusted server")
        return
    end

    local loc, filename = utils.split_path(path)
    local next_epi = get_next_episode(filename)

    if next_epi == nil then
        return
    end

    local next_path = utils.join_path(loc, next_epi)
    msg.log("info", next_path)
    if has_next_episode(next_path) then
        msg.log("info", next_path .. " will be played next")
        mp.commandv('loadfile', next_path, 'append')
    end
end

mp.register_event("file-loaded", load_next)
