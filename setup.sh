. config.sh
. /etc/os-release
cat << EOF > /etc/apt/sources.list
deb $apt_mirror $UBUNTU_CODENAME main restricted universe multiverse
deb $apt_mirror $UBUNTU_CODENAME-security main restricted universe multiverse
deb $apt_mirror $UBUNTU_CODENAME-updates main restricted universe multiverse
deb $apt_mirror $UBUNTU_CODENAME-proposed main restricted universe multiverse
deb $apt_mirror $UBUNTU_CODENAME-backports main restricted universe multiverse
deb-src $apt_mirror $UBUNTU_CODENAME main restricted universe multiverse
deb-src $apt_mirror $UBUNTU_CODENAME-security main restricted universe multiverse
deb-src $apt_mirror $UBUNTU_CODENAME-updates main restricted universe multiverse
deb-src $apt_mirror $UBUNTU_CODENAME-proposed main restricted universe multiverse
deb-src $apt_mirror $UBUNTU_CODENAME-backports main restricted universe multiverse
EOF

apt-get update
apt-get install -y debootstrap
apt-get install -y syslinux isolinux squashfs-tools genisoimage syslinux-utils sshpass
apt-get install -y build-essential git
apt-get build-dep -y debian-installer
apt-get install -y reprepro
apt-get install -y germinate
