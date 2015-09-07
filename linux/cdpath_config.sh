#!/usr/bin/env bash

# -----------------------------------------------
# Hack 1. Define CD Base Directory Using CDPATH.
#
# Example:
#    sh cdpath_config.sh -p '.:~:~/Documents/workspace:~/Documents/workspace/GitHub:~/Documents/Tech:~/Documents/Mogu'
#
# User: xingle
# Date: 15/9/6
# Time: 14:37
# -----------------------------------------------

usage () {
    echo "Usage:"
    echo ""
    echo "  -p  parent directory that cd to subdirectories"
}

cd_path='.:~'
while getopts ":p:h" opt; do
    case "$opt" in
    p)
        cd_path="$OPTARG"
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

if [ -z "$cd_path" ]; then
    echo "Failed: -p param must be not empty!";
    exit 3
fi

profile="$HOME/.profile"
echo '' >> "$profile"
echo '# define CD base directory' >> "$profile"
echo "export CDPATH=$cd_path" >> "$profile"

# reload User's Profile
[ -r "$profile" ] && . "$profile"

[ $? -eq 0 ] && echo "set CDPATH to '$cd_path'"
