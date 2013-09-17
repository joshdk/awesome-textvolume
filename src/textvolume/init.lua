local setmetatable = setmetatable
local os = os
local textbox = require("wibox.widget.textbox")
local button = require("awful.button")
local util = require("awful.util")
local alsa = require("alsa")
local capi = { timer = timer }


local textvolume = { mt = {} }
local volume = {}


function textvolume.new(channel, timeout)
	local channel = channel or "Master"
	local timeout = timeout or 5
	local w = textbox()

	w.channel = channel

	function w:set(val)
		self:update(
			alsa.set(self.channel, val)
		)
	end

	function w:inc(val)
		self:update(
			alsa.inc(self.channel, val)
		)
	end

	function w:dec(val)
		self:update(
			alsa.dec(self.channel, val)
		)
	end

	function w:mute(val)
		self:update(
			alsa.mute(self.channel)
		)
	end

	function w:unmute(val)
		self:update(
			alsa.unmute(self.channel)
		)
	end

	function w:toggle(val)
		self:update(
			alsa.toggle(self.channel)
		)
	end

	function w:update(status)
		status = status or alsa.get(self.channel)
		local text
		if status.muted == false then
			local color = "#AFD700"
			text = string.format("Vol <span color='%s'>%d</span>", color, status.volume[1] or 0)
		else
			local color = "#F53145"
			text = string.format("Vol <span color='%s'>%d</span>", color, status.volume[1] or 0)
		end

		self:set_markup(text)
	end

	w:buttons(util.table.join(
		button({ }, 1, function()
			w:inc(5)
		end),
		button({ }, 3, function()
			w:dec(5)
		end),
		button({ }, 2, function()
			w:toggle()
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
