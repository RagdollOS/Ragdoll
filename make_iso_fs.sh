set -x
. config.sh

cd $image_dir
mkisofs -r -V "$IMAGE_NAME" -cache-inodes -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o ../$IMAGE_NAME.iso .
cd ..

isohybrid $IMAGE_NAME.iso
