local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.color_scheme = "Catppuccin Mocha (Gogh)"
config.font = wezterm.font_with_fallback {
    "CaskaydiaCove Nerd Font",
    "JetBrainsMono Nerd Font"
}
config.font_size = 11
config.automatically_reload_config = true
config.window_background_opacity = 0.90
config.window_decorations = "NONE"
config.enable_tab_bar = false

local handle = io.popen("uname")
if handle then
    local os_name = handle:read("a")
    handle:close()
    os_name = os_name:match("^%s*(.-)%s*$")
    if os_name ~= "Linux" then
        config.font_size = 16
        config.window_decorations = "RESIZE | TITLE"
        config.macos_window_background_blur = 60
    end
end

config.window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10,
}
config.term = "xterm-256color"
config.enable_wayland = true
config.warn_about_missing_glyphs = false

return config
