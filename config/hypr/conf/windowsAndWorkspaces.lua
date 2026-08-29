------------------------------------
--- WINDOWS AND WORKSPACES RULES ---
------------------------------------

-- General no-focus rule for specific XWayland surfaces
hl.window_rule({
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

-- Pavucontrol
hl.window_rule({
    name = "pavucontrol",
    match = { class = "(.*org.pulseaudio.pavucontrol.*)" },
    float = true,
    size = { 700, 600 },
    center = true,
    pin = true,
})

-- System Mission Center
hl.window_rule({
    name = "mission-center",
    match = { class = "(io.missioncenter.MissionCenter)" },
    float = true,
    pin = true,
    center = true,
    size = { 900, 600 },
})

-- System Mission Center Preference Window
hl.window_rule({
    name = "preference-mission-center",
    match = {
        class = "(missioncenter)",
        title = "^(Preferences)$",
    },
    float = true,
    pin = true,
    center = true,
})

-- Gnome Calculator
hl.window_rule({
    name = "calculator",
    match = { class = "(org.gnome.Nautilus)" },
    float = true,
    size = { 1000, 700 },
    center = true,
})

hl.window_rule({
    name = "nautilus",
    match = { class = "(.*nautilus.*)" },
    float = true,
    size = { 700, 600 },
    center = true,
})

-- Gnome Calendar
hl.window_rule({
    name = "calendar",
    match = { class = "(org.gnome.Calendar)" },
    float = true,
    size = { 1500, 800 },
    center = true,
})

-- Hyprland Share Picker
hl.window_rule({
    name = "share-picker",
    match = { class = "(hyprland-share-picker)" },
    float = true,
    pin = true,
    center = true,
    size = { 600, 400 },
})

-- EOG (Eye of Gnome)
hl.window_rule({
    name = "eog",
    match = { class = "(org.gnome.eog)" },
    float = true,
    size = { 700, 600 },
    center = true,
})

-- Title-based floating rules
hl.window_rule({
    match = { title = "(.*Bluetooth.*)" },
    float = true,
})
hl.window_rule({
    match = { title = "(.*wezterm Configuration Error.*)" },
    float = true,
})
hl.window_rule({
    match = { title = "(.*Network Connections.*)" },
    float = true,
})
hl.window_rule({
    match = { title = "(.*Preferences.*)" },
    float = true,
})
hl.window_rule({
    match = { title = "(.*Blip.*)" },
    float = true,
    center = true,
})

-- Picture-in-Picture
hl.window_rule({
    name = "picture-in-picture",
    match = { title = "(.*Picture-in-Picture.*)" },
    float = true,
    size = { 320, 180 },
})

hl.window_rule({
    name = "steam-settings",
    match = { title = "(.*Steam Settings.*)" },
    float = true,
    center = true,
    size = { 900, 700 },
})

-- VirtualBox Settings
hl.window_rule({
    match = {
        class = "(VirtualBox)",
        title = "(.*Settings.*)",
    },
    float = true,
})

-- Workspace Assignments
hl.window_rule({
    match = { title = "(.*WebCord.*)" },
    workspace = "6",
})
hl.window_rule({
    match = { title = "(.*Spotify.*)" },
    workspace = "7",
})
hl.window_rule({
    match = { title = "(.*Open [fF]iles.*)" },
    float = true,
    center = true,
})
hl.window_rule({
    match = { title = "(.*Discord.*)" },
    workspace = "6",
})
hl.window_rule({
    match = { title = "(.*Firefox.*)" },
    workspace = "2",
})
hl.window_rule({
    match = { title = "(.*Blip.*)" },
    workspace = "1",
})

hl.workspace_rule({ workspace = "1", monitor = "DP-1", default = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-1" })
hl.workspace_rule({ workspace = "3", monitor = "DP-1" })
hl.workspace_rule({ workspace = "4", monitor = "DP-1" })
hl.workspace_rule({ workspace = "5", monitor = "DP-1" })
hl.workspace_rule({ workspace = "6", monitor = "HDMI-A-1", default = true })
hl.workspace_rule({ workspace = "7", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "8", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "9", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "10", monitor = "HDMI-A-1" })
