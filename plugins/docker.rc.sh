initinstall docker $INSTALLER docker

if [[ "$PLATFORM" == 'Darwin' ]]; then
    $INSTALLER docker-machine
fi
