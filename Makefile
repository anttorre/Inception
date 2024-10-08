name = Inception
all:
	@printf "Configuring ${name}...\\n"
	@if [ ! -d "$(HOME)/data/" ]; then \
		mkdir -p $(HOME)/data/; \
	fi
	@if [ ! -d "$(HOME)/data/mariadb" ]; then \
		mkdir -p $(HOME)/data/mariadb; \
	fi
	@if [ ! -d "$(HOME)/data/wordpress" ]; then \
		mkdir -p $(HOME)/data/wordpress; \
	fi
	@docker-compose -f ./srcs/docker-compose.yml --env-file $(HOME)/.env up -d

build:
	@printf "Building ${name} configuration...\\n"
	@if [ ! -d "$(HOME)/data/" ]; then \
		mkdir -p $(HOME)/data/; \
	fi
	@if [ ! -d "$(HOME)/data/mariadb" ]; then \
		mkdir -p $(HOME)/data/mariadb; \
	fi
	@if [ ! -d "$(HOME)/data/wordpress" ]; then \
		mkdir -p $(HOME)/data/wordpress; \
	fi
	@docker-compose -f ./srcs/docker-compose.yml --env-file $(HOME)/.env up -d --build

down:
	@printf "Stopping ${name}...\\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file $(HOME)/.env down

re: down
	@printf "Rebuilding ${name}...\\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file $(HOME)/.env up -d --build
	@if [ ! -d "$(HOME)/data/" ]; then \
		mkdir -p $(HOME)/data/; \
	fi
	@if [ ! -d "$(HOME)/data/mariadb" ]; then \
		mkdir -p $(HOME)/data/mariadb; \
	fi
	@if [ ! -d "$(HOME)/data/wordpress" ]; then \
		mkdir -p $(HOME)/data/wordpress; \
	fi
clean: down
	@printf "Cleaning ${name}...\\n"
	@docker system prune -a
	@sudo chmod -R 777 $(HOME)/data
	@sudo rm -rf $(HOME)/data/wordpress/*
	@sudo rm -rf $(HOME)/data/mariadb/*

fclean:
	@printf "Full cleaning ${name}...\\n"
	@sudo chmod -R 777 $(HOME)/data
	@sudo rm -rf $(HOME)/data/mariadb/*
	@sudo rm -rf $(HOME)/data/wordpress/*
	@sudo rm -rf $(HOME)/data/*
	@sudo rm -rf $(HOME)/data
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@docker volume rm $$(docker volume ls -q)

.PHONY	: all build down re clean fclean
