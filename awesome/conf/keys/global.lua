local awful = require('awful')
require('awful.autofocus')
local beautiful = require('beautiful')
local hotkeys_popup = require('awful.hotkeys_popup').widget
local lain = require('lain')

local modkey = require('conf.keys.mod').modKey
local altkey = require('conf.keys.mod').altKey
local apps = require('conf.apps')
-- Key bindings
local globalKeys =
    awful.util.table.join(
    -- X screen locker
    awful.key(
        {altkey, 'Control'},
        'l',
        function()
            os.execute('xlock')
        end,
        {description = 'lock screen', group = 'hotkeys'}
    ),
    -- Hotkeys
    awful.key({modkey}, 'F1', hotkeys_popup.show_help, {description = 'show help', group = 'awesome'}),
    -- Tag browsing
    awful.key({modkey}, 'w', awful.tag.viewprev, {description = 'view previous', group = 'tag'}),
    awful.key({modkey}, 's', awful.tag.viewnext, {description = 'view next', group = 'tag'}),
    awful.key({modkey}, 'Escape', awful.tag.history.restore, {description = 'go back', group = 'tag'}),
    -- Non-empty tag browsing
    -- awful.key({ modkey, "Shift" }, "Left", function () lain.util.tag_view_nonempty(-1) end,
    --           {description = "view  previous nonempty", group = "tag"}),
    -- awful.key({ modkey, "Shift" }, "Right", function () lain.util.tag_view_nonempty(1) end,
    --           {description = "view  previous nonempty", group = "tag"}),

    -- Default client focus
    awful.key(
        {modkey},
        'd',
        function()
            awful.client.focus.byidx(1)
        end,
        {description = 'focus next by index', group = 'client'}
    ),
    awful.key(
        {modkey},
        'a',
        function()
            awful.client.focus.byidx(-1)
        end,
        {description = 'focus previous by index', group = 'client'}
    ),
    -- By direction client focus
    awful.key(
        {modkey},
        'j',
        function()
            awful.client.focus.bydirection('down')
            if _G.client.focus then
                _G.client.focus:raise()
            end
        end,
        {description = 'focus down', group = 'client'}
    ),
    awful.key(
        {modkey},
        'k',
        function()
            awful.client.focus.bydirection('up')
            if _G.client.focus then
                _G.client.focus:raise()
            end
        end,
        {description = 'focus up', group = 'client'}
    ),
    awful.key(
        {modkey},
        'h',
        function()
            awful.client.focus.bydirection('left', nil, true)
            if _G.client.focus then
                _G.client.focus:raise()
            end
        end,
        {description = 'focus left', group = 'client'}
    ),
    awful.key(
        {modkey},
        'l',
        function()
            awful.client.focus.bydirection('right', nil, true)
            if _G.client.focus then
                _G.client.focus:raise()
            end
        end,
        {description = 'focus right', group = 'client'}
    ),
    awful.key(
        {modkey},
        'm',
        function()
            awful.util.mymainmenu:show()
        end,
        {description = 'show main menu', group = 'awesome'}
    ),
    awful.key(
        {modkey},
        'e',
        function()
            awful.util.spawn('rofi -show drun')
        end,
        {description = 'show main menu', group = 'awesome'}
    ),
    awful.key({modkey}, 'u', awful.client.urgent.jumpto, {description = 'jump to urgent client', group = 'client'}),
    awful.key(
        {modkey},
        'Tab',
        function()
            awful.client.focus.history.previous()
            if _G.client.focus then
                _G.client.focus:raise()
            end
        end,
        {description = 'go back', group = 'client'}
    ),
    -- Show/Hide Wibox
    awful.key(
        {modkey},
        'b',
        function()
            for s in _G.screen do
                s.mywibox.visible = not s.mywibox.visible
                if s.mybottomwibox then
                    s.mybottomwibox.visible = not s.mybottomwibox.visible
                end
            end
        end,
        {description = 'toggle wibox', group = 'awesome'}
    ),
    -- On the fly useless gaps change
    awful.key(
        {altkey},
        'Right',
        function()
            lain.util.useless_gaps_resize(7)
        end,
        {description = 'increment useless gaps', group = 'tag'}
    ),
    awful.key(
        {altkey},
        'Left',
        function()
            lain.util.useless_gaps_resize(-7)
        end,
        {description = 'decrement useless gaps', group = 'tag'}
    ),
    -- Dynamic tagging
    -- awful.key({ modkey, "Shift" }, "n", function () lain.util.add_tag() end,
    --           {description = "add new tag", group = "tag"}),
    -- awful.key({ modkey, "Shift" }, "r", function () lain.util.rename_tag() end,
    --           {description = "rename tag", group = "tag"}),
    -- awful.key({ modkey, "Shift" }, "Left", function () lain.util.move_tag(-1) end,
    --           {description = "move tag to the left", group = "tag"}),
    -- awful.key({ modkey, "Shift" }, "Right", function () lain.util.move_tag(1) end,
    --           {description = "move tag to the right", group = "tag"}),
    -- awful.key({ modkey, "Shift" }, "d", function () lain.util.delete_tag() end,
    --           {description = "delete tag", group = "tag"}),
    -- Programms
    awful.key(
        {},
        'XF86Launch1',
        function()
            awful.util.spawn('subl3')
        end
    ),
    awful.key(
        {modkey},
        'v',
        function()
            awful.util.spawn_with_shell('vivaldi-snapshot')
        end
    ),
    awful.key(
        {modkey},
        't',
        function()
            awful.util.spawn_with_shell('caja')
        end
    ),
    awful.key(
        {modkey},
        'r',
        function()
            awful.util.spawn('xterm -e ranger')
        end
    ),
    awful.key(
        {modkey},
        'l',
        function()
            awful.util.spawn_with_shell('~/.config/scripts/lock.sh')
        end
    ),
    awful.key(
        {},
        'Print',
        function()
            awful.util.spawn("scrot -e 'mv %f ~/screenshots/'")
        end
    ),
    -- Standard program
    awful.key(
        {modkey},
        'x',
        function()
            awful.spawn(apps.terminal)
        end,
        {description = 'open a terminal', group = 'launcher'}
    ),
    awful.key({modkey, 'Control'}, 'r', _G.awesome.restart, {description = 'reload awesome', group = 'awesome'}),
    awful.key({modkey, 'Control'}, 'q', _G.awesome.quit, {description = 'quit awesome', group = 'awesome'}),
    awful.key(
        {altkey, 'Shift'},
        'l',
        function()
            awful.tag.incmwfact(0.05)
        end,
        {description = 'increase master width factor', group = 'layout'}
    ),
    awful.key(
        {altkey, 'Shift'},
        'h',
        function()
            awful.tag.incmwfact(-0.05)
        end,
        {description = 'decrease master width factor', group = 'layout'}
    ),
    awful.key(
        {modkey, 'Shift'},
        'h',
        function()
            awful.tag.incnmaster(1, nil, true)
        end,
        {description = 'increase the number of master clients', group = 'layout'}
    ),
    awful.key(
        {modkey, 'Shift'},
        'l',
        function()
            awful.tag.incnmaster(-1, nil, true)
        end,
        {description = 'decrease the number of master clients', group = 'layout'}
    ),
    awful.key(
        {modkey, 'Control'},
        'h',
        function()
            awful.tag.incncol(1, nil, true)
        end,
        {description = 'increase the number of columns', group = 'layout'}
    ),
    awful.key(
        {modkey, 'Control'},
        'l',
        function()
            awful.tag.incncol(-1, nil, true)
        end,
        {description = 'decrease the number of columns', group = 'layout'}
    ),
    awful.key(
        {modkey},
        'space',
        function()
            awful.layout.inc(1)
        end,
        {description = 'select next', group = 'layout'}
    ),
    awful.key(
        {modkey, 'Shift'},
        'space',
        function()
            awful.layout.inc(-1)
        end,
        {description = 'select previous', group = 'layout'}
    ),
    awful.key(
        {modkey, 'Control'},
        'n',
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                _G.client.focus = c
                c:raise()
            end
        end,
        {description = 'restore minimized', group = 'client'}
    ),
    -- Dropdown application
    awful.key(
        {modkey},
        '`',
        function()
            awful.screen.focused().quake:toggle()
        end,
        {description = 'dropdown application', group = 'launcher'}
    ),
    -- Widgets popups
    awful.key(
        {altkey},
        'c',
        function()
            lain.widget.calendar.show(7)
        end,
        {description = 'show calendar', group = 'widgets'}
    ),
    awful.key(
        {altkey},
        'h',
        function()
            if beautiful.fs then
                beautiful.fs.show(7)
            end
        end,
        {description = 'show filesystem', group = 'widgets'}
    ),
    awful.key(
        {altkey},
        'w',
        function()
            if beautiful.weather then
                beautiful.weather.show(7)
            end
        end,
        {description = 'show weather', group = 'widgets'}
    ),
    -- Brightness
    awful.key(
        {},
        'XF86MonBrightnessUp',
        function()
            awful.util.spawn('xbacklight -inc 10')
        end,
        {description = '+10%', group = 'hotkeys'}
    ),
    awful.key(
        {},
        'XF86MonBrightnessDown',
        function()
            awful.util.spawn('xbacklight -dec 10')
        end,
        {description = '-10%', group = 'hotkeys'}
    ),
    -- ALSA volume control
    awful.key(
        {},
        'XF86AudioRaiseVolume',
        function()
            os.execute(string.format('amixer -q set %s 5%%+', beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description = 'volume up', group = 'hotkeys'}
    ),
    awful.key(
        {},
        'XF86AudioLowerVolume',
        function()
            os.execute(string.format('amixer -q set %s 5%%-', beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description = 'volume down', group = 'hotkeys'}
    ),
    awful.key(
        {},
        'XF86AudioMute',
        function()
            os.execute(
                string.format('amixer -q set %s toggle', beautiful.volume.togglechannel or beautiful.volume.channel)
            )
            beautiful.volume.update()
        end,
        {description = 'toggle mute', group = 'hotkeys'}
    ),
    -- awful.key({ altkey, "Control" }, "m",
    --     function ()
    --         os.execute(string.format("amixer -q set %s 100%%", beautiful.volume.channel))
    --         beautiful.volume.update()
    --     end,
    --     {description = "volume 100%", group = "hotkeys"}),
    -- awful.key({ altkey, "Control" }, "0",
    --     function ()
    --         os.execute(string.format("amixer -q set %s 0%%", beautiful.volume.channel))
    --         beautiful.volume.update()
    --     end,
    --     {description = "volume 0%", group = "hotkeys"}),

    -- Copy primary to clipboard (terminals to gtk)
    awful.key(
        {modkey},
        'c',
        function()
            awful.spawn('xsel | xsel -i -b')
        end,
        {description = 'copy terminal to gtk', group = 'hotkeys'}
    ),
    -- Copy clipboard to primary (gtk to terminals)
    awful.key(
        {altkey},
        'v',
        function()
            awful.spawn('xsel -b | xsel')
        end,
        {description = 'copy gtk to terminal', group = 'hotkeys'}
    ),
    awful.key(
        {altkey},
        'F2',
        function()
            awful.util.spawn(
                "dmenu_run -fn 'Source Code Pro Regular-8' -i -l 10 -p 'Run:' -nb '#2d2d2d' -nf '#cccccc' -sb '#ff033e' -sf '#38000d'"
            )
        end
    ),
    awful.key(
        {altkey},
        'o',
        function()
            awful.screen.focused().mypromptbox:run()
        end,
        {description = 'run prompt', group = 'launcher'}
    ),
    awful.key(
        {altkey},
        'l',
        function()
            awful.prompt.run {
                prompt = 'Run Lua code: ',
                textbox = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. '/history_eval'
            }
        end,
        {description = 'lua execute prompt', group = 'awesome'}
    )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description = 'view tag #', group = 'tag'}
        descr_toggle = {description = 'toggle tag #', group = 'tag'}
        descr_move = {description = 'move focused client to tag #', group = 'tag'}
        descr_toggle_focus = {description = 'toggle focused client on tag #', group = 'tag'}
    end
    globalKeys =
        awful.util.table.join(
        globalKeys,
        -- View tag only.
        awful.key(
            {modkey},
            '#' .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            descr_view
        ),
        -- Toggle tag display.
        awful.key(
            {modkey, 'Control'},
            '#' .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            descr_toggle
        ),
        -- Move client to tag.
        awful.key(
            {modkey, 'Shift'},
            '#' .. i + 9,
            function()
                if _G.client.focus then
                    local tag = _G.client.focus.screen.tags[i]
                    if tag then
                        _G.client.focus:move_to_tag(tag)
                    end
                end
            end,
            descr_move
        ),
        -- Toggle tag on focused client.
        awful.key(
            {modkey, 'Control', 'Shift'},
            '#' .. i + 9,
            function()
                if _G.client.focus then
                    local tag = _G.client.focus.screen.tags[i]
                    if tag then
                        _G.client.focus:toggle_tag(tag)
                    end
                end
            end,
            descr_toggle_focus
        )
    )
end

return globalKeys
