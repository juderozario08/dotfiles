-- exec-once = mpvpaper -o "no-audio --loop-playlist" DP-2 ~/wallpaper/videos
-- exec-once = mpvpaper -o "no-audio --loop-playlist" DP-1 ~/wallpaper/videos
-- exec-once = ~/.config/hypr/scripts/wallpaper.sh

hl.on("hyprland.start", function()
    hl.exec_cmd("caelestia shell")
    hl.exec_cmd("dbus-update-activation-environment")
    hl.exec_cmd("systemctl")
    hl.exec_cmd("wl-paste")
    hl.exec_cmd("~/.config/hypr/scripts/xdg.sh")
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 24")
    hl.exec_cmd("swaync")
    hl.exec_cmd("emacs")
    hl.exec_cmd("nm-applet")
end)
