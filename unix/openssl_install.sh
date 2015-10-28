#!/usr/bin/env bash

# -----------------------------------------------
# Install 'OpenSSL'.
#
# Download 'OpenSSL' - https://www.openssl.org/source/
#
# User: xingle
# Date: 15/10/27
# Time: 23:30
# -----------------------------------------------

usage () {
    echo "Usage:"
    echo "sh openssl_install.sh -v '1.0.2d'"
    echo "  -v  the latest stable version"
}

version=''
while getopts ":v:h" opt; do
    case ${opt} in
    v)
        version=${OPTARG}
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
download_url="https://www.openssl.org/source/openssl-$version.tar.gz"

# install
sh ../base/install_template.sh -d ${download_url} -c 'config' -s '1'
