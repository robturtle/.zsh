#!/bin/bash

[[ -d "${HOME}/Downloads/" ]] || mkdir "${HOME}/Downloads/"
themeweb='https://raw.githubusercontent.com/altercation/solarized/master/iterm2-colors-solarized/${theme}.itermcolors'
for theme in "Solarized Light" "Solarized Dark"
do
    if [[ ! -f "${HOME}/Downloads/${theme}.itermcolors" ]]; then
        curl  `eval "echo $themeweb | sed 's/ /%20/g'"`\
             > "${HOME}/Downloads/${theme}.itermcolors"
    fi
done

if ! zsh --version; then
    echo "zsh not found. Installing ..."
    source ./init.rc.sh
elif [[ "$SHELL" != `which zsh` || $(basename `echo $0 | tr -d '-'`) != "zsh" ]]; then
    echo "Now change zsh as your default shell ..."
    export SHELL=`which zsh`
    chsh -s `which zsh`
fi

echo -n "Check oh-my-zsh ... "
if [[ -d "${HOME}/.oh-my-zsh/" ]]; then
    echo "Found."
else
    echo "Not Found."
    echo "Installing on-my-zsh"
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    echo "Done."
    echo
fi

for link in .zshrc .percol.d
do
    echo "Now install my $link"
    differ=`diff "${PWD}/$link" "${HOME}/$link" 2>/dev/null`
    if [[ "$?" != "0" || -n "$differ" ]]; then
        [[ -f "${HOME}/$link" || -d "${HOME}/$link" ]] && mv "${HOME}/$link" "${HOME}/${link}.bk"
        echo "Creating link from ${PWD}/$link to ${HOME}/$link"
        echo
        ln -s "${PWD}/$link" "${HOME}/$link"
    else
        echo "$link is already up-to-date."
    fi
done
