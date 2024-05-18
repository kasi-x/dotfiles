rm -fr Desktop Documents Documents Pictures Templates Videos Music
# code .config/user-dirs.dirs
sudo gedit /etc/fstab
#sudo blkid
#/dev/disk/by-uuid/64FABA3AFABA0876 /media/user/Data ntfs-3g defaults,uid=2000,gid=2000 0 2
#/dev/disk/by-uuid/200A57640A5735CE /media/user/GAME ntfs-3g defaults,uid=1000,gid=1000 0 2
#/dev/disk/by-uuid/884CFC8D4CFC76F2 /media/user/Windows ntfs-3g defaults,uid=3000,gid=3000 0 2
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
ln -s /media/user/GAME /home/user/Game
