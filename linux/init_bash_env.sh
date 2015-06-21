#!/usr/bin/env bash

# -----------------------------------------------
# User's bash environment Initialization.
#
# User: Bert Lee
# Date: 2015/6/6
# Time: 18:11
# -----------------------------------------------

bashrc='~/.bashrc'
if [ ! -f "$bashrc" ]; then
    touch "$bashrc"
    echo "Successful create '$bashrc' file"
fi

bash_env='~/.bash_env'
if [ ! -f "$bash_env" ]; then
    touch "$bash_env"
    echo "Successful create '$bash_env' file"

    # load user environment variable
    echo '' >> "$bashrc"
    echo ". $bash_env" >> "$bashrc"
fi
