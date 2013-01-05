local setmetatable = setmetatable
local os = os
local textbox = require("wibox.widget.textbox")
local capi = { timer = timer }

--- Text volume widget.
-- awful.widget.textvolume
local textvolume = { mt = {} }

function textvolume.new(channel, timeout)
	local channel = channel or "Master"
	local timeout = timeout or 5

	local w = textbox()
	local timer = capi.timer { timeout = timeout }
	timer:connect_signal("timeout", function() w:set_markup("vol --") end)
	timer:start()
	timer:emit_signal("timeout")
	return w
end


function textvolume:get()
end


function textvolume:set(val)
end


function textvolume:inc(val)
end


function textvolume:dec(val)
end


function textvolume:mute()
end


function textvolume:unmute()
end


function textvolume:toggle()
end


function textvolume:update()
end


function textvolume.mt:__call(...)
	return textvolume.new(...)
end

return setmetatable(textvolume, textvolume.mt)
