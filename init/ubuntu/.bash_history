# Installing Go Language
echo "Installing Go language..."
sudo add-apt-repository ppa:longsleep/golang-backports -y
# Install Google Chrome
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/google-chrome-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null
sudo apt-get update
sudo apt-get install google-chrome-stable chromium-browser -y
cursor
cd /usr/share/applications
ls
cat cursor.desktop 
gedit cursor.desktop 
sudo gedit cursor.desktop 
cd 
ls
cd dotfiles/dots/
ls
cd 
sh a.sh
mkdir -p .config/git
sh a.sh
ls
cd dev/
ls
pwd
cd kasi-x
ls
cd ..
unlink kasi-x
ls
cd 
ls
sudo apt install zsh
curl -sS https://starship.rs/install.sh | sh
zsh
