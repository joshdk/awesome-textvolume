awesome-textvolume
==================

A volume widget for Awesome WM


Installing
----------

    # make install


Uninstalling
------------

    # make uninstall


Using
-----

Import the module

```lua
-- Add this line at the top of your rc.lua
local textvolume = require("textvolume");
```

Create a widget instance (at the start of the Wibox section in rc.lua):

```lua
-- Create the textclock widget
local mytextclock = awful.widget.textclock()
-- Create our textvolume widget
local mytextvolume = awful.widget.textvolume()
```

Add our instance (near the end of the Wibox section in rc.lua):

```lua
-- Add the textvolume widget
right_layout:add(mytextvolume)
right_layout:add(mytextclock)
right_layout:add(mylayoutbox[s])
```
