. config.sh


'which ssh-agent || ( apt-get update -y && apt-get install openssh-client -y )'
mkdir -p ~/.ssh
eval $(ssh-agent -s)
'[[ -f /.dockerenv ]] && echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config'

time=$(date '+%Y-%m-%d_%H:%M:%S')

sshpass -p '00000000' scp -o stricthostkeychecking=no $build_dir/$IMAGE_NAME.iso ragdoll@mirrors.aliyun.com:Ragdoll/Ragdoll_Desktop_$time.iso
