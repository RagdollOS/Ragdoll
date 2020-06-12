. config.sh
rm -rf $ubuntu_base_system_dir
mkdir -p $ubuntu_base_system_dir
mkdir -p $project_dir/cache
debootstrap --no-check-gpg --cache-dir=$project_dir/cache --include=gnupg,wget,apt,software-properties-common,vim,git,htop --arch=$debootstrap_arch $codename $ubuntu_base_system_dir $apt_mirror_iso
wget -q http://mirrors.aliyun.com/gpg/ragdoll-public-keys.asc -O $ubuntu_base_system_dir/ragdoll-public-keys.asc
