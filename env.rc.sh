#!/bin/bash
# Environment

# You may need to manually set your language environment
: ${LANG:=en_US.UTF-8}

# user
: ${INSTALLER:="brew install"}

# auto-updating git repos
[[ -z "$MY_GIT_REPOS" ]] && MY_GIT_REPOS=()
[[ -z "$HOME_GIT_REPOS" ]] && HOME_GIT_REPOS=('.zsh' '.emacs.d')

# default editor
: ${EDITOR:="vim"}

# languages
: ${PYTHON:="python2.7"}

# ssh
: ${SSH_KEY_PATH:="~/.ssh/dsa_id"}

# updates
: ${my_zsh_check_updates_cycle:=7}

# my scripts home
export PATH=${PATH}:~/bin

# FIX: since from some version, easy_insall didn't put bin files into
#      /usr/local/bin. So I will manuall put python apps into PATH
export PATH=${PATH}:/Library/Frameworks/Python.framework/Versions/Current/bin
