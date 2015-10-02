# Environment

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# user
export DEFAULT_USER="jeremy"
export PYTHON="python2.7"
export MY_JAVA_LIB="${HOME}/include/java/"

export INSTALLER="brew install"

# default editor
export EDITOR="vim"

# platform
export PLATFORM=`uname -s`

# ssh
export SSH_KEY_PATH="~/.ssh/dsa_id"

# path
for p in ".rvm/bin"  \
            ".rvm/gems/ruby-2.1.5/bin" \
            ".rvm/gems/ruby-2.1.5@global/bin" \
            ".rvm/rubies/ruby-2.1.5/bin" \
            ".cabal/bin"
do
    export PATH="${PATH}:${p}"
done

# Java
for jar in "${MY_JAVA_LIB}/*.jar"; do
    export CLASSPATH="$jar:$CLASSPATH"
done
