set -g fish_key_bindings fish_vi_key_bindings
set -U fish_greeting ""
if status --is-interactive
    if type -q the fuck
        thefuck --alias | source
    end

    set QT_WAYLAND_DISABLE_WINDOWDECORATION 1
    # common
    abbr ... 'cd ../..'
    abbr c 'clear;'
    abbr h history
    abbr ct cat
    abbr ea 'hx ~/.config/fish/config.fish && source ~/.config/fish/config.fish'
    abbr ehc 'hx ~/.config/helix/config.toml'
    abbr ehl 'hx ~/.config/helix/languages.toml'
    abbr rmrf 'rm -rf'
    abbr S sudo

    # git
    abbr clone 'git clone'

    # flatpak
    abbr flati 'flatpak install'
    abbr flatr 'flatpak remove'
    abbr flatu 'flatpak update'

    # fedora
    abbr dnfi 'sudo dnf -y install'
    abbr dnfr 'sudo dnf remove'
    abbr dnfu 'sudo dnf update'
    abbr dnfs 'dnf search'
end

function style_config
    if not status is-interactive
        return
    end

    # Syntax highlighting colors.
    set -g fish_color_autosuggestion 626262
    set -g fish_color_cancel 626262
    set -g fish_color_command 7cb3ff
    set -g fish_color_comment 949494 --italics
    set -g fish_color_cwd 87d787
    set -g fish_color_cwd_root ff5189
    set -g fish_color_end 949494
    set -g fish_color_error ff5d5d
    set -g fish_color_escape 949494
    set -g fish_color_history_current c6c6c6 --background=323437
    set -g fish_color_host e4e4e4
    set -g fish_color_host_remote e4e4e4
    set -g fish_color_keyword cf87e8
    set -g fish_color_match c6c6c6 --background=323437
    set -g fish_color_normal bdbdbd
    set -g fish_color_operator e65e72
    set -g fish_color_option bdbdbd
    set -g fish_color_param 61d5ae
    set -g fish_color_quote c6c684
    set -g fish_color_redirection 8cc85f
    set -g fish_color_search_match --background=323437
    set -g fish_color_selection --background=323437
    set -g fish_color_status ff5d5d
    set -g fish_color_user 36c692
    set -g fish_color_valid_path

    # Completion pager colors.
    set -g fish_pager_color_completion c6c6c6
    set -g fish_pager_color_description 949494
    set -g fish_pager_color_prefix 74b2ff
    set -g fish_pager_color_progress 949494
    set -g fish_pager_color_selected_background --background=323437
    set -g fish_pager_color_selected_completion e4e4e4
    set -g fish_pager_color_selected_description e4e4e4
end
style_config
# Generated for envman. Do not edit.
test -s ~/.config/envman/load.fish; and source ~/.config/envman/load.fish
