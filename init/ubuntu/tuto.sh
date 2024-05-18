# sudo add-apt-repository ppa:apt-fast/stable -y
# sudo apt-get update
# sudo apt-get -y install apt-fast

# echo debconf apt-fast/maxdownloads string 16 | debconf-set-selections
# echo debconf apt-fast/dlflag boolean true | debconf-set-selections
# echo debconf apt-fast/aptmanager string apt-get | debconf-set-selections

install_packages() {
    sudo DEBIAN_FRONTEND=noninteractive apt-fast install -y "$@" > /dev/null 2>&1
}

check_command_exist() {
    local command_to_check="$1"

    if which "$command_to_check" >/dev/null; then
        echo "#########################################"
        echo "#  $command_to_check is installed    #"
        echo "#########################################"

        return 1  
    else
        echo "$command_to_check is not installed"
        return 0 
    fi
}

function docker_setup {
    if ! check_command_exist "docker"; then
        echo "-------------------------------------------------------"
        
    fi
}

docker_setup


