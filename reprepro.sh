set -x
. config.sh

rm -rf $build_dir/reprepro/
mkdir -p $build_dir/reprepro
cd $build_dir/reprepro

mkdir -p repo/conf

cat << EOF > repo/conf/distributions
Origin: Ragdoll
Label: Ragdoll Main Repo
Codename: bionic
Suite: stable
Architectures: amd64 source
Components: main multiverse restricted universe
UDebComponents: multiverse restricted universe
Contents: udebs percomponent allcomponents
DebOverride: deb_override
UdebOverride: udeb_override
Description: Ragdoll
EOF

cp $build_dir/germinate/packages/ExtraOverride repo/conf/deb_override
cp $build_dir/germinate/packages/ExtraOverride repo/conf/udeb_override

sed "s@^@$apt_mirror_iso/@g" $build_dir/germinate/packages/filename.list | grep "\.udeb" > udeb.list
wget -nv -i udeb.list -P udeb/

sed "s@^@$apt_mirror_iso/@g" $build_dir/germinate/packages/filename.list | grep "\.deb" > deb.list
wget -nv -i deb.list -P deb/

rm deb/ubuntu-keyring*
ubuntu_keyring_url="http://mirrors.aliyun.com/Ragdoll/ragdoll-keyring/2020-02-03_21%3A29%3A53/ubuntu-keyring_2018.02.28_all.deb"
wget $ubuntu_keyring_url -P deb/

reprepro -b repo includeudeb bionic udeb/*.udeb
reprepro -b repo includedeb bionic deb/*.deb

ls udeb | wc -l
ls deb | wc -l

cd $project_dir