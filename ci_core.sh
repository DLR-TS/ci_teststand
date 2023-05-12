#!/usr/bin/env bash

set -o pipefail

echoerr (){ printf "%s\n" "$@" >&2;}
exiterr (){ echoerr "$@"; exit 1;}

if [[ ! -f ".env" ]]; then
    echoerr "ERROR: Environment file: .env does not exist."
    exit 1
fi


ci_common_build (){
    local action=build
    local status=""
    printf "\n"
    printf "  Action: %s\n" "$(bold ${action})"
    if make build; then
        printf "\n"
        status=$(bold $(green "PASSED"))
        printf "    Status: %s: %s\n" "${action}" "${status}"
    else
        printf "\n"
        status=$(bold $(red "FAILED"))
        printf "    Status: %s: %s\n" "${action}" "${status}"
        exit 1
    fi
}

ci_common_test (){
    local action=tests
    local exit_code=0
    printf "\n"
    printf "  Action: %s\n" "$(bold ${action})"

    for function_name in $(declare -F | awk '{print $3}' | grep -v "ci_common_test"); do
        if [[ $function_name == *_test* ]]; then
            ($function_name) || exit_code=$?
        fi
    done

    printf "\n"
    if [[ $exit_code == 0 ]]; then
        status=$(bold $(green "PASSED"))
        printf "    Overall status: %s: %s\n" "${action}" "${status}"
    else
        status=$(bold $(red "FAILED"))
        printf "    Overall status: %s: %s\n" "${action}" "${status}"
    fi
    exit "$exit_code"
}

ci_run(){
    if declare -f "$1" > /dev/null; then
        "$@" | ci_log
    else
        ci_pipeline | ci_log 
    fi
}

