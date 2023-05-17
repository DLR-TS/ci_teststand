#!/usr/bin/env bash

# docker pull test
# latency test
# throughput test
# resource test: external hosts:



1_project_test(){
    local action=test
    local name="project test"
    local description="tests if the project env var is set"
    local status=""
    local message=""
    printf "\n"
    printf "  Test: %s\n" "${name}"
    printf "    Description: %s\n" "${description}"
    printf "    Project: %s\n" "${project}"
    if [ -n "${project+x}" ] && [ -n "$project" ]; then
        message="The project env var is set and is not empty"
        printf "    Message: %s\n" "${message}"
        status=$(bold $(green "PASSED"))
        printf "    %-77s %s\n" "Status:" "${status}"
    else
        message="The project env var is empty or not set"
        printf "    Message: %s\n" "${message}"
        status=$(bold $(red "FAILED"))
        printf "    %-77s %s\n" "Status:" "${status}"
        exit 1
    fi
}

