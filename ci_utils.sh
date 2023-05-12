#!/usr/bin/env bash

bold() {
    printf "\033[1m%s\033[0m" "$1"
}

red() {
    printf "\033[1;31m%s\033[0m" "$1"
}

green() {
    printf "\033[1;32m%s\033[0m" "$1"
}

iso8601_datetime() {
  date -u +"%Y-%m-%dT%H:%M:%SZ"
}

ci_log() {
    local logdir="${SUBMODULES_PATH}/.log"
    local logfile="${logdir}/${project}.ci.log"
    mkdir -p "${logdir}"
    touch "${logfile}"
    if [[ ! -f "${logfile}" ]]; then
        echo "ERROR FNF"
        exit 1
    fi
    printf "\n" | tee -a "${logfile}"
    printf "CI Task Started:\n" | tee -a "${logfile}"
    printf " ISO8601 Datetime: %s\n" "$(iso8601_datetime)" | tee -a "${logfile}"
    IFS='\n'
    while read -r input; do
        echo "$input" 2>&1 | tee -a >( sed -r 's/\x1b\[[0-9;]*m//g' >> "${logfile}") 
    done
}
