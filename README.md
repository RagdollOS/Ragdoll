# Ragdoll项目介绍
Ragdoll是一个Linux发行版。

# 开发环境
1. 宿主机安装VMware
2. 虚拟机开发系统：全新安装的Ubuntu 18.04.3
3. 虚拟机测试系统：挂载打包出的iso文件，测试其行为
4. 带外测试系统：带外挂载打包出的iso文件，测试其行为

# 仓库环境
Ubuntu官方ISO镜像中的软件包，会被新版本替代，而在官方repo中无法找到。如果坚持需要旧版本，以及为了不破坏软件依赖关系，需要自建一个iso专用的镜像仓库。
此处涉及$apt_mirror_iso以及$ubuntu_livecd_resources目录下的Packages_d-i和Packages_main文件维护工作

# 私有仓库
私有的软件包，应当妥善发布至私有的PPA仓库。在iso镜像打包过程中，可先增加PPA，再通过标准的apt方式安装私有软件包。

# GPG问题
为了防范恶意镜像仓库，Ubuntu强制在keyring中写入Ubuntu官方的GPG Key。我们原则上不规避官方GPG，避免用户自行修改仓库造成安全隐患。
GPG问题分为两种情况：
1. iso镜像中debian-installer使用Ragdoll的GPG和$apt_mirror_iso仓库配合完成iso的制作。
2. debian-installer安装完成target系统，不修改keyring软件包，继续使用Ubuntu官方GPG。

# VMware共享文件夹设置
1. 映射宿主机任意指定目录至/mnt/hgfs/host/
2. 将虚拟机测试系统设定为光盘启动优先，并选择相应的iso文件
3. 当虚拟机开发系统执行`./build.sh`时，会在项目目录下生成iso文件，并复制一份至/mnt/hgfs/host。此时重启测试系统即可开始Debug流程。

# 安装步骤
1. `sudo -s`，为确保文件权限正确，开发系统全部操作均在root用户下执行
2. git clone 本项目
3. `./build.sh`

# 部署
打包后会生成一个iso文件，可在虚拟机、物理机、云服务器等环境进行测试和部署


