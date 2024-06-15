
# echo debconf apt-fast/maxdownloads string 16 | debconf-set-selections
# echo debconf apt-fast/dlflag boolean true | debconf-set-selections
# echo debconf apt-fast/aptmanager string apt-get | debconf-set-selections

install_packages() {
    sudo DEBIAN_FRONTEND=noninteractive apt-fast install -y "$@" > /dev/null 2>&1
}

check_command_exist() {
    local command_to_check="$1"

    if which "$command_to_check" >/dev/null; then
        echo "╭──────────────────────────────────────────────────────────╮"
        echo "│              $command_to_check is installed              │"
        echo "╰──────────────────────────────────────────────────────────╯"
        return 1  
    else
        echo "$command_to_check is not installed"
        return 0 
    fi
}

add_repository_if_missing() {
    local ppa_name="$1"
    local repository="ppa:$repository"
    if ! apt-cache policy | grep "$ppa_name"; then
        sudo add-apt-repository "$repository" -y
    fi
}

sudo apt-get upgrade -y
add_repository_if_missing "apt-fast/stable"
if ! check_command_exist "apt-fast";then
    sudo apt-get -y install apt-fast
fi


base_packages=( #{{{
    git
    curl
    gh
    gedit
    cmake
    wget
    curl
    ca-certificates
    gnupg
    lsb-release
    aria2
    pkg-config
    libssl-dev
    lzip
    ibus-skk
) # }}}

secondary_packages=(
    vivaldi-stable
    google-chrome-stable
    chromium-browser
    neovim
    golang-go
    docker-ce
    docker-ce-cli
    containerd.io
    docker-buildx-plugin
    docker-compose-plugin
)

# nvidia_packages=(
#     nvidia-cuda-toolkit
# )

rust_packages=(
    libfreetype6-dev
    libfontconfig1-dev
    libxcb-xfixes0-dev
    python3
)

neovide_packages=(
    gcc-multilib
    g++-multilib 
    libfreetype6-dev
    libasound2-dev
    libexpat1-dev
    libxcb-composite0-dev
    libbz2-dev
    libsndio-dev
    freeglut3-dev
    libxmu-dev
    libxi-dev
    libfontconfig1-dev
    libxcursor-dev
    xclip
    xsel
)

function golang_pre_setup {
    echo "Installing Go language..."
    add_repository_if_missing "longsleep/golang-backports"
}

function neovim_setup {
    # add_repository_if_missing "neovim-ppa/unstable" 
    if ! check_command_exist "neovide"; then
        install_packages "${neovide_packages[@]}"
        cargo install --git https://github.com/neovide/neovide
    fi
}


function rust_setup {
   if ! check_command_exist "rustup"; then
        install_packages "${rust_packages[@]}"
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        source $HOME/.cargo/env
        rustup override set stable
        rustup update stable
        echo "cargo done"
   fi
}

function vivaldi_pre_setup {
   if ! check_command_exist "vivaldi"; then 
        aria2c -q -d /tmp -o linux_signing_key.pub http://repo.vivaldi.com/stable/linux_signing_key.pub
        cat /tmp/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/vivaldi-archive-keyring.gpg
        echo "deb [signed-by=/usr/share/keyrings/vivaldi-archive-keyring.gpg arch=i386,amd64] http://repo.vivaldi.com/stable/deb/ stable main" | sudo tee /etc/apt/sources.list.d/vivaldi.list > /dev/null
    fi
}
function chrome_pre_setup {
    if ! check_command_exist "google-chrome"; then
        aria2c -q -d /tmp -o linux_signing_key.pub https://dl.google.com/linux/linux_signing_key.pub
        cat /tmp/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/google-chrome-keyring.gpg
        echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null
    fi
}

function browser_pre_setup {
    vivaldi_pre_setup &
    chrome_pre_setup &
    wait
    rm /tmp/linux_signing_key.pub
}

function docker_pre_setup {
    if ! check_command_exist "docker"; then
        sudo mkdir -p /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    fi
}

function first_actions {
    install_packages "${base_packages[@]}"
    echo "finish_install_base_packages"
}

function update_ppa {
    browser_pre_setup &
    rust_setup &
    golang_pre_setup &
    docker_pre_setup &
    wait
} 

function second_actions {
    update_ppa
    sudo apt-fast update -y
    install_packages "${secondary_packages[@]}"
    echo "finish_second_actions"
}


function skk_setup {
    if ! check_command_exist "yaskkserv2"; then
        cd $HOME
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
    fi
}

install_go_tools() {
    if ! check_command_exist "memo"; then
        go install github.com/mattn/memo@latest
    fi
}

install_rust_tools() {
    if ! check_command_exist "sheldon"; then
        cargo install sheldon git-delta &
    fi
    neovim_setup &
    skk_setup &
}

install_pyenv() {
    if ! check_command_exist "pyenv"; then
        git clone https://github.com/pyenv/pyenv.git ~/.pyenv
        git clone https://github.com/pyenv/pyenv-update.git "${HOME}/.pyenv/plugins/pyenv-update"
        git clone https://github.com/pyenv/pyenv-virtualenv.git "${HOME}/.pyenv/plugins/pyenv-virtualenv"
    fi
}

install_other_tools() {
    install_packages kitty peco ripgrep bat python-is-python3 tldr mpv npm lua luacheck zathura
    if ! check_command_exist bat; then
        sudo ln -s /usr/bin/batcat /usr/sbin/bat
    fi
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
}

third_actions() {
    if ! check_command_exist "starship"; then
        (curl -sS https://starship.rs/install.sh | sh) &
    fi
    if ! check_command_exist "diagnostic-languageserver"; then
        (npm i -g diagnostic-languageserver) &
    fi
    if ! check_command_exist "nimble"; then
        (curl https://nim-lang.org/choosenim/init.sh -sSf | sh) &
    fi
    install_go_tools &
    install_rust_tools &
    install_pyenv &
    install_other_tools &
    wait
}

echo "finish_all"
first_actions
echo "first done"
second_actions
echo "second done"
third_actions
echo "finish_all"
