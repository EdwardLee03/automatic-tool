#!/usr/bin/env bash

# -----------------------------------------------
# Install 'wget'.
# (http://osxdaily.com/2012/05/22/install-wget-mac-os-x/)
#
# Download 'wget' - http://ftp.gnu.org/gnu/wget/
# http://www.gnu.org/software/wget/
#
# User: xingle
# Date: 15/10/27
# Time: 17:55
# -----------------------------------------------

usage () {
    echo "Usage:"
    echo "sh wget_install.sh -v '1.16.3'"
    echo "  -v  the latest stable version"
}

version=''
while getopts ":v:h" opt; do
    case "$opt" in
    v)
        version="$OPTARG"
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

if [ -z ${version} ]; then
    echo '-v option (the latest stable version) is empty'
    exit 2
fi


# the latest stable version
download_url="http://ftp.gnu.org/gnu/wget/wget-$version.tar.gz"
configure_option='--with-ssl=openssl --with-libssl-prefix=/usr/local/ssl/lib'

# install
sh ../base/install_template.sh -d "$download_url" -c "$configure_option"
