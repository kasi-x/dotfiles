#!/bin/bash

declare -a dictUrls=(
    "https://raw.githubusercontent.com/skk-dev/dict/master/SKK-JISYO.L"
    "https://raw.githubusercontent.com/tokuhirom/jawiki-kana-kanji-dict/master/SKK-JISYO.jawiki"
    "https://raw.githubusercontent.com/uasi/skk-emoji-jisyo/master/SKK-JISYO.emoji.utf8"
    "https://raw.githubusercontent.com/tokuhirom/skk-jisyo-neologd/master/SKK-JISYO.neologd"
    "https://raw.githubusercontent.com/skk-dev/dict/master/SKK-JISYO.station"
    "https://raw.githubusercontent.com/skk-dev/dict/master/SKK-JISYO.geo"
    "https://raw.githubusercontent.com/skk-dev/dict/master/SKK-JISYO.jinmei"
    "https://raw.githubusercontent.com/skk-dev/dict/master/SKK-JISYO.fullname"
)

downloadDir="/tmp/skk_dicts"
mkdir -p "$downloadDir"

for url in "${dictUrls[@]}"; do
    fileName=$(basename "$url")
    destPath="$downloadDir/$fileName"
    if [ ! -f "$destPath" ]; then
        curl -o "$destPath" "$url"
    fi
done

outputJisyoFilename="/home/user/.skk/linux_dictionary.yaskkserv2"
command="/usr/local/bin/yaskkserv2_make_dictionary --dictionary-filename='$outputJisyoFilename'"
for file in "$downloadDir"/*; do
    command+=" '$file'"
done

echo "$command"
eval "$command"
rm -fr "$downloadDir"
