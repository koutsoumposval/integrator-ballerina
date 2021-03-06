.DEFAULT_GOAL := help

.PHONY: start
start: ## Start application
	docker network create external_network || true
	docker-compose up -d

.PHONY: stop
stop: ## Stop application
	docker-compose down

.PHONY: help
help: ## Help
	@grep -E '^[0-9a-zA-Z_/()$$-]+:.*?## .*$$' $(lastword $(MAKEFILE_LIST)) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

