local setmetatable = setmetatable
local os = os
local textbox = require("wibox.widget.textbox")
local capi = { timer = timer }

--- Text volume widget.
-- awful.widget.textvolume
local textvolume = { mt = {} }

function textvolume.new(timeout)
    local timeout = timeout or 5

    local w = textbox()
    local timer = capi.timer { timeout = timeout }
    timer:connect_signal("timeout", function() w:set_markup("vol --") end)
    timer:start()
    timer:emit_signal("timeout")
    return w
end

function textvolume.mt:__call(...)
    return textvolume.new(...)
end

return setmetatable(textvolume, textvolume.mt)
