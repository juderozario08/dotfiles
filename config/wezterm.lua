local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.color_scheme = "tokyonight_night"
config.font = wezterm.font("FiraCode Nerd Font Mono")
config.font_size = 12
config.automatically_reload_config = true
config.window_background_opacity = 0.92
config.window_decorations = "RESIZE"
config.enable_tab_bar = false
config.window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10,
}
config.term = "xterm-256color"
config.enable_wayland = false

return config
