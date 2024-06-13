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
	@if [ -d "${ROOT_DIR}/${PROJECT}" ]; then \
		echo "Loading docker images in: \"${ROOT_DIR}/${PROJECT}/build\" ..."; \
	    find ${ROOT_DIR}/${PROJECT}/build -maxdepth 1 -type f -name "*.tar" -exec docker load --input {} \; ;\
	    exit 0; \
	elif [ -d "${ROOT_DIR}/build" ]; then \
	    echo "Loading docker images in: \"${ROOT_DIR}/build\" ..."; \
	    find ${ROOT_DIR}/build -maxdepth 1 -type f -name "*.tar" -exec docker load --input {} \; ;\
	    exit 0; \
	else \
	    echo "No docker images to load."; \
	    exit 0; \
	fi

.PHONY: save_docker_images

save_docker_images: set_env
	@source ${ROOT_DIR}/ci.env && \
	if [ -d "${ROOT_DIR}/${PROJECT}" ]; then \
		echo "Saving docker images to: ${ROOT_DIR}/${PROJECT}/build"; \
		mkdir -p ${ROOT_DIR}/${PROJECT}/build && \
		for docker_image in "$${docker_images[@]}"; do \
			echo "    Saving image: $${docker_image} to ${ROOT_DIR}/${PROJECT}/build/$${docker_image//:/_}.tar"; \
			docker save --output "${ROOT_DIR}/${PROJECT}/build/$${docker_image//:/_}.tar" $${docker_image}; \
		done; \
	else \
		echo "Saving docker images to: ${ROOT_DIR}/build"; \
		mkdir -p "${ROOT_DIR}/build"; \
		for docker_image in "$${docker_images[@]}"; do \
			echo "    Saving image: $${docker_image} to ${ROOT_DIR}/build/$${docker_image//:/_}.tar"; \
			docker save --output "${ROOT_DIR}/build/$${docker_image//:/_}.tar" $${docker_image}; \
		done; \
	fi


endif
