local setmetatable = setmetatable
local os = os
local textbox = require("wibox.widget.textbox")
local button = require("awful.button")
local util = require("awful.util")
local capi = { timer = timer }

--- Text volume widget.
-- awful.widget.textvolume
local textvolume = { mt = {} }
local volume = {}


function volume:get()
	local cmd = string.format("amixer get %s", volume.channel)

	local fd = io.popen(cmd)
	local status = fd:read("*all")
	fd:close()

	local info={}
	info.volume = string.match(status, "(%d?%d?%d)%%") or "0"
	info.muted=string.find(status, "[off]", 1, true) ~= nil
	return info
end


function volume:set(val)
	local cmd = string.format("amixer set %s %d%%", volume.channel, val)
	os.execute(cmd)
end


function volume:inc(val)
	local cmd = string.format("amixer set %s %d%%+", volume.channel, val)
	os.execute(cmd)
end


function volume:dec(val)
	local cmd = string.format("amixer set %s %d%%-", volume.channel, val)
	os.execute(cmd)
end


function volume:mute()
	local cmd = string.format("amixer set %s mute", volume.channel)
	os.execute(cmd)
end


function volume:unmute()
	local cmd = string.format("amixer set %s unmute", volume.channel)
	os.execute(cmd)
end


function volume:toggle()
	local cmd = string.format("amixer set %s toggle", volume.channel)
	os.execute(cmd)
end


function textvolume.new(channel, timeout)
	local channel = channel or "Master"
	local timeout = timeout or 5
	local w = textbox()

	volume.channel = channel

	w["get"]    = volume["get"]
	w["set"]    = volume["set"]
	w["inc"]    = volume["inc"]
	w["dec"]    = volume["dec"]
	w["mute"]   = volume["mute"]
	w["unmute"] = volume["unmute"]
	w["toggle"] = volume["toggle"]

	w["update"] = function()
		local info = volume:get()
		local text
		if info.muted == false then
			local color = "#AFD700"
			text = string.format("Vol <span color='%s'>%d</span>", color, info.volume)
		else
			local color = "#F53145"
			text = string.format("Vol <span color='%s'>%d</span>", color, info.volume)
		end

		w:set_markup(text)
	end

	w:buttons(util.table.join(
		button({ }, 1, function()
			w:inc(5)
			w:update()
		end),
		button({ }, 3, function()
			w:dec(5)
			w:update()
		end),
		button({ }, 2, function()
			w:toggle()
			w:update()
		end)
	))

	local timer = capi.timer { timeout = timeout }
	timer:connect_signal("timeout", function() w:update() end)
	timer:start()
	timer:emit_signal("timeout")
	return w
end


function textvolume.mt:__call(...)
	return textvolume.new(...)
end

return setmetatable(textvolume, textvolume.mt)
