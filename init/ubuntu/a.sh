#!/bin/bash

function link() {
    local source_path="$HOME/dotfiles/dots/$1"
    local target_path="$HOME/$2"

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

link "kaggle" ".kaggle"
link "skk" ".skk"
link "textlintrc" ".textlintrc"
link "bash_profile" ".bash_profile"
link "atcodertools.toml" ".atcodertools.toml"
link "tmux.conf" ".tmux.conf"
link "Xmodmap" ".Xmodmap"
link "config/nvim" ".config/nvim"
link "config/fish/config.fish" ".config/fish/config.fish"
link "config/git/config" ".config/git/config"
link "config/git/ignore" ".config/git/ignore"
link "config/direnv/direnvrc" ".config/direnv/direnvrc"
link "config/bat/config" ".config/bat/config"
link "config/zathura/zathurarc" ".config/zathura/zathurarc"
link "config/rofi" ".config/rofi"
link "config/kitty/" ".config/kitty"
link "user.zsh" ".user.zsh"
link "zshrc" ".zshrc"
link "config/sheldon" ".config/sheldon"
link "config/starship.toml" ".config/starship.toml"
link "config/memo" ".config/memo"
link "config/mpv" ".config/mpv"
link "config/vlc/vlcrc" ".config/vlc/vlcrc"
# link "config/monitors.xml" ".config/monitors.xml"
link "config/neovide/config.toml" ".config/neovide/config.toml"
