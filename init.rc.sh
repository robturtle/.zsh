#!/bin/bash

function exists {
    which $1 &> /dev/null
}

function initinstall {
    exists $1
    if [[ "$?" != "0" ]]; then
        echo "$1 not installed. Installing ..."
        shift
        eval `echo $@`
    fi
}

# platform
export PLATFORM=`uname -s`

if [[ "$PLATFORM" == 'Darwin' && `echo "$INSTALLER" | cut -d " " -f 1` == 'brew' ]]; then
    initinstall brew ruby -e '"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
fi

initinstall zsh ${INSTALLER} zsh
initinstall ${PYTHON} ${INSTALLER} ${PYTHON}
initinstall easy_install 'sudo curl https://bootstrap.pypa.io/ez_setup.py -o - | sudo ${PYTHON}'
initinstall pip sudo easy_install pip
initinstall percol sudo pip percol
initinstall ranger ${INSTALLER} ranger
