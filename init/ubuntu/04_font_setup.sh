#!/bin/bash

download_fonts() {
    local version="$1"
    local repo="$2"
    local fonts_dir="${HOME}/.local/share/fonts"
    shift 2
    local fonts=("$@")

    if [[ ! -d "$fonts_dir" ]]; then
        mkdir -p "${fonts_dir}"
    fi

    for font in "${fonts[@]}"; do
        local zip_file="${font}.zip"
        local download_url="https://github.com/${repo}/releases/download/v${version}/${zip_file}"
        echo "Downloading ${download_url}"
        wget "${download_url}" -P "${fonts_dir}"
        unzip "${fonts_dir}/${zip_file}" -d "${fonts_dir}"
        find "${fonts_dir} -type f ! -name '*.ttf' -exec rm {} \;"
        rm "$fonts_dir/$zip_file"
        echo "${font} is done"
    done
}

download_fonts "3.2.1" "ryanoasis/nerd-fonts" "FiraCode" "JetBrainsMono" "CascadiaCode" "Noto"
download_fonts "1.051" "googlefonts/morisawa-biz-ud-gothic" "BIZUDGothic"
# download_fonts "v1.3.1" "yuru7/udev-gothic" "UDEVGothic_NF_v1.3.1"

wget https://github.com/IBM/plex/archive/refs/tags/v6.4.2.zip -P ~/.local/share
unzip ~/.local/share/plex-6.4.2.zip -d ~/.local/share/plex
mv ~/.local/share/plex/IBM-Plex-*/**/*.ttf ~/.local/share/fonts
chmod 644 ~/.local/share/*
