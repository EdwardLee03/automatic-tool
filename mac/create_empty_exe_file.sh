#!/usr/bin/env bash

# -----------------------------------------------
# Create an empty and execute file.
#
# User: Bert Lee
# Date: 2015/9/5
# Time: 14:40
# -----------------------------------------------

file_name="$1"
if [ ! -f "$file_name" ]; then
    echo "" > "$file_name"     # create an empty file
    echo "Successful create '$file_name' file"

#    chmod +x "$file_name"      # grant 'executable permission'
fi
