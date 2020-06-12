set -x
. config.sh

rm -rf $image_dir
mkdir -p $image_dir/casper
mkdir -p $image_dir/isolinux
mkdir -p $image_dir/install


# cp $build_dir/initrd.gz $image_dir/casper/initrd
# cp $build_dir/vmlinuz $image_dir/casper/vmlinuz

cp $ubuntu_base_system_dir/boot/initrd.img-4.15.0-20-generic $image_dir/casper/initrd.gz
cp $ubuntu_base_system_dir/boot/vmlinuz-4.15.0-20-generic $image_dir/casper/vmlinuz

cp /usr/lib/syslinux/modules/bios/* $image_dir/isolinux/
cp /usr/lib/ISOLINUX/isolinux.bin $image_dir/isolinux/
cp /boot/memtest86+.bin $image_dir/install/memtest

cp $ubuntu_livecd_resources/isolinux.cfg $image_dir/isolinux/
cp $ubuntu_livecd_resources/isolinux_background.png $image_dir/isolinux/

# chroot $ubuntu_base_system_dir dpkg-query -W --showformat='${Package} ${Version}\n' | tee $image_dir/casper/filesystem.manifest
# cp -v $image_dir/casper/filesystem.manifest $image_dir/casper/filesystem.manifest-desktop
# REMOVE='ubiquity ubiquity-frontend-gtk ubiquity-frontend-kde casper lupin-casper live-initramfs user-setup discover1 xresprobe os-prober libdebian-installer4'
# for i in $REMOVE; do sed -i "/${i}/d" $image_dir/casper/filesystem.manifest-desktop; done

# printf $(du -sx --block-size=1 $ubuntu_base_system_dir | cut -f1) > $image_dir/casper/filesystem.size

# cp $ubuntu_livecd_resources/README.diskdefines $image_dir/

# touch $image_dir/ubuntu
# cp -r $ubuntu_livecd_resources/disk $image_dir/.disk


# cp -r $build_dir/reprepro/repo/dists $image_dir/
# cp -r $build_dir/reprepro/repo/pool $image_dir/

# cp -r $ubuntu_livecd_resources/preseed $image_dir/
