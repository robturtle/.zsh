#!/bin/zsh

function exists { which $1 &> /dev/null }

function initinstall {
    exists $1
    if [[ "$?" != "0" ]]; then
        echo "$1 not installed. Installing ..."
        shift
        "$@"
    fi
}

if [[ "$PLATFORM" == 'Darwin' && "$INSTALLER" == 'brew' ]]; then
    initinstall brew ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

initinstall easy_install sudo curl https://bootstrap.pypa.io/ez_setup.py -o - | ${PYTHON}
initinstall percol sudo easy_install percol
