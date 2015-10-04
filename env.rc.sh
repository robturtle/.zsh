#!/bin/zsh
# Environment

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# user
export DEFAULT_USER="jeremy"
export INSTALLER="brew install"

# auto-updating git repos
MY_GIT_REPOS=()
HOME_GIT_REPOS=('.zsh' '.emacs.d')

# default editor
export EDITOR="vim"

# languages
export PYTHON="python2.7"
export MY_JAVA_LIB="${HOME}/include/java/"

# platform
export PLATFORM=`uname -s`

# ssh
export SSH_KEY_PATH="~/.ssh/dsa_id"

# path
for p in ".cabal/bin"
do
    export PATH="${PATH}:${HOME}/${p}"
done

# Java
for jar in "${MY_JAVA_LIB}/*.jar"; do
    export CLASSPATH="$jar:$CLASSPATH"
done

# updates
export my_zsh_check_updates_cycle=7
