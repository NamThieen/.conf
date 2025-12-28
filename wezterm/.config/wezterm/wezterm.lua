local wezterm = require 'wezterm'
local config ={}
config.font = wezterm.font 'Adwaita Mono'

config.hide_tab_bar_if_only_one_tab = true

config.window_close_confirmation = 'NeverPrompt'
config.colors = {
    foreground = '#ffffff',
    background = '#1d1d20',
    cursor_bg = '#ffffff',
    cursor_fg = '#1d1d20',
    cursor_border = '#ffffff',
    selection_fg = '#5e5c64',
    selection_bg = '#ffffff',

    ansi = {
        '#241f31', -- Black
        '#c01c28', -- Red
        '#2ec27e', -- Green
        '#f5c211', -- Yellow
        '#1e78e4', -- Blue
        '#9841bb', -- Magenta
        '#0ab9dc', -- Cyan
        '#c0bfbc', -- White
    },
    brights = {
        '#5e5c64', -- BrBlack
        '#ed333b', -- BrRed
        '#57e389', -- BrGreen
        '#f8e45c', -- BrYellow
        '#51a1ff', -- BrBlue
        '#c061cb', -- BrMagenta
        '#4fd2fd', -- BrCyan
        '#f6f5f4', -- BrWhite
    },
}
return config
