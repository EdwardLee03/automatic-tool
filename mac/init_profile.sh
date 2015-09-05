#!/usr/bin/env bash

# -----------------------------------------------
# User's Profile initialization.
#
# User: Bert Lee
# Date: 2015/9/5
# Time: 14:58
# -----------------------------------------------

sh "$script_dir"/create_empty_exe_file.sh "$profile"

echo "# set PATH so it includes user's private bin if it exists" >> "$profile"
echo "if [ -d $HOME/bin ]; then" >> "$profile"
echo "    PATH=$HOME/bin:$PATH" >> "$profile"
echo "fi" >> "$profile"
