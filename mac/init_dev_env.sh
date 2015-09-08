#!/usr/bin/env bash

# -----------------------------------------------
# Develop Environment initialization.
#
# User: Bert Lee
# Date: 2015/9/2
# Time: 17:07
# -----------------------------------------------

dev_env="$1"
sh "$script_dir"/create_empty_exe_file.sh "$dev_env"

if [ -f "$bashrc" ]; then
    # set Develop Environment
    echo "" >> "$bashrc"
    echo "# if set Develop Environment" >> "$bashrc"
    echo "[ -r ~/$dev_env ] && . ~/$dev_env" >> "$bashrc"
fi

[ $? -eq 0 ] && echo "\033[32m Initialize Bash Shell for '~/$dev_env' completely \033[0m"
