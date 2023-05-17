# This Makefile contains useful targets that can be included in downstream projects.

ifeq ($(filter ci_teststand.mk, $(notdir $(MAKEFILE_LIST))), ci_teststand.mk)

MAKEFLAGS += --no-print-directory

.PHONY: ci_test
ci_test:
	cd ${ROOT_DIR} && bash .ci test

.PHONY: ci_pipeline 
ci_pipeline:
	cd ${ROOT_DIR} && bash .ci


.PHONY: load_docker_images
load_docker_images: set_env
	@find ${ROOT_DIR}/${PROJECT}/build -maxdepth 1 -type f -name "**.tar" -exec  docker load --input {} \;

.PHONY: save_docker_images
save_docker_images: set_env
	@source ${ROOT_DIR}/ci.env && \
    for docker_image in "$${docker_images[@]}"; do\
        docker save --output "${ROOT_DIR}/${PROJECT}/build/$${docker_image//:/_}.tar" $${docker_image};\
    done;

endif
