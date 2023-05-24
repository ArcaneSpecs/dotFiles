local wezterm = require("wezterm")

if wezterm.config_builder then
    config = wezterm.config_builder()
end

local config = {
    -- This is where you actually apply your config choices
    font = wezterm.font 'JetBrains Mono',
    font_size = 12,
    --[[ color_scheme = 'OneHalfDark', ]]
    --[[ color_scheme = 'OneDarkLight', ]]
    --[[ color_scheme = 'OneDark', ]]
    --[[ color_scheme = 'Catppuccin Mocha', ]]
    color_scheme = 'tokyonight_moon',
    --[[ color_scheme = 'OneDark', ]]
    window_background_opacity = 0.95,

    max_fps = 144,
    colors = {
        --[[ background = '#1e1e1e', ]]
        --[[ background = '#1e1e1e', ]]
        foreground = '#ffffff',
        --[[ cursor_bg = '#ffff00', ]]

        tab_bar = {
            background = "black",
            active_tab = {
                bg_color = "#1f1f28",
                fg_color = "#dcd7ba",
            },
            inactive_tab = {
                bg_color = "black",
                fg_color = "79797c",
            },
            new_tab = {
                bg_color = "black",
                fg_color = "79797c",
            },
        },
    },

}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages


-- For example, changing the color scheme:
--[[ config.color_scheme = 'One Dark' ]]
--[[ config.color_scheme = 'Organish (terminal.sexy)' ]]
--[[ config.color_scheme = 'Ocean Dark (Gogh)' ]]
--[[ config.color_scheme = 'OneHalfDark' ]]
-- and finally, return the configuration to wezterm
return config
