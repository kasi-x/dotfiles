# wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
# sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
# wget https://developer.download.nvidia.com/compute/cuda/11.8.0/local_installers/cuda-repo-ubuntu2004-11-8-local_11.8.0-520.61.05-1_amd64.deb
# sudo dpkg -i cuda-repo-ubuntu2004-11-8-local_11.8.0-520.61.05-1_amd64.deb
# sudo cp /var/cuda-repo-ubuntu2004-11-8-local/cuda-*-keyring.gpg /usr/share/keyrings/
# sudo apt-get update
#
# sudo apt-get install cuda
# # export PATH="/usr/local/cuda/bin:$PATH"
# # export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"
#
# #sudo reboot
# nvidia-smi
#
# cd Downloads/
# # sudo dpkg -i cudnn-local-repo-ubuntu2004-8.9.6.50_1.0-1_amd64.deb 
# # sudo cp /var/cudnn-local-repo-ubuntu2004-8.9.6.50/cudnn-local-5FA1A941-keyring.gpg /usr/share/keyrings/
# # sudo reboot
# # sudo apt-get update
# # sudo apt-get install libcudnn8=8.9.6.50-1+cuda11.8 
# # sudo apt-get install libcudnn8-dev=8.9.6.50-1+cuda11.8 
# # sudo apt-get install libcudnn8-samples=8.9.6.50-1+cuda11.8 
# #
# wget https://developer.download.nvidia.com/compute/cudnn/9.1.1/local_installers/cudnn-local-repo-ubuntu2204-9.1.1_1.0-1_amd64.deb
# sudo dpkg -i cudnn-local-repo-ubuntu2204-9.1.1_1.0-1_amd64.deb
# sudo cp /var/cudnn-local-repo-ubuntu2204-9.1.1/cudnn-*-keyring.gpg /usr/share/keyrings/
# sudo apt-get update
# sudo apt-get -y install cudnn
# #
# sudo reboot
#
# nvcc -V
#
function nvidia_setup {
#NVIDIA Container Toolkit
aria2c -q -d /tmp -o gpgkey https://nvidia.github.io/libnvidia-container/gpgkey
cat /tmp/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
aria2c -q -d /tmp -o nvidia-container-toolkit.list https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list
sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' /tmp/nvidia-container-toolkit.list | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
rm /tmp/gpgkey /tmp/nvidia-container-toolkit.list
}
'''
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
'''

