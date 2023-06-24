VERSION=v1.0
API_IMG_NAME=vedic-math
UI_IMG_NAME=vedic-math-ui
API_EXPOSE_PORT=8282
UI_EXPOSE_PORT=8283
CURL_OPTIONS=-w '\n'
DOCKER_API_IMG=$(API_IMG_NAME):$(VERSION)
DOCKER_UI_IMG=$(UI_IMG_NAME):$(VERSION)

ifeq (, $(shell which podman))
	 DOCKER_CMD=docker
else
	DOCKER_CMD=podman
endif

DOCKER_CMD=docker

up:
	docker-compose -f docker-compose.yml up --force-recreate

down:
	docker-compose -f docker-compose.yml down -v

docker-build: docker-build-api docker-build-ui
docker-build-api:
	$(DOCKER_CMD) build -t $(DOCKER_API_IMG) app/ -f Dockerfile
	@echo "Docker Image Build: $(DOCKER_API_IMG)"
docker-build-ui:
	$(DOCKER_CMD) build -t $(DOCKER_UI_IMG) app-ui/  -f Dockerfile.node
	@echo "Docker Image Build: $(DOCKER_UI_IMG)"

docker-run:
	$(DOCKER_CMD) run --rm -d --name $(API_IMG_NAME) -p $(API_EXPOSE_PORT):80 $(DOCKER_API_IMG)
	$(DOCKER_CMD) run --rm -d --name $(UI_IMG_NAME) -p $(UI_EXPOSE_PORT):3000 $(DOCKER_UI_IMG)
	@echo "Running API service on port http://localhost:$(API_EXPOSE_PORT)"
	@echo "Running UI service on port http://localhost:$(UI_EXPOSE_PORT)"

docker-test:
	curl $(CURL_OPTIONS) http://localhost:$(API_EXPOSE_PORT)/
	curl $(CURL_OPTIONS) http://localhost:$(API_EXPOSE_PORT)/ping
	curl $(CURL_OPTIONS) http://localhost:$(API_EXPOSE_PORT)/version

docker-help:
	@echo "Documentation: http://localhost:$(API_EXPOSE_PORT)/docs"
	@echo "Documentation: http://localhost:$(API_EXPOSE_PORT)/redoc"

docker-stop:
	$(DOCKER_CMD) stop $(API_IMG_NAME) || True
	$(DOCKER_CMD) stop $(UI_IMG_NAME) || True

docker-restart: docker-stop docker-run

docker-bash:
	$(DOCKER_CMD) run -p $(API_EXPOSE_PORT):80 --rm -it $(DOCKER_API_IMG) /bin/bash

