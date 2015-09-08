#!/usr/bin/env bash

# -----------------------------------------------
# Install Apache Maven.
# (http://maven.apache.org/install.html)
#
# Example:
#    sh maven_install.sh -v '3.3.3'
#
#
# Download Apache Maven - http://maven.apache.org/download.cgi
#
# User: Bert Lee
# Date: 2015/9/2
# Time: 15:06
# -----------------------------------------------

usage () {
    echo "Usage:"
    echo ""
    echo "  -v  Maven version for used"
}

maven_version=''
while getopts ":v:h" opt; do
    case "$opt" in
    v)
        maven_version="$OPTARG"
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

if [ -z "$maven_version" ]; then
    echo -e "\033[31m Failed: -v param must be not empty! \033[0m"
    exit 3
fi

# extract archive files
maven_file=apache-maven-"$maven_version"
maven_bin=~/Downloads/"$maven_file"-bin.tar
if [ ! -e "$maven_bin" ]; then
    echo -e "\033[31m Failed: '$maven_bin' is not exist, please download first! \033[0m"
    exit 3
fi

# move to User's App Root
user_app=/usr/app/
tar -C "$user_app" -xzf "$maven_bin"
cd "$user_app"

# create Soft Link
soft_link='maven'
ln -s "$maven_file" "$soft_link"

maven_home="$user_app""$soft_link"

dev_env="$HOME/.dev_env"
echo '' >> "$dev_env"
echo '# config Maven' >> "$dev_env"
echo "export M2_HOME=$maven_home" >> "$dev_env"
echo 'export PATH=$M2_HOME/bin:$PATH' >> "$dev_env"

# reload User's Profile
profile="$HOME/.profile"
[ -r "$profile" ] && . "$profile"

[ $? -eq 0 ] && echo -e "\033[32m Set M2_HOME to '$maven_home' \033[0m"
