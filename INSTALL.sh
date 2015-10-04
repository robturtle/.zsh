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

for link in .zshrc .percol.d
do
    echo "Now install my $link"
    differ=`diff "${PWD}/$link" "${HOME}/$link" 2>/dev/null`
    if [[ "$?" != "0" || -n "$differ" ]]; then
        [[ -f "${HOME}/$link" || -d "${HOME}/$link" ]] && mv "${HOME}/$link" "${HOME}/$link.bk"
        echo "Creating link to ~/$link"
        echo
        ln -s "${PWD}/$link" "${HOME}"
    else
        echo "$link is already up-to-date."
    fi
done
