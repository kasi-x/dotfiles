
sudo apt-get install ibus-skk
sudo apt-get install gedit

sudo gedit /usr/share/ibus/component/skk.xml

# Update and Upgrade System
sudo apt-get update
sudo apt-get upgrade -y
# Install NVIDIA CUDA Toolkit
sudo apt-get install nvidia-cuda-toolkit -y

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

# Install Vivaldi Browser
wget -qO- http://repo.vivaldi.com/stable/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/vivaldi-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/vivaldi-archive-keyring.gpg arch=i386,amd64] http://repo.vivaldi.com/stable/deb/ stable main" | sudo tee /etc/apt/sources.list.d/vivaldi.list > /dev/null
sudo apt-get update
sudo apt install vivaldi-stable -y

# Install Google Chrome
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/google-chrome-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null
sudo apt-get update
sudo apt-get install google-chrome-stable chromium-browser -y

sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3 -y
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
rustup override set stable
rustup update stable

'''
# --- Alacritty Terminal Installation ---
# Cloning and building Alacritty
git clone https://github.com/alacritty/alacritty.git
cd alacritty
~/.cargo/bin/cargo build --release

# Deploying Alacritty
sudo cp target/release/alacritty /usr/local/bin
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database
cd ..
rm -rf alacritty/
echo "Alacritty Terminal ready to launch!"
'''

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

# --- Cursor App Installation ---
# Downloading Cursor AppImage to /tmp directory
echo "Downloading Cursor AppImage..."
wget -O /tmp/cursor-appimage https://download.cursor.sh/linux/appImage/x64
# Downloading Cursor Icon
echo "Downloading Cursor Icon..."
wget -O /tmp/cursor-icon.svg https://cursor.sh/brand/icon.svg
# Setting executable permissions and running Cursor AppImage
echo "Setting up Cursor App..."
chmod +x /tmp/cursor-appimage
/tmp/cursor-appimage
# Moving Cursor AppImage to /opt directory
sudo mv /tmp/cursor-appimage /opt/cursor.appimage
sudo mv /tmp/cursor-icon.svg /opt/cursor-icon.svg
# Editing desktop entry for Cursor
# echo "Configuring desktop entry..."
# sudo gedit /usr/share/applications/cursor.desktop
'''
[Desktop Entry]
Name=Cursor
Exec=/opt/cursor.appimage
Icon=/opt/cursor.svg
Type=Application
Categories=Development;
'''
# Moving Cursor Icon to /opt directory
echo "Cursor App installed successfully!"

# --- Go Language Setup ---
# Installing Go Language
echo "Installing Go language..."
sudo add-apt-repository ppa:longsleep/golang-backports -y
sudo apt install golang-go -y
echo "Go language setup complete!"
go install github.com/mattn/memo@latest

git clone https://github.com/pyenv/pyenv.git ~/.pyenv
# git clone https://github.com/pyenv/pyenv-update.git $(pyenv root)/plugins/pyenv-update
# git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv

go install github.com/x-motemen/ghq@latest
sudo apt install kitty peco -y
sudo apt install ripgrep bat peco
sudo ln -s /usr/bin/batcat /usr/sbin/bat

