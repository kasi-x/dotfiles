wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/11.8.0/local_installers/cuda-repo-ubuntu2004-11-8-local_11.8.0-520.61.05-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2004-11-8-local_11.8.0-520.61.05-1_amd64.deb
sudo cp /var/cuda-repo-ubuntu2004-11-8-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update

sudo apt-get install cuda
# export PATH="/usr/local/cuda/bin:$PATH"
# export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"

#sudo reboot
nvidia-smi

cd Downloads/
sudo dpkg -i cudnn-local-repo-ubuntu2004-8.9.6.50_1.0-1_amd64.deb 
sudo cp /var/cudnn-local-repo-ubuntu2004-8.9.6.50/cudnn-local-5FA1A941-keyring.gpg /usr/share/keyrings/
sudo reboot
sudo apt-get update
sudo apt-get install libcudnn8=8.9.6.50-1+cuda11.8 
sudo apt-get install libcudnn8-dev=8.9.6.50-1+cuda11.8 
sudo apt-get install libcudnn8-samples=8.9.6.50-1+cuda11.8 

sudo reboot

nvcc -V
