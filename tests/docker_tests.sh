#!/usr/bin/env bash

1_docker_test(){
    local action=test
    local name="docker test #1"
    local description="Tests is docker is installed on the host system"
    local status=""
    local message=""
    printf "\n"
    printf "  Test: %s\n" "${name}"
    printf "    Description: %s\n" "${description}"
    printf "    Project: %s\n" "${project}"
    if command -v docker >/dev/null 2>&1; then
        printf "\n"
        printf "  Action: %s\n" "$(bold ${action})"
        status=$(bold $(green "PASSED"))
        printf "    %-77s %s\n" "Status:" "${status}"
    else
        printf "\n"
        printf "  Action: %s\n" "$(bold ${action})"
        status=$(bold $(red "FAILED"))
        printf "    %-77s %s\n" "Status:" "${status}"
        exit 1
    fi

}

2_docker_test(){
    local action=test
    local name="docker test #2" 
    local description="Tests if docker hello world can run on the system"
    local status=""
    local message=""
    printf "\n"
    printf "  Test: %s\n" "${name}"
    printf "    Description: %s\n" "${description}"
    printf "    Project: %s\n" "${project}"
    if docker run --rm hello-world >/dev/null; then
        printf "\n"
        printf "  Action: %s\n" "$(bold ${action})"
        status=$(bold $(green "PASSED"))
        printf "    %-77s %s\n" "Status:" "${status}"
    else
        printf "\n"
        printf "  Action: %s\n" "$(bold ${action})"
        status=$(bold $(red "FAILED"))
        printf "    %-77s %s\n" "Status:" "${status}"
        exit 1
    fi

}

3_docker_image_test1(){
    local action=test
    local name="docker image test #1"
    local description="tests if the docker image is set"
    local status=""
    local message=""
    printf "\n"
    printf "  Test: %s\n" "${name}"
    printf "    Description: %s\n" "${description}"
    printf "    Docker image: %s\n" "${docker_image}"
    if [ -n "${docker_image+x}" ] && [ -n "$docker_image" ]; then
        message="Docker image is set and is not empty"
        printf "    Message: %s\n" "${message}"
        status=$(bold $(green "PASSED"))
        printf "    %-77s %s\n" "Status:" "${status}"
    else
        message="Docker image is not set or is empty"
        printf "    Message: %s\n" "${message}"
        status=$(bold $(red "FAILED"))
        printf "    %-77s %s\n" "Status:" "${status}"
        exit 1
    fi

}

4_docker_image_test2(){
    local action=test
    local name="docker image test #2"
    local description="Tests if the docker image exists specified by the 'docker_image' env var. The command 'docker images ${docker_image}' should produce 1 element."
    local status=""
    local message=""
    printf "\n"
    printf "  Test: %s\n" "${name}"
    printf "    Description: %s\n" "${description}"
    printf "    Docker image: %s\n" "${docker_image}"
    if [ ! -n "${docker_image+x}" ] && [ ! -n "$docker_image" ]; then
        message="No docker image specified"
        printf "    Message: %-76s\n" "${message}"
        status=$(bold $(green "PASSED"))
        printf "    %-77s %s\n" "Status:" "${status}"
        exit 0 
    fi

    if [[ "$(docker images -q "${docker_image}" 2> /dev/null)" != "" ]]; then
        message="Docker image exists"
        printf "    Message: %-76s\n" "${message}"
        status=$(bold $(green "PASSED"))
        printf "    %-77s %s\n" "Status:" "${status}"
    else
        message="Docker image does not exist"
        printf "    Message: %-76s\n" "${message}"
        status=$(bold $(red "FAILED"))
        printf "    %-77s %s\n" "Status:" "${status}"
        exit 1
    fi
}


5_docker_images_test(){
    local action=test
    local name="docker images test"
    local description="Tests if all docker images exists specified by the 'docker_images' env var."
    local status=""
    local message=""
    local exit_code=0
    printf "\n"
    printf "  Test: %s\n" "${name}"
    printf "    Description: %s\n" "${description}"
    printf "    Docker images: \n"
 
    for image in "${docker_images[@]}"; do
        if [[ "$(docker images -q "${image}" 2> /dev/null)" != "" ]]; then
            printf "        Docker image: %-59s %s\n" "${image}" "$(bold "$(green "EXISTS")")" 
        else
            printf "        Docker image: %-59s %s\n" "${image}" "$(bold "$(red "DOES NOT EXISTS")")" 
            exit_code=1
        fi

    done
    
    if [[ $exit_code == 0 ]]; then
        message="all docker images specified by the env var 'docker_images' exist"
        printf "    Message: %s\n" "${message}"
        status=$(bold $(green "PASSED")) 
        printf "    %-77s %s\n" "Status:" "${status}"
    else
        message="some docker images missing"
        printf "    Message: %s\n" "${message}"
        status=$(bold $(red "FAILED"))
        printf "    %-77s %s\n" "Status:" "${status}"
    fi
    exit $exit_code

}


6_docker_images_clean_disabledtest(){
    local action=test
    local name="docker images clean test"
    local description="Tests if all docker images exists specified by the 'docker_images' env var are cleaned from the local registry."
    local status=""
    local message=""
    local exit_code=0
    printf "\n"
    printf "  Test: %s\n" "${name}"
    printf "    Description: %s\n" "${description}"
    printf "    Docker images: \n"
    for image in "${docker_images[@]}"; do
        if [[ "$(docker images -q "${image}" 2> /dev/null)" != "" ]]; then
            printf "      Docker image: %-95s %s\n" "${image}" "$(bold "$(red "EXISTS")")" 
            exit_code=1
        else
            printf "      Docker image: %-95s %s\n" "${image}" "$(bold "$(green "DOES NOT EXISTS")")" 
        fi
    done
    if [[ $exit_code == 0 ]]; then
        message="all docker images specified by the env var 'docker_images' are clean from the local registry"
        printf "    Message: %s\n" "${message}" 
        status=$(bold $(green "PASSED")) 
        printf "    %-77s %s\n" "Status:" "${status}"
    else
        message="some docker images were not cleaned"
        printf "    Message: %s\n" "${message}"
        status=$(bold $(red "FAILED"))
        printf "    %-77s %s\n" "Status:" "${status}"
    fi
    exit $exit_code
}
