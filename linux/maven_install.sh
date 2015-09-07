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
    echo "Failed: -v param must be not empty!";
    exit 3
fi

# to Downloads
cd ~/Downloads/

# extract archive files
maven_file=apache-maven-"$maven_version"
maven_bin="$maven_file"-bin.tar
if [ ! -e "$maven_bin" ]; then
    echo -e "\033[31m Failed: '$maven_bin' is not exist, please download first! \033[0m"
    exit 3
fi
tar -xzvf "$maven_bin"

# move to User's App Root
user_app=/usr/app/
mv "$maven_file" "$user_app"

# create Soft Link
ln -s "$user_app""$maven_file" "$user_app"maven

maven_dir="$user_app"maven

dev_env="$HOME/.dev_env"
echo '' >> "$dev_env"
echo '# config Maven' >> "$dev_env"
echo "export M2_HOME=$maven_dir" >> "$dev_env"
echo 'export PATH=$M2_HOME/bin:$PATH' >> "$dev_env"

# reload User's Profile
profile="$HOME/.profile"
[ -r "$profile" ] && . "$profile"

[ $? -eq 0 ] && echo -e "\nset M2_HOME to '$maven_dir'"
