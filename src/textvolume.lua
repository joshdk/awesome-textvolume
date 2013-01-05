local setmetatable = setmetatable
local os = os
local textbox = require("wibox.widget.textbox")
local capi = { timer = timer }

--- Text volume widget.
-- awful.widget.textvolume
local textvolume = { mt = {} }
local volume = {}


function volume:get()
end


function volume:set(val)
end


function volume:inc(val)
end


function volume:dec(val)
end


function volume:mute()
end


function volume:unmute()
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
