. config.sh
set -x

./make_image.sh
./make_squash_fs.sh
./make_iso_fs.sh
