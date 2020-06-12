. config.sh
mount --bind /dev/ $ubuntu_base_system_dir/dev/
mount -vt devpts devpts $ubuntu_base_system_dir/dev/pts
mount -vt proc proc $ubuntu_base_system_dir/proc
mount -vt sysfs sysfs $ubuntu_base_system_dir/sys
# mount -vt tmpfs tmpfs $ubuntu_base_system_dir/run