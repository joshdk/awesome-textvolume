awesome-textvolume
==================

A volume widget for Awesome WM


Installing
----------

    # make install

```lua
-- add this line inside of /usr/share/awesome/lib/awful/widget/init.lua
textvolume = require("awful.widget.textvolume");
```


Uninstalling
------------

    # make uninstall

```lua
-- remove this line from /usr/share/awesome/lib/awful/widget/init.lua
textvolume = require("awful.widget.textvolume");
```

Using
-----

Create a widget instance (at the start of the Wibox section in rc.lua):

```lua
-- Create a textclock widget
mytextclock = awful.widget.textclock()
-- Create a textvolume widget
mytextvolume = awful.widget.textvolume()
```

Add our instance (near the end of the Wibox section in rc.lua):

```lua
-- Add the textvolume widget
right_layout:add(mytextvolume)
right_layout:add(mytextclock)
right_layout:add(mylayoutbox[s])
```
