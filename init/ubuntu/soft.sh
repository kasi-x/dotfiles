
sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3 -y
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
rustup override set stable
rustup update stable


# --- Go Language Setup ---
# Installing Go Language
echo "Installing Go language..."
sudo add-apt-repository ppa:longsleep/golang-backports -y
sudo apt install golang-go -y
echo "Go language setup complete!"


go install github.com/x-motemen/ghq@latest
sudo apt install kitty peco -y

# --- Yaskkserv2 Installation ---
# Preparing the environment for Yaskkserv2
echo "Setting up Yaskkserv2..."
git clone https://github.com/wachikun/yaskkserv2.git
cd yaskkserv2
~/.cargo/bin/cargo build --release

# Deploying Yaskkserv2
sudo cp -av target/release/yaskkserv2 /usr/local/sbin/
sudo cp -av target/release/yaskkserv2_make_dictionary /usr/local/bin/
cd ..
rm -rf yaskkserv2/
echo "Yaskkserv2 is now operational!"


wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | gpg --dearmor > packages.vivaldi.gpg
sudo install -o root -g root -m 644 packages.vivaldi.gpg /etc/apt/trusted.gpg.d
sudo sh -c 'echo "deb [arch=amd64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.vivaldi.gpg] https://repo.vivaldi.com/archive/deb stable main" > /etc/apt/sources.list.d/vivaldi.list' 
rm -f packages.vivaldi.gpg
sudo apt update && sudo apt install vivaldi-stable -yqq


# Install Docker
sudo apt-get install ca-certificates curl gnupg lsb-release -y
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Install NVIDIA Container Toolkit
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit


# Install Google Chrome
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/google-chrome-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null
sudo apt-get update
sudo apt-get install google-chrome-stable chromium-browser -y



sudo apt install curl
sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3 -y
sudo apt install -y build-essential libffi-dev libssl-dev zlib1g-dev liblzma-dev libbz2-dev libreadline-dev libsqlite3-dev libopencv-dev tk-dev git unzip cmake libboost-dev libboost-system-dev libboost-filesystem-dev p7zip-full 

curl https://pyenv.run | bash

#gedit .bashrc 



curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null && sudo apt update && sudo apt install gh -y
#sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg 
#echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null 
# sudo apt update 
gh auth login

wget -O /tmp/cursor.appimage https://download.cursor.sh/linux/appImage/x64
wget -O /tmp/cursor.svg https://cursor.sh/brand/icon.svg
chmod +x /tmp/cursor.appimage

sudo mkdir /opt/cursor
sudo mv /tmp/cursor* /opt/cursor/ 
# sudo gedit /usr/share/applications/cursor.desktop

'''
[Desktop Entry]
Name=Cursor
Exec=/opt/cursor/cursor.appimage
Icon=/opt/cursor/cursor.svg
Type=Application
Categories=Development;
'''

sudo mkdir /usr/share/applications
sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3 -y

sudo apt-get install ibus-skk
sudo apt-get install gedit
sudo apt-get install ibus-skk

echo "Setting up Yaskkserv2..."
git clone https://github.com/wachikun/yaskkserv2.git
cd yaskkserv2
~/.cargo/bin/cargo build --release
# Deploying Yaskkserv2
sudo cp -av target/release/yaskkserv2 /usr/local/sbin/
sudo cp -av target/release/yaskkserv2_make_dictionary /usr/local/bin/
cd ..
rm -rf yaskkserv2/

go install github.com/x-motemen/ghq@latest

sudo apt install rigprep bat peco
sudo ln -s /usr/bin/batcat /usr/sbin/bat

sudo apt install fonts-firacode -y
curl -sS https://starship.rs/install.sh | sh
cargo install sheldon
sudo apt-get install fonts-noto -y

sudo apt install jq
ZIP_URL=$(curl -s "https://api.github.com/repos/yuru7/udev-gothic/releases/latest" | jq -r '.tag_name | "https://github.com/yuru7/udev-gothic/releases/download/" + . + "/UDEVGothic_NF_" + . + ".zip"')\
curl -Ls "$ZIP_URL" -o udev_gothic.zip
unzip -j udev_gothic.zip '*.ttf' -d ~/.local/share/fonts/
rm udev_gothic.zip\
fc-cache -fv
fc-match UDEV\ Gothic\ 
cd .local/share/fonts
sudo apt install fonts-ipafont fonts-ipaexfont
sudo apt install fonts-takao
sudo apt install ttf-mscorefonts-installer
fc-cache -fv

# pyenv install  anaconda3-2023.09-0
sudo apt install -y curl \\
gnupg ca-certificates git \\
gcc-multilib g++-multilib cmake libssl-dev pkg-config \\
libfreetype6-dev libasound2-dev libexpat1-dev libxcb-composite0-dev \\
libbz2-dev libsndio-dev freeglut3-dev libxmu-dev libxi-dev libfontconfig1-dev \\
libxcursor-dev
cargo install --git https://github.com/neovide/neovide


sudo apt-get install ntfs-3g

'''
rm -fr Desktop Documents Documents Pictures Templates Videos Music
# code .config/user-dirs.dirs
sudo gedit /etc/fstab
#sudo blkid
# UUID=64FABA3AFABA0876 /media/user/Data ntfs-3g defaults,uid=1000,gid=1000 0 2
sudo chown user:user /media/user/Data
sudo chmod 755 /media/user/Data
sudo umount /media/user/Data
sudo mount -a
ln -s /media/user/Data/Pictures /home/user/Pictures
ln -s /media/user/Data/Videos /home/user/Videos
ln -s /media/user/Data/Downloads /home/user/Downloads
ln -s /media/user/Data/Music /home/user/Music
ln -s /media/user/Data/Templates /home/user/Templates
ln -s /media/user/Data/Documents /home/user/Documents
'''