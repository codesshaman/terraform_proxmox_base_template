name = OpenTofu Docker Registr y

VAR :=				# Cmd arg var
NO_COLOR=\033[0m	# Color Reset
OK=\033[32;01m		# Green Ok
ERROR=\033[31;01m	# Error red
WARN=\033[33;01m	# Warning yellow

all:
	@printf "$(OK)- Full clean of all images and archives\n"
	@tofu apply -auto-approve

env:
	@printf "$(ERROR_COLOR)==== Create environment file for ${name}... ====$(NO_COLOR)\n"
	@if [ -f .env ]; then \
		echo "$(ERROR_COLOR).env file already exists!$(NO_COLOR)"; \
	else \
		cp .env.example .env; \
		echo "$(GREEN).env file successfully created!$(NO_COLOR)"; \
	fi

git:
	@printf "$(YELLOW)==== Set user name and email to git for ${name} repo... ====$(NO_COLOR)\n"
	@bash scripts/gituser.sh

help:
	@echo -e "$(OK)==== Все команды для конфигурации ${name} ===="
	@echo -e "$(WARN)- make				: Launch configuration"
	@echo -e "$(WARN)- make init			: Init configuration"
	@echo -e "$(WARN)- make git			: Set git user"
	@echo -e "$(WARN)- make plan			: Show intallation plan"
	@echo -e "$(WARN)- make push			: Push last changes to git"
	@echo -e "$(WARN)- make unpack			: Unpack image"
	@echo -e "$(WARN)- make vars			: get variables from .env"
	@echo -e "$(WARN)- make wget			: Download image"
	@echo -e "$(WARN)- make clean			: Clean all images"
	@echo -e "$(WARN)- make fclean			: Full clean of all images and archives$(NO_COLOR)"

init:
	@tofu init

plan:
	@tofu plan

push:
	@bash scripts/push.sh

vars:
	@set -a && . ./.env && envsubst < terraform.tfvars.template > terraform.tfvars

unpack:
	@mkdir -p ubuntu
	@tar xf ./vagrant.box -C ubuntu

wget:
	@printf "$(OK)- Download vagrantbox\n"
	@wget https://vagrantcloud.com/ubuntu/boxes/focal64/versions/20240821.0.1/providers/virtualbox/unknown/vagrant.box

.PHONY	: all help push clean fclean
