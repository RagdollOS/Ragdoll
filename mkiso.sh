set -x
IMAGE_NAME="ubuntu_base_system_server"

cd image
sudo mkisofs -r -V "$IMAGE_NAME" -cache-inodes -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o ../$IMAGE_NAME.iso .
cd ..

isohybrid $IMAGE_NAME.iso
cp $IMAGE_NAME.iso /mnt/hgfs/host/

