#!/bin/bash

function exists { which $1 &> /dev/null }

function initinstall {
    exists $1
    if [[ "$?" != "0" ]]; then
        echo "$1 not installed. Installing ..."
        shift
        "$@"
    fi
}

# platform
export PLATFORM=`uname -s`

if [[ "$PLATFORM" == 'Darwin' && `echo "$INSTALLER" | cut -d " " -f 1` == 'brew' ]]; then
    initinstall brew ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    initinstall zsh brew install zsh
fi

initinstall easy_install sudo curl https://bootstrap.pypa.io/ez_setup.py -o - | ${PYTHON}
initinstall percol sudo easy_install percol
