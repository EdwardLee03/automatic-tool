#!/usr/bin/env bash

# -----------------------------------------------
# The template of configure, build and install from source.
#
# User: xingle
# Date: 15/10/27
# Time: 22:01
# -----------------------------------------------

usage () {
    echo "Usage:"
    echo "sh install_template.sh -d 'xxx' [-c 'xxx' -o 'xxx' -s '0']"
    echo "  -d  download url"
    echo "  -c  command of configure"
    echo "  -o  option of configure"
    echo "  -s  sudo permission (0|1)"
}

download_url=''
configure_command='configure'
configure_option=''
sudo_permission='0'
while getopts ":d:c:o:s:h" opt; do
    case "$opt" in
    d)
        download_url="$OPTARG"
        ;;
    c)
        configure_command="$OPTARG"
        ;;
    o)
        configure_option="$OPTARG"
        ;;
    s)
        sudo_permission="$OPTARG"
        ;;
    h)
        usage
        exit 2
        ;;
    ?)
        usage
        exit 2
        ;;
    esac
done

if [ -z ${download_url} ]; then
    echo '-d option (download url) is empty'
    exit 2
fi


# 1. download the source
curl -O ${download_url}

# 2. uncompress the files, then remove
tar_package_name=${download_url##*/} # Longest Substring Match - http://blog.csdn.net/princess9/article/details/7621178
tar -xzf ${tar_package_name}
rm -rf ${tar_package_name}

# 3. move to `User App Root`
file_name=${tar_package_name%%.[a-z]*}
user_app_root='/usr/app/'
mv ${file_name}/ ${user_app_root}
cd ${user_app_root}

# 4. create `symbolic link`
symbolic_link=${file_name%%-*}
ln -s ${file_name}/ ${symbolic_link}

# 5. configure
cd ${symbolic_link}
if [ -z ${configure_option} ]; then
    ./${configure_command}
else
    ./${configure_command} ${configure_option}
fi

# 6. build the source
make -j2

# 7. install
if [ '0' -eq ${sudo_permission} ]; then
    make install
else
    sudo make install
fi
