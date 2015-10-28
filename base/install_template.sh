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
    echo "sh install_template.sh -d 'xxx' [-c 'xxx' -o 'xxx' -m 'xxx' -s '0' -t '0']"
    echo "  -d  download url"
    echo "  -c  command of configure"
    echo "  -o  option of configure"
    echo "  -m  option of make"
    echo "  -s  sudo install (0|1)"
    echo "  -t  make test (0|1)"
}

download_url=''
configure_command='configure'
configure_option=''
make_option=''
is_sudo_install='0'
is_make_test='0'
while getopts ":d:c:o:m:s:t:h" opt; do
    case ${opt} in
    d)
        download_url=${OPTARG}
        ;;
    c)
        configure_command=${OPTARG}
        ;;
    o)
        configure_option=${OPTARG}
        ;;
    m)
        make_option=${OPTARG}
        ;;
    s)
        is_sudo_install=${OPTARG}
        ;;
    t)
        is_make_test=${OPTARG}
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
echo "\033[32m Downloading $download_url \033[0m"
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
echo "\033[32m Building the source \033[0m"
if [ -z ${make_option} ]; then
    make
else
    make ${make_option}
fi

# 7. test
if [ '1' -eq ${is_make_test} ]; then
    echo "\033[32m Testing \033[0m"
    make test
fi

# 8. install
echo "\033[32m Installing \033[0m"
if [ '0' -eq ${is_sudo_install} ]; then
    make install
else
    sudo make install
fi
