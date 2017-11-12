IMAGE=hrcc/go-ci:latest

.DEFAULT_GOAL := help

shell: ## Enters the shell
	docker run -it hrcc/go-ci:latest bash

build: ## Build the docker image
	docker build -t hrcc/go-ci:latest .
	docker history $(IMAGE) > build_log.txt

tests: ## Run the unit tests
	GOSS_FILES_PATH=./test dgoss run -t hrcc/go-ci:latest

help: ## Display this help message
	@cat $(MAKEFILE_LIST) | grep -e "^[a-zA-Z_\-]*: *.*## *" | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.SILENT: build test help