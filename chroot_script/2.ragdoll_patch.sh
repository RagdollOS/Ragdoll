export HOME=/root
export LC_ALL=C

apt-get update

dbus-uuidgen > /var/lib/dbus/machine-id
dpkg-divert --local --rename --add /sbin/initctl
ln -s /bin/true /sbin/initctl

rm /etc/systemd/system/default.target
ln -s /lib/systemd/system/multi-user.target /etc/systemd/system/default.target

rm /etc/systemd/system/getty.target.wants/getty@tty1.service
ln -s /etc/systemd/system/getty@tty1.service /etc/systemd/system/getty.target.wants/getty@tty1.service



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