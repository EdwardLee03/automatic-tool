#!/usr/bin/env bash

# -----------------------------------------------
# Bash aliases definition.
#
# User: Bert Lee
# Date: 2015/6/7
# Time: 5:00
# -----------------------------------------------

bash_aliases='.bash_aliases'
if [ ! -f "$bash_aliases" ]; then
    touch "$bash_aliases"
    echo "Successful create '$bash_aliases' file"

    # load user environment variable
    echo '' >> "$bashrc"
    echo ". $bash_aliases" >> "$bashrc"
fi

# System aliases
echo '# ls' >> "$bash_aliases"
echo 'alias ll=\'ls -lF --color=auto\'' >> "$bash_aliases"
echo 'alias la=\'ls -alF --color=auto\'' >> "$bash_aliases"
echo 'alias ls=\'ls -F\'' >> "$bash_aliases"

echo 'alias grep=\'grep --color=auto --exclude-dir=\.git\.svn\'' >> "$bash_aliases"
