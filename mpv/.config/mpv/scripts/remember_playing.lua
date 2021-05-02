#!/usr/bin/env lua

local io = require "io"
local msg = require 'mp.msg'

function on_load()
    local history_file = "/home/kenzie/Nextcloud/mpv/history.log"
    local path = mp.get_property("path", "")
    msg.log("info", path)
    if (string.sub(path, 0, 21) == "http://nas.nzhome.com" or
        string.sub(path, 0, 8) == "/mnt/nfs") then
        local f = assert(io.open(history_file, "w"))
        f:write(path)
        f:close()
        msg.log("info", "Wrote " .. path .. " to " .. history_file)
    end
end

mp.register_event("file-loaded", on_load)
