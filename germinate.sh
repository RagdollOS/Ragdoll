set -x 
. config.sh

# installer: udebs
# d-i-requirements: apt error
# boot required minimal standard: keyboard-configuration error
# list="installer d-i-requirements boot required minimal standard desktop-common desktop live-common live ship-live language-packs"
list="installer d-i-requirements boot required minimal standard"
rm -rf $build_dir/germinate/
mkdir -p $build_dir/germinate/seeds
cd $build_dir/germinate
cd seeds
git clone -b $codename http://git.ragdoll.com/ragdoll-mirrors/ubuntu-seeds-platform.git platform.$codename
# git clone -b $codename https://git.launchpad.net/~ubuntu-core-dev/ubuntu-seeds/+git/ubuntu ubuntu.$codename
# bzr branch lp:~ubuntu-core-dev/ubuntu-seeds/platform.bionic
bzr branch lp:~kubuntu-dev/ubuntu-seeds/kubuntu.bionic
mv kubuntu.bionic ubuntu.bionic
# echo " * kubuntu-desktop" >> ubuntu.bionic/desktop
# echo " * open-vm-tools-desktop" >> ubuntu.bionic/desktop
# echo " * git" >> ubuntu.bionic/desktop
# echo " * libavcodec57" >> ubuntu.bionic/desktop
cd ..

rm -rf out/
mkdir out
cd out
germinate -S ../seeds -s ubuntu

.$codename -m $apt_mirror_iso -d $codename -a amd64 -c main,restricted,universe,multiverse --no-rdepends

rm -rf ../packages/
mkdir ../packages
for file in $list
do
cat $file|tail -n +3 | head -n -2 | cut -d' ' -f1 >> ../packages/name.list
done
cat ../packages/name.list | while read line; do echo "Filename: .*\/"$line"_.*\.u\?deb"; done >> ../packages/seeds_package_name.list
cat ../packages/seeds_package_name.list | sort | uniq > ../packages/package_name.list
rm ../packages/seeds_package_name.list
packages=$(find . -name "http*")
grep -h -f ../packages/package_name.list $packages | sed 's/^Filename: //' > ../packages/filename.list

wc -l ../packages/filename.list

cd $project_dir

