set -x

. config.sh
./clean.sh
# ./setup.sh
./pre_download.sh
./base_system.sh
./chroot.sh
# ./debian-installer.sh
# ./germinate.sh
# ./extra_override.sh
# ./reprepro.sh
./make_iso.sh

./cp_iso_host.sh

# ./cp_iso_mirror.sh
