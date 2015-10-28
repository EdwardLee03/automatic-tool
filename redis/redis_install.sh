#!/usr/bin/env bash

# -----------------------------------------------
# Install 'Redis'.
#
# Download 'Redis' - http://redis.io/download
#
# User: xingle
# Date: 15/10/28
# Time: 00:15
# -----------------------------------------------

usage () {
    echo "Usage:"
    echo "sh redis_install.sh -v '3.0.5'"
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
download_url="http://download.redis.io/releases/redis-$version.tar.gz"

# install
os=`uname -s`
if [ 'Linux' -eq ${os} ]; then
    sh ../base/install_template.sh -d ${download_url} -t '1'
else
    # use `jemalloc` memory allocator
    sh ../base/install_template.sh -d ${download_url} -m 'MALLOC=jemalloc' -t '1'
fi
