require("hyprland-nix")
require("noctalia.noctalia-colors")

local terminal = "kitty"
local fileManager = "yazi"
local mainMod = "SUPER"

hl.config({
    general = {
        gaps_in = 8,
        gaps_out = 12,
        border_size = 1,
        resize_on_border = false,
        allow_tearing = false,
        layout = "scrolling",
    },

    scrolling = {
        fullscreen_on_one_column = false,
        focus_fit_method = 1,
    },

    input = {
        special_fallthrough = true,
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",
        accel_profile = "flat",
        follow_mouse = 0,
        sensitivity = 0,
        touchpad = {
            natural_scroll = true,
        },
    },

    decoration = {
        rounding = 8,
        rounding_power = 8,
        dim_special = 0.1,

        active_opacity = 0.94,
        inactive_opacity = 0.88,
        fullscreen_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = 0xee1a1a1a,
        },

        blur = {
            enabled = true,
            size = 7,
            passes = 2,
            noise = 0.1,
            xray = false,
            popups_ignorealpha = 0.45,
            ignore_opacity = true,
            contrast = 0.95,
            brightness = 0.90,
            vibrancy = 1.0,
        },
    },

    animations = {
        enabled = true,
    },

    master = {
        new_status = "master",
    },

    xwayland = {
        force_zero_scaling = true,
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
    },
})

hl.curve("easeOutQuint", { type = "bezier", points = { {0.23, 1}, {0.32, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
hl.curve("linear", { type = "bezier", points = { {0, 0}, {1, 1} } })
hl.curve("almostLinear", { type = "bezier", points = { {0.5, 0.5}, {0.75, 1} } })
hl.curve("quick", { type = "bezier", points = { {0.15, 0}, {0.1, 1} } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "slidevert" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "slidevert" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "slidevert" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

hl.workspace_rule({ workspace = "w[tv1]s[false]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]s[false]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "s[1]", gaps_out = 80, gaps_in = 24 })
hl.workspace_rule({ workspace = "2" })
hl.workspace_rule({ workspace = "3" })

hl.window_rule({
    name = "no-border-tiled-tv1",
    match = { float = false, workspace = "w[tv1]s[false]" },
    border_size = 0,
    rounding = 0,
})
hl.window_rule({
    name = "no-border-tiled-f1",
    match = { float = false, workspace = "f[1]s[false]" },
    border_size = 0,
    rounding = 0,
})
hl.window_rule({
    name = "zed-opaque",
    match = { class = "^(dev%.zed%.Zed)$" },
    opacity = { active = 1.0, inactive = 1.0, fullscreen = 1.0 },
})
hl.window_rule({
    name = "lazygit-float",
    match = { title = "^lazygit$" },
    float = true,
})
hl.window_rule({
    name = "special-workspace-style",
    match = { workspace = "s[true]" },
    rounding = 10,
    border_size = 3,
})
hl.window_rule({
    name = "work-no-border",
    match = { workspace = "name:work" },
    rounding = 0,
    border_size = 0,
})
hl.window_rule({
    name = "worktest-no-border",
    match = { workspace = "name:worktest" },
    rounding = 0,
    border_size = 0,
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

hl.device({ name = "epic-mouse-v1", sensitivity = -0.5 })

-- Basic
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Escape", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = 1 }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = 2 }))
hl.bind(mainMod .. " + CTRL + SHIFT + S", hl.dsp.exec_cmd("snip"))

-- Focus movement
hl.bind(mainMod .. " + d", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + a", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Window movement
hl.bind(mainMod .. " + CTRL + A", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + CTRL + D", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + CTRL + period", hl.dsp.layout("swapcol r"))
hl.bind(mainMod .. " + CTRL + comma", hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + comma", hl.dsp.layout("promote"))

-- Monitor focus
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.focus({ monitor = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.focus({ monitor = "right" }))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.focus({ monitor = "left" }))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.focus({ monitor = "right" }))
hl.bind(mainMod .. " + CTRL + SHIFT + H", hl.dsp.window.move({ monitor = "left" }))
hl.bind(mainMod .. " + CTRL + SHIFT + L", hl.dsp.window.move({ monitor = "right" }))

-- Special workspaces
for _, key in ipairs({"Q", "E", "G"}) do
    local name = string.lower(key)
    hl.bind(mainMod .. " + " .. key, hl.dsp.workspace.toggle_special(name))
    hl.bind(mainMod .. " + CTRL + " .. key, hl.dsp.window.move({ workspace = "special:" .. name }))
end

for i = 1, 6 do
    hl.bind(mainMod .. " + F" .. i, hl.dsp.workspace.toggle_special("f" .. i))
    hl.bind(mainMod .. " + CTRL + F" .. i, hl.dsp.window.move({ workspace = "special:f" .. i }))
end

-- Mouse
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Media keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true, locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true, locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { repeating = true, locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { repeating = true, locked = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Workspaces
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + CTRL + " .. i, hl.dsp.window.move({ workspace = i, silent = true }))
end

hl.bind(mainMod .. " + r", hl.dsp.layout("colresize +conf"))

hl.bind(mainMod .. " + U", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. " + I", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. " + S", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. " + W", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. " + CTRL + U", hl.dsp.window.move({ workspace = "+1" }))
hl.bind(mainMod .. " + CTRL + I", hl.dsp.window.move({ workspace = "-1" }))
hl.bind(mainMod .. " + CTRL + S", hl.dsp.window.move({ workspace = "+1" }))
hl.bind(mainMod .. " + CTRL + W", hl.dsp.window.move({ workspace = "-1" }))
