set -x
. config.sh

mkdir -p $build_dir/debian-installer
cd $build_dir/debian-installer

git clone -b applied/20101020ubuntu541 git@git.ragdoll.com:ragdoll-mirrors/debian-installer.git
cd debian-installer/build
make build_cdrom_isolinux
cp dest/cdrom/initrd.gz $build_dir
cp dest/cdrom/vmlinuz $build_dir

cd $project_dir