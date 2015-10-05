#!/bin/zsh

[[ -z "$MY_JAVA_CP" ]] && export MY_JAVA_CP="${HOME}/include/java/"
[[ -d "$MY_JAVA_CP" ]] || mkdir -p "$MY_JAVA_CP"

function exists-jar {
    test -f "${MY_JAVA_CP}/$1.jar"
}


function install-jar {
    echo "$1 not found. Installing ..."
    echo
    shift
    pushd "${MY_JAVA_CP}" >/dev/null
    "$@"
    popd >/dev/null
}


# A Java REPL
if ! exists-jar javarepl; then
    install-jar javarepl curl -O http://albertlatacz.published.s3.amazonaws.com/javarepl/javarepl.jar
fi
alias javarepl="java -jar \"${MY_JAVA_CP}\"/javarepl.jar"


if [[ -d "${MY_JAVA_CP}" ]]; then
    for jar in "${MY_JAVA_CP}"/*.jar; do
        export CLASSPATH="$jar:$CLASSPATH"
    done
fi
