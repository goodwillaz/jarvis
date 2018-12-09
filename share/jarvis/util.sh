#!/usr/bin/env bash

function ask() {
    local prompt default REPLY
    while true; do

        if [ "${2:-}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi

        # Ask the question
        read -p "$1 [$prompt] " REPLY

        # Default?
        if [ -z "$REPLY" ]; then
            REPLY=$default
        fi

        # Check if the reply is valid
        case "$REPLY" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac

    done
}
export -f ask

function run_with_sudo() {
    local command_file=${1##*/}
    local command=${command_file#*-}
    shift

    exec sudo "${_JARVIS_ROOT}/libexec/jarvis" ${command} "${@}"
}
export -f run_with_sudo

function update_apache_jarvis() {
    jq -r '.parked[]? | ("Use MassVhosts " + .)' $_JARVIS_CONFIG > /etc/apache2/jarvis/parked.conf
    jq -r '.override[]? | ["Use Php", .path, .version] | join(" ")' $_JARVIS_CONFIG > /etc/apache2/jarvis/php.conf
    service apache2 reload
}
export -f update_apache_jarvis
