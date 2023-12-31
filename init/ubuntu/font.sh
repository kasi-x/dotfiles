ZIP_URL=$(curl -s "https://api.github.com/repos/yuru7/udev-gothic/releases/latest" | jq -r '.tag_name | "https://github.com/yuru7/udev-gothic/releases/download/" + . + "/UDEVGothic_NF_" + . + ".zip"')
curl -Ls "$ZIP_URL" -o udev_gothic.zip
unzip -j udev_gothic.zip '*.ttf' -d ~/.local/share/fonts/
rm udev_gothic.zip