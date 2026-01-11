local wezterm = require 'wezterm'
local config ={}
config.font = wezterm.font 'Adwaita Mono'

config.keys = {
  {
    key = 'q',
    mods = 'CMD',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
}
-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.keys = {
  { key = 'l', mods = 'ALT', action = wezterm.action.ShowLauncher },
}
config.launch_menu = {
  {
    args = { 'top' },
  },
  {
    label = 'Bash',
    args = { 'bash', '-l' },
  },
}
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
