
lint_test(){
    local action=test
    local name="lint test"
    local description="runs cpplint, if there are lint errors this is a failure."
    local message=""
    local exit_code=0
    printf "\n"
    printf "  Test: %s\n" "${name}"
    printf "    Description: %s\n" "${description}"
    if make lint > /dev/null 2>&1; then
        message="no lint errors"
        printf "    Message: %s\n" "${message}" 
        status=$(bold $(green "PASSED")) 
        printf "    Status: %s: %s\n" "${action}" "${status}" 
    else
        message="lint errors exist"
        printf "    Message: %s\n" "${message}"
        status=$(bold $(red "FAILED"))
        printf "    Status: %s\n" "${status}"
        exit 1
    fi

}


cppcheck_test(){
    local action=test
    local name="cppcheck test"
    local description="runs cppcheck, if there are static checking errors this is a failure."
    local message=""
    local exit_code=0
    printf "\n"
    printf "  Test: %s\n" "${name}"
    printf "    Description: %s\n" "${description}"
    if make cppcheck > /dev/null 2>&1; then
        message="no cppcheck errors"
        printf "    Message: %s\n" "${message}" 
        status=$(bold $(green "PASSED")) 
        printf "    Status: %s: %s\n" "${action}" "${status}" 
    else
        message="cppcheck errors exist"
        printf "    Message: %s\n" "${message}"
        status=$(bold $(red "FAILED"))
        printf "    Status: %s\n" "${status}"
        exit 1
    fi

}
