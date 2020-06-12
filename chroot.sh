. config.sh

# set -x
cp /etc/resolv.conf $ubuntu_base_system_dir/etc/resolv.conf


mkdir -p $ubuntu_base_system_dir/etc/apt/
cat << EOF > $ubuntu_base_system_dir/etc/apt/sources.list
deb $apt_mirror_iso $codename main restricted universe multiverse
deb-src $apt_mirror_iso $codename main restricted universe multiverse
EOF

cp -r $ubuntu_livecd_resources/chroot_resources $ubuntu_base_system_dir/chroot_resources
cp -r $project_dir/pre_download/* $ubuntu_base_system_dir/chroot_resources/

cp $project_dir/cache/* $ubuntu_base_system_dir/var/cache/apt/archives

./mount.sh
cat chroot_script/1.init_env.sh | chroot $ubuntu_base_system_dir /bin/bash
#cat chroot_script/4.ubiquity_server.sh | chroot $ubuntu_base_system_dir /bin/bash
./umount.sh

cp $ubuntu_base_system_dir/var/cache/apt/archives/* $project_dir/cache/
rm -rf $ubuntu_base_system_dir/var/cache/apt/archives/*

cat << EOF > $ubuntu_base_system_dir/etc/apt/sources.list
deb $apt_mirror_target $codename main restricted universe multiverse
deb $apt_mirror_target $codename-updates main restricted universe multiverse
deb $apt_mirror_target $codename-backports main restricted universe multiverse
deb $apt_mirror_target $codename-security main restricted universe multiverse
deb-src $apt_mirror_target $codename main restricted universe multiverse
deb-src $apt_mirror_target $codename-updates main restricted universe multiverse
deb-src $apt_mirror_target $codename-backports main restricted universe multiverse
deb-src $apt_mirror_target $codename-security main restricted universe multiverse
EOF
