SHELL := /bin/bash
DOCKER_COMPOSE ?= docker compose
CONTAINER_NAME := shairport-sync
COMMANDS := help up down restart build logs shell env

export UID := $(shell id -u)

.PHONY: $(COMMANDS)

help:
	@for cmd in $(COMMANDS); do \
	  echo "make $$cmd"; \
	done

up:
	@$(DOCKER_COMPOSE) up --detach

down:
	@$(DOCKER_COMPOSE) down

restart:
	@$(DOCKER_COMPOSE) restart

build:
	@$(DOCKER_COMPOSE) build

logs:
	@docker logs --follow $(CONTAINER_NAME)

shell:
	@docker exec -it $(CONTAINER_NAME) /bin/sh

env:
	@docker exec -it $(CONTAINER_NAME) printenv

