#!/bin/sh
[[ -f "${HOME}/.zshrc" ]] && mv "${HOME}/.zshrc" "${HOME}/.zshrc.bk"
echo "Creating link to ~/.zshrc"
ln -s "${PWD}/.zshrc" "${HOME}"
