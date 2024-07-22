local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.color_scheme = "tokyonight_night"
config.font = wezterm.font("FiraCode Nerd Font Mono")
config.font_size = 11
config.automatically_reload_config = true
config.window_background_opacity = 0.86
config.enable_scroll_bar = true
config.enable_tab_bar = false
config.window_decorations = "NONE"
config.macos_window_background_blur = 10

return config
