set -x
export HOME=/root
export LC_ALL=C

dbus-uuidgen > /var/lib/dbus/machine-id
dpkg-divert --local --rename --add /sbin/initctl
ln -s /bin/true /sbin/initctl

# ==================================================

#apt-get update
#apt-get -y upgrade

apt-get -y install vim
#apt-get -y install build-essential git
#apt-get -y build-dep debian-installer
#apt-get source debian-installer
#cd debian-installer-20101020ubuntu543.11/build
#sed -i 's/4.15.0-62/4.15.0-55/g' config/amd64.cfg
#make build_cdrom_isolinux
#cp dest/cdrom/initrd.gz /boot/
#cp dest/cdrom/vmlinuz /boot/

#apt-get purge -y grub-efi-amd64-signed

# snap install subiquity
# apt-get install -y probert user-setup curtin subiquity subiquity-tools ubuntu-drivers-common
# apt-get install -y ubuntu-desktop ubiquity ubiquity-frontend-gtk

# ==================================================



rm /var/lib/dbus/machine-id

rm /sbin/initctl
dpkg-divert --rename --remove /sbin/initctl

ls /boot/vmlinuz-*.*.**-**-generic > list.txt
sum=$(cat list.txt | grep '[^ ]' | wc -l)

if [ $sum -gt 1 ]; then
dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge
fi

rm list.txt

apt-get clean
rm -rf /tmp/*
exit

