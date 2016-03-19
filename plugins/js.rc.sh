# JavaScript Terminal Runner
initinstall npm ${INSTALLER} npm

function install-js {
    initinstall $1 "npm install -g $1"
}

# for developing (Spacemacs)
install-js tern
install-js js-beautify
install-js jshint
install-js browser-sync
