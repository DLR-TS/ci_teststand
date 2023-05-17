
build_artifact_test(){
    local action=test
    local name="build artifact test"
    local description="tests if required build artifacts were generated"
    local message=""
    local exit_code=0
    printf "\n"
    printf "  Test: %s\n" "${name}"
    printf "    Description: %s\n" "${description}"
    printf "    Build artifacts: \n"
    for build_artifact in "${build_artifacts[@]}"; do
        if compgen -G "${build_artifact}" > /dev/null; then
            printf "      %-75s %s\n" "${build_artifact}" "$(bold $(green "EXISTS"))" 
        else
            printf "      %-75s %s\n" "${build_artifact}" "$(bold "$(red "DOES NOT EXIST")")" 
            exit_code=1
        fi
    done
    if [[ $exit_code == 0 ]]; then
        message="all build artifacts exist"
        printf "    Message: %s\n" "${message}"
        status=$(bold $(green "PASSED")) 
        printf "    %-77s %s\n" "Status:" "${status}"
    else
        message="Build artifacts missing"
        printf "    Message: %-76s\n" "${message}"
        status=$(bold $(red "FAILED"))
        printf "    %-77s %s\n" "Status:" "${status}"
    fi
    exit $exit_code
}


x_log_file_test(){
    local action=test
    local name="log file test"
    local description="tests if all log files specified by the 'log_files' env var exist and are not empty"
    local message=""
    local exit_code=0
    printf "\n"
    printf "  Test: %s\n" "${name}"
    printf "    Description: %s\n" "${description}"
    printf "    Log files: \n"
    for log_file in "${log_files[@]}"; do
        printf "      Log file: %s\n" "${log_file}"
        if compgen -G "${log_file}" > /dev/null; then
            printf "        %-73s %s\n" "EXISTS:" "$(bold $(green "TRUE"))"
        else
            printf "        %-73s %s\n" "EXISTS:" "$(bold $(red "FALSE"))"
            exit_code=1
        fi
        if [ -s "${log_file}" ]; then
            printf "        %-73s %s\n" "EMPTY:" "$(bold $(green "TRUE"))"
        else
            printf "        %-73s %s\n" "EMPTY:" "$(bold $(red "FALSE"))"
            exit_code=1
        fi
    done
    if [[ $exit_code == 0 ]]; then
        message="All log files exist"
        printf "    Message: %s\n" "${message}" 
        status=$(bold $(green "PASSED")) 
        printf "    %-77s %s\n" "Status:" "${status}"
    else
        message="Log file missing or is empty"
        printf "    Message: %s\n" "${message}"
        status=$(bold $(red "FAILED"))
        printf "    %-77s %s\n" "Status:" "${status}"
    fi
    exit $exit_code
}

