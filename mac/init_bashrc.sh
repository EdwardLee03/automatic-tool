#!/usr/bin/env bash

# -----------------------------------------------
# Bash Shell initialization.
#
# User: Bert Lee
# Date: 2015/9/5
# Time: 14:59
# -----------------------------------------------

sh "$script_dir"/create_empty_exe_file.sh "$bashrc"

echo "### Bash Settings" >> "$bashrc"
echo "# don't put duplicate lines or lines starting with space in the history." >> "$bashrc"
echo "HISTCONTROL=ignoreboth" >> "$bashrc"

echo "" >> "$bashrc"
echo "# append to the history file, don't overwrite it" >> "$bashrc"
echo "shopt -s histappend" >> "$bashrc"

echo "" >> "$bashrc"
echo "# for setting history length" >> "$bashrc"
echo "HISTSIZE=6000" >> "$bashrc"
echo "HISTFILESIZE=10000" >> "$bashrc"

if [ -f "$profile" ]; then
    # load Bash Shell's setting
    echo "" >> "$profile"
    echo "# if running Bash" >> "$profile"
    echo "[ -r ~/$bashrc ] && . ~/$bashrc" >> "$profile"
fi

[ $? -eq 0 ] && echo "\033[32m Initialize Bash Shell for '~/$bashrc' completely \033[0m"
