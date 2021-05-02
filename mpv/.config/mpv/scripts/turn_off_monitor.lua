#!/usr/bin/env lua

local msg = require 'mp.msg'
local script = "bash ~/.xrandr.sh"

local turn_off_monitor = function()
    -- turns off monitor DisplayPort-0 and DisplayPort-1
    msg.log("info", "Running script")
    os.execute(script .. " --off")
    mp.set_property("fullscreen", "yes")
end

local turn_on_monitor = function()
    -- turns on monitor DisplayPort-0 and DisplayPort-1
    msg.log("info", "Turning on monitor")
    os.execute(script)
    mp.set_property("fullscreen", "no")
end

mp.add_key_binding("c", "toggle_mon_off", turn_off_monitor)
mp.add_key_binding("v", "toggle_mon_on", turn_on_monitor)
