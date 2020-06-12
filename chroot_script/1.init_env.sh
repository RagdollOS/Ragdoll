set -x
export HOME=/root
export LC_ALL=C

dbus-uuidgen > /var/lib/dbus/machine-id
dpkg-divert --local --rename --add /sbin/initctl
ln -s /bin/true /sbin/initctl

# trust myself
# apt-key add /ragdoll-public-keys.asc

# add Google PPA
apt-key add chroot_resources/linux_signing_key.pub
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

# add Microsoft PPA
apt-key add chroot_resources/microsoft.asc
echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list

# add Wine PPA
dpkg --add-architecture i386 
apt-key add chroot_resources/winehq.key
#echo "deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main" > /etc/apt/sources.list.d/winehq.list
# echo "deb http://mirrors-wan.geekpie.club/wine/wine-builds/ubuntu/ bionic main" > /etc/apt/sources.list.d/winehq.list

apt-get update
# apt-get --yes upgrade
apt-get install --yes ubuntu-standard kubuntu-desktop update-notifier casper lupin-casper open-vm-tools-desktop
apt-get install --yes discover laptop-detect os-prober

DEBIAN_FRONTEND=noninteractive apt-get install -yq -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" linux-generic
DEBIAN_FRONTEND=noninteractive apt-get install -yq -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" grub-pc

# apt-get install --yes busybox-initramfs initramfs-tools-bin initramfs-tools-core
apt-get install --yes calamares rsync keyutils
# wget https://mirrors.huaweicloud.com/ubuntu/pool/universe/c/calamares-settings-ubuntu/calamares-settings-lubuntu_1_all.deb -O calamares-settings.deb
# dpkg -i calamares-settings.deb
# apt-get --yes --fix-broken install
cp -r chroot_resources/etc/calamares /etc/
cp chroot_resources/etc/xdg/autostart/ragdoll-calamares.desktop /etc/xdg/autostart/

apt-get install --yes apt-transport-https \
language-pack-kde-zh-hans language-pack-kde-zh-hant language-pack-kde-en \
google-chrome-stable \
code

# install WPS
dpkg -i chroot_resources/wps.deb
# install missing fonts for WPS
git clone https://github.com/iamdh4/ttf-wps-fonts.git
mkdir -p /usr/share/fonts/wps-fonts
mv ttf-wps-fonts/*.{ttf,TTF} /usr/share/fonts/wps-fonts
chmod 644 /usr/share/fonts/wps-fonts/*
fc-cache -vfs
rm -rf ttf-wps-fonts

# fix GB2312 issue
apt-get install --yes locales-all

# Sogou Pinyin
# apt-get install --yes fcitx fcitx-libs libopencc2
# wget http://cdn2.ime.sogou.com/dl/index/1571302197/sogoupinyin_2.3.1.0112_amd64.deb -O sogou.deb
# dpkg -i sogou.deb
# rm sogou.deb
# force enable sogou-qimpanel
# sed -i "s/\/usr\/bin\/fcitx/\/usr\/bin\/fcitx --enable sogou-qimpanel \&\& sogou-qimpanel/" /usr/share/im-config/data/22_fcitx.rc
# rm /etc/xdg/autostart/fcitx-ui-sogou-qimpanel.desktop

# install Google Pinyin
# apt-get install --yes fcitx-googlepinyin

# Install RIME
apt-get install --yes fcitx-rime zenity
im-config -n fcitx
git clone https://github.com/hrko99/fcitx-skin-material.git
cp -r fcitx-skin-material/material /usr/share/fcitx/skin/
# git clone https://github.com/winjeg/fcitx-skins.git
# cp -r fcitx-skins/material /usr/share/fcitx/skin/
# cp -r fcitx-skins/mint-dark /usr/share/fcitx/skin/
# rm -rf fcitx-skins

# install WineHQ
wget https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_18.04/amd64/libfaudio0_19.07-0~bionic_amd64.deb -O libfaudio0_amd64.deb
dpkg -i libfaudio0_amd64.deb
rm libfaudio0_amd64.deb
wget https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_18.04/i386/libfaudio0_19.07-0~bionic_i386.deb -O libfaudio0_i386.deb
dpkg -i libfaudio0_i386.deb
rm libfaudio0_i386.deb
apt-get --yes --fix-broken install
apt-get install --yes --install-recommends winehq-stable

# Install Mono
# wineboot -u && msiexec /i chroot_resources/wine-mono.msi


# Install Latte Dock
apt-get install --yes latte-dock
cp chroot_resources/etc/xdg/autostart/org.kde.latte-dock.desktop /etc/xdg/autostart/org.kde.latte-dock.desktop 
# rm /usr/share/plasma/shells/org.kde.latte.shell/contents/layouts/*
# rm /usr/share/plasma/shells/org.kde.latte.shell/contents/presets/*
cp chroot_resources/usr/share/plasma/shells/org.kde.latte.shell/contents/presets/* /usr/share/plasma/shells/org.kde.latte.shell/contents/presets/

# Install Cairo Dock
# apt-get install --yes cairo-dock

# Install Conky
# apt-get install --yes conky
# cp -r chroot_resources/etc/conky /etc/

# Config KDE Plasma Panel
rm -rf /usr/share/plasma/layout-templates/*
cp -r chroot_resources/usr/share/plasma/layout-templates/* /usr/share/plasma/layout-templates/

# replace wallpapers
cp -r chroot_resources/usr/share/wallpapers /usr/share/
mkdir -p /usr/share/plasma/desktoptheme/kubuntu/
cp -r chroot_resources/usr/share/plasma/desktoptheme/kubuntu/metadata.desktop /usr/share/plasma/desktoptheme/kubuntu/


# Install Apple Swift
apt-get install --yes libatomic1
tar -xf chroot_resources/swift.tar.gz -C /opt/
mv /opt/swift-5.1.4-RELEASE-ubuntu18.04/ /opt/swift/
echo 'export PATH=/opt/swift/usr/bin:"${PATH}"' >> /etc/profile
# remove libc6-dbg for Swift
apt-get purge --yes libc6-dbg


# Config Netplan
cp chroot_resources/etc/netplan/* /etc/netplan/

# Config Language
update-locale LANG=zh_CN.UTF-8 LANGUAGE=zh_CN.UTF-8

# Clear Config
rm -rf /root/.config

# Clear Cache
rm -rf /root/.cache

rm -rf chroot_resources

rm /var/lib/dbus/machine-id

rm /sbin/initctl
dpkg-divert --rename --remove /sbin/initctl

# ls /boot/vmlinuz-*.*.**-**-generic > list.txt
# sum=$(cat list.txt | grep '[^ ]' | wc -l)

# if [ $sum -gt 1 ]; then
# dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge
# fi

# rm list.txt

# apt-get clean
rm -rf /tmp/*
exit
