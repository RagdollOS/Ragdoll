. config.sh
set -x

rm $image_dir/casper/filesystem.squashfs
mksquashfs $ubuntu_base_system_dir $image_dir/casper/filesystem.squashfs
