local setmetatable = setmetatable
local os = os
local textbox = require("wibox.widget.textbox")
local capi = { timer = timer }

--- Text volume widget.
-- awful.widget.textvolume
local textvolume = { mt = {} }
local volume = {}


function volume:get()
	cmd = string.format("amixer get %s", volume.channel)

	local fd = io.popen(cmd)
	local status = fd:read("*all")
	fd:close()

	info={}
	info.volume = string.match(status, "(%d?%d?%d)%%") or "0"
	info.muted=string.find(status, "[off]", 1, true) ~= nil
	return info
end


function volume:set(val)
	cmd = string.format("amixer set %s %d%%", volume.channel, val)
	os.execute(cmd)
end


function volume:inc(val)
	cmd = string.format("amixer set %s %d%%+", volume.channel, val)
	os.execute(cmd)
end


function volume:dec(val)
	cmd = string.format("amixer set %s %d%%-", volume.channel, val)
	os.execute(cmd)
end


function volume:mute()
	cmd = string.format("amixer set %s mute", volume.channel)
	os.execute(cmd)
end


function volume:unmute()
	cmd = string.format("amixer set %s unmute", volume.channel)
	os.execute(cmd)
end


function volume:toggle()
	cmd = string.format("amixer set %s toggle", volume.channel)
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
		w:set_markup("vol --")
	end

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
