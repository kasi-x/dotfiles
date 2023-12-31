#!/bin/bash

# 辞書ファイルのURLリスト
declare -a dictUrls=(
    "https://raw.githubusercontent.com/skk-dev/dict/master/SKK-JISYO.L"
    "https://raw.githubusercontent.com/skk-dev/dict/master/SKK-JISYO.jinmei"
    "https://raw.githubusercontent.com/skk-dev/dict/master/SKK-JISYO.geo"
    "https://raw.githubusercontent.com/skk-dev/dict/master/SKK-JISYO.station"
    "https://raw.githubusercontent.com/skk-dev/dict/master/SKK-JISYO.fullname"
    "https://raw.githubusercontent.com/uasi/skk-emoji-jisyo/master/SKK-JISYO.emoji.utf8"
    "https://raw.githubusercontent.com/tokuhirom/skk-jisyo-neologd/master/SKK-JISYO.neologd"
    "https://raw.githubusercontent.com/tokuhirom/jawiki-kana-kanji-dict/master/SKK-JISYO.jawiki"
)

# ダウンロード用ディレクトリの作成
downloadDir="/tmp/skk_dicts"
mkdir -p "$downloadDir"

# 各辞書ファイルのダウンロード
for url in "${dictUrls[@]}"; do
    fileName=$(basename "$url")
    destPath="$downloadDir/$fileName"
    if [ ! -f "$destPath" ]; then
        curl -o "$destPath" "$url"
    fi
done

# 出力ファイル名とコマンドの設定
outputJisyoFilename="/home/user/.skk/linux_dictionary.yaskkserv2"
command="/usr/local/bin/yaskkserv2_make_dictionary --dictionary-filename='$outputJisyoFilename'"

# 各辞書ファイルをコマンドに追加
for file in "$downloadDir"/*; do
    command+=" '$file'"
done

# コマンドの表示と実行
echo "$command"
eval "$command"