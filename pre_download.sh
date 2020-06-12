. config.sh

set -x
# rm -rf $project_dir/pre_download
mkdir -p $project_dir/pre_download
cd $project_dir/pre_download
wget -nc https://swift.org/builds/swift-5.1.4-release/ubuntu1804/swift-5.1.4-RELEASE/swift-5.1.4-RELEASE-ubuntu18.04.tar.gz -O swift.tar.gz
wget -nc https://wdl1.cache.wps.cn/wps/download/ep/Linux2019/9080/wps-office_11.1.0.9080_amd64.deb -O wps.deb
wget -nc https://mirrors.ustc.edu.cn/wine/wine/wine-mono/4.9.4/wine-mono-4.9.4.msi -O wine-mono.msi
cd -
