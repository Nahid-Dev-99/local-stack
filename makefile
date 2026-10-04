docker_compose_file=docker-compose.yml

up:
	docker-compose -f $(docker_compose_file) up -d

down:
	docker-compose -f $(docker_compose_file) down

logs:
	docker-compose logs -f