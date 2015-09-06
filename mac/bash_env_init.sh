#!/usr/bin/env bash

# -----------------------------------------------
# User's Bash environment initialization.
#
# User: Bert Lee
# Date: 2015/9/5
# Time: 18:11
# -----------------------------------------------

### reference to TOMCAT_HOME/bin/startup.sh
# resolve links - $0 may be a softlink  (解析链接 - $0 可能是一个“软链接”)
# 执行程序
PRG="$0"

while [ -h "$PRG" ] ; do
  ls=`ls -ld "$PRG"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
  else
    PRG=`dirname "$PRG"`/"$link"
  fi
done

# 执行程序所在的根目录
export script_dir=`pwd "$PRG"`

# to User's root dir
cd ~

# initialize User's Profile
export profile='.profile'
sh "$script_dir"/init_profile.sh

# initialize Bash Shell
export bashrc='.bashrc'
sh "$script_dir"/init_bashrc.sh

# define Aliases
bash_aliases='.bash_aliases'
sh "$script_dir"/define_aliases.sh "$bash_aliases"

# initialize develop environment
dev_env='.dev_env'
sh "$script_dir"/init_dev_env.sh "$dev_env"

# load User's Bash setting
[ -r ~/"$profile" ] && . ~/"$profile"
