COMPOSE_FILE := composeAnsible.yml

build:
	docker-compose -f $(COMPOSE_FILE) build

run: stop build
	docker-compose -f $(COMPOSE_FILE) up -d

stop:
	docker-compose -f $(COMPOSE_FILE) down

logs:
	docker-compose -f $(COMPOSE_FILE) logs

connect:
	docker exec -it controller su - ansible && bash
