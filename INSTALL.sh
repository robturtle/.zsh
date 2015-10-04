#!/bin/zsh
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

echo "Now install my .zshrc"
diff "${PWD}/.zshrc" "${HOME}/.zshrc" 2>/dev/null
if [[ "$?" != "0" ]]; then
    [[ -f "${HOME}/.zshrc" ]] && mv "${HOME}/.zshrc" "${HOME}/.zshrc.bk"
    echo "Creating link to ~/.zshrc"
    echo
    ln -s "${PWD}/.zshrc" "${HOME}"
else
    echo "My .zshrc is already up-to-date."
fi

echo -n "Check ~/.percol.d/ ... "
if [[ -d "${HOME}/.percol.d/" ]]; then
    echo "Found."
else
    echo "Not Found."
    echo "Creating link to ~/.percol.d/"
    ln -s "${PWD}/.percol.d" "${HOME}"
fi