sudo apt install fonts-firacode -y
curl -sS https://starship.rs/install.sh | sh
cargo install sheldon git-delta
sudo apt-get install fonts-noto -y
echo "All installations complete. System is now supercharged!"
sudo apt-get install ntfs-3g
'''
rm -fr Desktop Documents Documents Pictures Templates Videos Music
# code .config/user-dirs.dirs
sudo gedit /etc/fstab
#sudo blkid
#dev/disk/by-uuid/64FABA3AFABA0876 /media/user/Data ntfs-3g defaults,uid=1000,gid=1000 0 2
#dev/disk/by-uuid/200A57640A5735CE /media/user/GAME ntfs-3g defaults,uid=1000,gid=1000 0 2
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

sudo apt install gh
gh auth login
ghq get git@github.com:kasi-x/dotfiles.git

ZIP_URL=$(curl -s "https://api.github.com/repos/yuru7/udev-gothic/releases/latest" | jq -r '.tag_name | "https://github.com/yuru7/udev-gothic/releases/download/" + . + "/UDEVGothic_NF_" + . + ".zip"')
curl -Ls "$ZIP_URL" -o udev_gothic.zip
unzip -j udev_gothic.zip '*.ttf' -d ~/.local/share/fonts/
rm udev_gothic.zip
fc-cache -fv

ln -s /home/user/ghq/github.com/kasi-x/dotfiles/dots/skk /home/user/.skk
ln -s /home/usr/dev /home/user/ghq/github.com/kasi-x
ln -s /home/user/ghq/github.com/kasi-x/dotfiles/dots/git/config /home/usr/.config/git/config
 ln -s  /home/user/dotfiles/dots/gitignore /home/user/.gitignore


'''
function create_link() {
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

create_link "kaggle" ".kaggle"
create_link "skk" ".skk"
create_link "textlintrc" ".textlintrc"
create_link "bash_profile" ".bash_profile"
create_link "atcodertools.toml" ".atcodertools.toml"
create_link "tmux.conf" ".tmux.conf"
create_link "Xmodmap" ".Xmodmap"
create_link "config/nvim/lua/custom" ".config/nvim/lua/custom"
create_link "config/fish/config.fish" ".config/fish/config.fish"
create_link "config/git/config" ".config/git/config"
create_link "config/git/ignore" ".config/git/ignore"
create_link "config/direnv/direnvrc" ".config/direnv/direnvrc"
create_link "config/bat/config" ".config/bat/config"
create_link "config/zathura/zathurarc" ".config/zathura/zathurarc"
create_link "config/vlc/vlcrc" ".config/vlc/vlcrc"
create_link "config/rofi" ".config/rofi"
create_link "config/kitty/" ".config/kitty"
'''

'''
curl https://nim-lang.org/choosenim/init.sh -sSf | sh
sudo apt auto-install
sudo ubuntu-drivers devices
ai auto-install
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt-get update
sudo apt-get -y install cuda-toolkit-12-4
sudo apt-get -y install nvidia-cuda-toolkit-gcc
sudo apt-get install -y cuda-drivers-535
sudo apt-get install -y cuda-drivers-fabricmanager-535
ai nvidia-driver-535
sudo apt-get install cuda\

sudo ubuntu-drivers install --gpgpu nvidia:535
nvidia-smi\
wget https://developer.download.nvidia.com/compute/cudnn/9.1.1/local_installers/cudnn-local-repo-ubuntu2404-9.1.1_1.0-1_amd64.deb\
sudo dpkg -i cudnn-local-repo-ubuntu2404-9.1.1_1.0-1_amd64.deb\
sudo cp /var/cudnn-local-repo-ubuntu2404-9.1.1/cudnn-*-keyring.gpg /usr/share/keyrings/\
sudo apt-get update\
sudo apt-get -y install cudnn
wget https://developer.download.nvidia.com/compute/cudnn/9.1.1/local_installers/cudnn-local-repo-ubuntu2204-9.1.1_1.0-1_amd64.deb\
sudo dpkg -i cudnn-local-repo-ubuntu2204-9.1.1_1.0-1_amd64.deb\
sudo cp /var/cudnn-local-repo-ubuntu2204-9.1.1/cudnn-*-keyring.gpg /usr/share/keyrings/\
sudo apt-get update\
sudo apt-get -y install cudnn

ai fonts-noto-color-emoji
sudo apt-get install fonts-noto-cjk lzip
fc-cache -fv
ai xclip
ai xsel
ai python-is-python3
ai tldr
ai mpv

yarn global add diagnostic-languageserver
npm
ai npm
mv IBM-Plex-Sans ~/.local/share/fonts/
mv IBM-Plex-Sans-JP ~/.local/share/fonts/
'''
