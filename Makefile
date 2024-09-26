name = Inception
all:
	@printf "Configuring ${name}...\\n"
	@if [ ! -d "~/data/" ]; then \
		mkdir -p ~/data/; \
	fi
	@if [ ! -d "~/data/mariadb" ]; then \
		mkdir -p ~/data/mariadb; \
	fi
	@if [ ! -d "~/data/wordpress" ]; then \
		mkdir -p ~/data/wordpress; \
	fi
	@docker-compose -f ~/srcs/docker-compose.yml --env-file ~/srcs/.env up -d

build:
	@printf "Building ${name} configuration...\\n"
	@if [ ! -d "~/data/" ]; then \
		mkdir -p ~/data/; \
	fi
	@if [ ! -d "~/data/mariadb" ]; then \
		mkdir -p ~/data/mariadb; \
	fi
	@if [ ! -d "~/data/wordpress" ]; then \
		mkdir -p ~/data/wordpress; \
	fi
	@docker-compose -f ~/srcs/docker-compose.yml --env-file ~/srcs/.env up -d --build

down:
	@printf "Stopping ${name}...\\n"
	@docker-compose -f ~/srcs/docker-compose.yml --env-file ~/srcs/.env down

re: down
	@printf "Rebuilding ${name}...\\n"
	@docker-compose -f ~/srcs/docker-compose.yml --env-file ~/srcs/.env up -d --build
	@if [ ! -d "~/data/" ]; then \
		mkdir -p ~/data/; \
	fi
	@if [ ! -d "~/data/mariadb" ]; then \
		mkdir -p ~/data/mariadb; \
	fi
	@if [ ! -d "~/data/wordpress" ]; then \
		mkdir -p ~/data/wordpress; \
	fi
clean: down
	@printf "Cleaning ${name}...\\n"
	@docker system prune -a
	@sudo chmod -R 777 ~/data
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*

fclean:
	@printf "Full cleaning ${name}...\\n"
	@sudo chmod -R 777 ~/data
	@sudo rm -rf ~/data/mariadb/*
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/*
	@sudo rm -rf ~/data
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@docker volume rm $$(docker volume ls -q)

.PHONY	: all build down re clean fclean
