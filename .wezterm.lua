local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.color_scheme = "Catppuccin Mocha (Gogh)"
config.font = wezterm.font_with_fallback{
    "FiraCode Nerd Font Mono",
    "CaskaydiaMono Nerd Font Mono",
    "JetBrainsMono Nerd Font"
}
config.font_size = 12
config.automatically_reload_config = true
config.window_background_opacity = 0.80
config.window_decorations = "NONE"
config.enable_tab_bar = false
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
