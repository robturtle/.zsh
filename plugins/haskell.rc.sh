#!/bin/zsh

# cabal default executables' path
for p in ".cabal/bin"
do
    export PATH="${PATH}:${HOME}/${p}"
done
