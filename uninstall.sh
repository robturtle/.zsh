#!/bin/bash
# For debugging, users don't use it

if [[ -z "${UNINSTALLER}" ]]; then
    echo -n "Tell me your command for removing packages (i.e. sudo apt-get remove): "
    read uninstaller
    echo "UNINSTALLER='$uninstaller'" >> ~/.zsh.my.sh
    source ~/.zsh.my.sh
fi

function remove {
    eval `echo $UNINSTALLER $1`
}

remove zsh
remove easy_install
remove ranger
sudo pip uninstall percol
sudo rm `which pip`
rm -rf "${HOME}/.oh-my-zsh"
