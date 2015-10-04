#!/bin/zsh
# Functions
# Show stastics message of top used commands
function topcmds {
    history| awk '{cmd[$4]++} END {for (c in cmd) print cmd[c], "\t", c}' \
    | sort -r -n -k 1 | head
}

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

## Killer function: searching zsh history
## short-cut      : Ctrl+R
## Usage : type Ctrl-R at any time while you typing, it will list all your zsh history commands
##         partially matches your typing (different keywords separated by whitespaces). Then press
##         Enter to paste the command you select back to your shell prompt.
if exists percol; then
    function percol_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }

    zle -N percol_select_history
    bindkey '^R' percol_select_history
fi

### Ranger facilities
## Killer function: file manager. quit with directory chagned
## shor-cut       : Ctrl-S
# Compatible with ranger 1.4.2 through 1.6.*
#
# Automatically change the directory in bash after closing ranger
#
# This is a bash function for .bashrc to automatically change the directory to
# the last visited one after ranger quits.
# To undo the effect of this function, you can type "cd -" to return to the
# original directory. Ranger facility -- Auto cd to last dir
function ranger_cd() {
    tempfile='/tmp/chosendir'
    /usr/bin/env ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}
bindkey -s '^S' 'ranger_cd\n'

## Helper function: put stdin contents into System clipboard
## name           : pclip
## Usage : echo "hello world" | pclip
function pclip {
    if [[ "$PLATFORM" == "CYGWIN" ]]; then
        putclip "$@";
    elif [[ "$PLATFORM" == "Darwin" ]]; then
        pbcopy "$@";
    elif [[ -x /usr/bin/xsel ]]; then
        xsel -ib "$@";
    elif [[ -x /usr/bin/xclip ]]; then
        xclip -selection c "$@";
    else
        echo "No proper clipper application (xsel, xclip, putclip, pbcopy) found"
    fi
}

# Usage: Type "ff partials-of-file-path" in the bash shell. A filter window will popup. You can filter and scroll down/up in that window to select one file. The full path of the file will be copied into system clipboard automatically (under Linux, you need install either xsel or xclip to access clipboard).
#
# The paritls-of-file-path could contain wildcard character. For example, "…/grunt-docs/*bootstrap*css" is a fine example.
function ff {
    local fullpath=$*
    local filename=${fullpath##*/} # remove "/" from the beginning
    filename=${filename##*./} # remove  ".../" from the beginning
    echo file=$filename
    #  only the filename without path is needed
    # filename should be reasonable
    local cli=`find $PWD \
            -not -iwholename '*/target/*' \
            -not -iwholename '*.svn*' \
            -not -iwholename '*.git*' \
            -not -iwholename '*.sass-cache*' \
            -not -iwholename '*.hg*' \
            -type f -iwholename '*'${filename}'*' \
            -print | percol`
    echo ${cli}
    echo -n ${cli} |pclip;
}

## Update all my repos
function yang-update {
    if [[ -d "${HOME}/.emacs.d/.git/" ]]; then
        pushd "${HOME}/.emacs.d/" >/dev/null
        have_upstream=`git branch | grep 'upstream'`
        if [[ -z "$have_upstream" ]]; then
            echo "~/.emacs.d don't have branch upstream. Not updating."
        else
            echo "Fetching upstream..."
            git fetch upstream
            echo "Rebasing upstream..."
            git rebase upstream
        fi
        popd >/dev/null
    fi

    if [[ -d "${HOME}/.zsh/.git/" ]]; then
        pushd "${HOME}/.zsh/" >/dev/null
        current_br=`git branch | grep '*' | tr -d '* '`
        remote=`git remote | cut -f 1`
        have_upstream=`git branch | grep 'upstream'`
        if [[ "$current_br" == "master" ]]; then
            echo "Pulling from $remote"
            git pull "$remote"
        elif [[ -z "$have_upstream" ]]; then
            echo "~/.zsh don't have branch upstream. Not updating."
        else
            echo "Fetching upstream..."
            git fetch upstream
            echo "Rebasing upstream..."
            git rebase upstream
        fi
        popd >/dev/null
    fi
}
