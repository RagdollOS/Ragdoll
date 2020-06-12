# set -x 
. config.sh

cd $build_dir/germinate       


cd out
rm ../packages/ExtraOverride
packages=$(find . -name "http*")
for package in $packages
do
    name=""
    filename=""
    task=""
    cat $package | while read line;
    do
        if [[ -n $line ]]; then
            delimiter=": "
            s=$line$delimiter
            tokens=();
            while [[ $s ]]; do
                tokens+=( "${s%%"$delimiter"*}" );
                s=${s#*"$delimiter"};
            done;
            key=${tokens[0]}
            value=${tokens[1]}
            if [ "$key" = "Package" ]; then
                name="$value"
            fi
            if [ "$key" = "Task" ]; then
                task="$value"
            fi
            if [[ -n $name ]] && [[ -n $task ]]; then
                echo "$name Task $task"
                echo "$name Task $task" >> ../packages/ExtraOverride
                name=""
                filename=""
                task=""
            fi
        else
            name=""
            filename=""
            task=""
        fi
    done
done
echo "libavcodec57 Task kubuntu-desktop" >> ../packages/ExtraOverride
echo "open-vm-tools-desktop Task kubuntu-desktop" >> ../packages/ExtraOverride
echo "git Task kubuntu-desktop" >> ../packages/ExtraOverride
echo "liberror-perl Task kubuntu-desktop" >> ../packages/ExtraOverride
echo "patch Task kubuntu-desktop" >> ../packages/ExtraOverride
cd $project_dir

