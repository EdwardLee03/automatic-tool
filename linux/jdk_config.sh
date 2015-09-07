#!/usr/bin/env bash

# -----------------------------------------------
# Config JDK environment.
#
# Example:
#    sh jdk_config.sh -v '1.8.0_60'
#
# User: Bert Lee
# Date: 2015/9/2
# Time: 16:42
# -----------------------------------------------

usage () {
    echo "Usage:"
    echo ""
    echo "  -v  JDK version for used"
}

jdk_version=''
while getopts ":v:h" opt; do
    case "$opt" in
    v)
        jdk_version="$OPTARG"
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

if [ -z "$jdk_version" ]; then
    echo -e "\033[31m Failed: -v param must be not empty! \033[0m";
    exit 3
fi

java_home=/Library/Java/JavaVirtualMachines/jdk"$jdk_version".jdk/Contents/Home

dev_env="$HOME/.dev_env"
echo '' >> "$dev_env"
echo '# config JDK' >> "$dev_env"
echo "export JAVA_HOME=$java_home" >> "$dev_env"
echo 'export PATH=$JAVA_HOME:$PATH' >> "$dev_env"

# reload User's Profile
profile="$HOME/.profile"
[ -r "$profile" ] && . "$profile"
#[ -r ~/.profile ] && . ~/.profile

[ $? -eq 0 ] && echo "set JAVA_HOME to '$java_home'"
