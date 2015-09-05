#!/usr/bin/env bash

# -----------------------------------------------
# Alias definition.
#
# User: Bert Lee
# Date: 2015/9/2
# Time: 15:21
# -----------------------------------------------

bash_aliases="$1"
sh "$script_dir"/create_empty_exe_file.sh "$bash_aliases"

if [ -f "$bash_aliases" ]; then
    # Alias definitions
    echo "# ls" > "$bash_aliases"   # > : clear file's content
    echo "alias ll='ls -alF'" >> "$bash_aliases"
    echo "alias la='ls -A'" >> "$bash_aliases"
    echo "alias l='ls -CF'" >> "$bash_aliases"

    echo "" >> "$bash_aliases"
    echo "# grep" >> "$bash_aliases"
    echo "alias grep='grep --color=auto --exclude-dir=\.git\.svn'" >> "$bash_aliases"
fi

if [ -f "$bashrc" ]; then
    # load Alias
    echo "" >> "$bashrc"
    echo "# if define Aliases" >> "$bashrc"
    echo "[ -r $bash_aliases ] && . $bash_aliases" >> "$bashrc"
fi
