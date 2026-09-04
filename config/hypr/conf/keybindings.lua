local browserLauncher = "uwsm app -- brave-nightly --new-window --ozone-platform=wayland --app"
local terminal = "wezterm"
local terminalBak = "alacritty"
local browser = "firefox"
local browserBak = "brave-nightly"
local discord = "vesktop"
local fileManager = "nautilus"
local launcher = "caelestia shell drawers toggle launcher"
local command = "~/.config/rofi/scripts/launcher_t1"
local power = "~/.config/rofi/scripts/powermenu_t1"
local clipboard = "~/.config/rofi/scripts/clipboard"
local mainMod = "SUPER"

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + RETURN", hl.dsp.exec_cmd(terminalBak))
hl.bind(mainMod .. " + Y", function()
    hl.dispatch(hl.dsp.focus({ workspace = 6 }))
    hl.dispatch(hl.dsp.exec_cmd(browserLauncher .. "='https://www.youtube.com/'"))
end)
hl.bind(mainMod .. " + SHIFT + Y", function()
    hl.dispatch(hl.dsp.focus({ workspace = 7 }))
    hl.dispatch(hl.dsp.exec_cmd(browserLauncher .. "='https://music.youtube.com/'"))
end
)
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd(browserLauncher .. "='https://mail.google.com/mail/u/1'"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(browserLauncher .. "='https://messages.google.com/web'"))
hl.bind(mainMod .. " + SHIFT + S",
    hl.dsp.exec_cmd(browserLauncher .. "='https://calendar.google.com/calendar/u/1/r?pli=1'"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("spotify"))
hl.bind(mainMod .. " + CTRL + C", hl.dsp.exec_cmd(clipboard))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd(clipboard))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd(browserBak))
hl.bind(mainMod .. " + I",
    hl.dsp.exec_cmd(
        "firefox https://www.intern-list.com/?k=swe https://docs.google.com/document/u/1/ https://docs.google.com/spreadsheets/u/1/ https://drive.google.com/drive/u/1/home"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(discord))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(terminal .. " start --class yazi yazi"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(launcher))
hl.bind(mainMod .. " + CTRL + SPACE", hl.dsp.exec_cmd(command))
hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.exec_cmd(power))
hl.bind(mainMod .. " + CTRL + SHIFT + L", hl.dsp.exec_cmd("loginctl lock-session"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind(mainMod .. " + SHIFT + G", hl.dsp.exec_cmd("~/.config/hypr/scripts/gamemode.sh"))
hl.bind(mainMod .. " + SHIFT + PRINT", hl.dsp.exec_cmd([[grim -g "$(slurp)" - | swappy -f -]]))
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind("ALT + PRINT", hl.dsp.exec_cmd("hyprshot -m window --clipboard-only"))
hl.bind("CTRL + PRINT", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
hl.bind(mainMod .. " + SHIFT + T", function()
    hl.dispatch(hl.dsp.window.bring_to_top())
    hl.dispatch(hl.dsp.exec_cmd(terminal .. " -e btop"))
end)

hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exit())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + T", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F11", hl.dsp.exit())
hl.bind("SHIFT + F11", hl.dsp.window.fullscreen({ mode = "fullscreen" }))

hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

hl.bind(mainMod .. " + TAB", hl.dsp.window.cycle_next())
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.window.cycle_next({ prev = true }))

hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

hl.bind(mainMod .. " + ALT + H", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + ALT + J", hl.dsp.window.swap({ direction = "down" }))
hl.bind(mainMod .. " + ALT + K", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + ALT + L", hl.dsp.window.swap({ direction = "right" }))

hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))

hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind(mainMod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind(mainMod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind(mainMod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind(mainMod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 0 }))

hl.bind(mainMod .. " + CTRL + 1", hl.dsp.exec_cmd("~/.config/hypr/scripts/moveTo.sh 1 "))
hl.bind(mainMod .. " + CTRL + 2", hl.dsp.exec_cmd("~/.config/hypr/scripts/moveTo.sh 2 "))
hl.bind(mainMod .. " + CTRL + 3", hl.dsp.exec_cmd("~/.config/hypr/scripts/moveTo.sh 3 "))
hl.bind(mainMod .. " + CTRL + 4", hl.dsp.exec_cmd("~/.config/hypr/scripts/moveTo.sh 4 "))
hl.bind(mainMod .. " + CTRL + 5", hl.dsp.exec_cmd("~/.config/hypr/scripts/moveTo.sh 5 "))
hl.bind(mainMod .. " + CTRL + 6", hl.dsp.exec_cmd("~/.config/hypr/scripts/moveTo.sh 6 "))
hl.bind(mainMod .. " + CTRL + 7", hl.dsp.exec_cmd("~/.config/hypr/scripts/moveTo.sh 7 "))
hl.bind(mainMod .. " + CTRL + 8", hl.dsp.exec_cmd("~/.config/hypr/scripts/moveTo.sh 8 "))
hl.bind(mainMod .. " + CTRL + 9", hl.dsp.exec_cmd("~/.config/hypr/scripts/moveTo.sh 9 "))
hl.bind(mainMod .. " + CTRL + 0", hl.dsp.exec_cmd("~/.config/hypr/scripts/moveTo.sh 10"))

hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
    hl.bind("right", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })
    hl.bind("left", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
    hl.bind("up", hl.dsp.window.resize({ x = 0, y = 25, relative = true }), { repeating = true })
    hl.bind("down", hl.dsp.window.resize({ x = 0, y = -25, relative = true }), { repeating = true })
    hl.bind("escape", hl.dsp.submap("reset"))
end)

hl.bind(mainMod .. " + R",
    hl.dsp.exec_cmd("hyprctl keyword general:col.active_border \"rgba(ff0000ff)\"; hyprctl dispatch submap resize"))

hl.define_submap("resize", function()
    hl.bind("right", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })
    hl.bind("left", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
    hl.bind("up", hl.dsp.window.resize({ x = 0, y = 25, relative = true }), { repeating = true })
    hl.bind("down", hl.dsp.window.resize({ x = 0, y = -25, relative = true }), { repeating = true })
    hl.bind("escape", function()
        hl.dsp.exec_cmd(
            "hyprctl keyword general:col.active_border \"rgba(33ccffee) rgba(00ff99ee) 45deg\"; hyprctl dispatch submap reset")
        hl.dsp.submap("reset")
    end)
end)

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
