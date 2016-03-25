# JavaScript Terminal Runner
initinstall npm ${INSTALLER} npm

function install-js {
    initinstall $1 "npm install -g $1"
}

function browser-sync-start {
    ps | grep "[b]rowser-sync start" &> /dev/null
    if [[ "$?" == "0" ]]; then
        echo "browser-sync already started."
    else
        browser-sync start --server --files "*.html, css/*.css, javascript/*.js" $@
    fi
}

function browser-sync-on {
    if [[ -h index.html ]]; then
        rm index.html
    else
        mv index.html index.html.bk
    fi
    ln -s $1 index.html
    ps | grep "[b]rowser-sync start" &> /dev/null || browser-sync-start
}

# for developing (Spacemacs)
install-js tern
install-js js-beautify
install-js jshint
install-js browser-sync
