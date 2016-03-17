initinstall docker $INSTALLER docker

if [[ "$PLATFORM" == 'Darwin' ]]; then
    initinstall docker-machine $INSTALLER docker-machine
fi
