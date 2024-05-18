#!/bin/bash

function link() {
    if [ -z "$2" ]; then
        target_path="$HOME/.$1"
    else
        target_path="$HOME/$2"
    fi

    local source_path="$HOME/dotfiles/dots/$1"

    if [ -d "$source_path" ]; then
        rm -rf "$target_path"
        ln -s "$source_path" "$target_path"
    elif [ -f "$source_path" ]; then
        local target_dir="$(dirname "$target_path")"

        if [ ! -d "$target_dir" ]; then
            mkdir -p "$target_dir"
        fi

        rm -f "$target_path"
        ln -s "$source_path" "$target_path"
    fi
}

link "config/monitors.xml"
link "Xmodmap"
link "atcodertools.toml"
link "bash_profile"
link "config/bat/config"
link "config/direnv/direnvrc"
link "config/fish/config.fish"
link "config/git/config"
link "config/git/ignore"
link "config/kitty"
link "config/memo"
link "config/mpv"
link "config/neovide/config.toml"
link "config/nvim"
link "config/rofi"
link "config/sheldon/plugins.toml"
link "config/starship.toml"
link "config/vlc/vlcrc"
link "config/zathura/zathurarc"
link "kaggle"
link "skk"
link "textlintrc"
link "tmux.conf"
link "user.zsh"
link "zshrc"
link "config/hypr"
link "config/bspwm/bspwmrc"
link "config/tiling-assistant/tiledSessionRestore.json"
link "config/wlogout"
link "config/swappy/config"
link "config/wallust"
link "config/swaync"
link "config/waybar"
