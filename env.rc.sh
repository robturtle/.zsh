#!/bin/bash
# Environment

# You may need to manually set your language environment
[[ -z "$LANG" ]] && export LANG=en_US.UTF-8

# user
[[ -z "$INSTALLER" ]] && export INSTALLER="brew install"

# auto-updating git repos
[[ -z "$MY_GIT_REPOS" ]] && MY_GIT_REPOS=()
[[ -z "$HOME_GIT_REPOS" ]] && HOME_GIT_REPOS=('.zsh' '.emacs.d')

# default editor
[[ -z "$EDIOR" ]] && export EDITOR="vim"

# languages
[[ -z "$PYTHON" ]] && export PYTHON="python2.7"

# ssh
[[ -z "$SSH_KEY_PATH" ]] && export SSH_KEY_PATH="~/.ssh/dsa_id"

# updates
[[ -z "my_zsh_check_updates_cycle" ]] && export my_zsh_check_updates_cycle=7
