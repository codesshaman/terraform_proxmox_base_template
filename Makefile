name = Terraform

# Color variables

VAR :=				# Cmd arg var
NO_COLOR=\033[0m	# Color Reset
OK=\033[32;01m		# Green Ok
ERROR=\033[31;01m	# Error red
WARN=\033[33;01m	# Warning yellow


git:
	@printf "$(YELLOW)==== Set user name and email to git for ${name} repo... ====$(NO_COLOR)\n"
	@bash ../../scripts/gituser.sh

env:
	@printf "$(ERROR)==== Create environment file for ${name}... ====$(NO_COLOR)\n"
	@if [ -f .env ]; then \
		echo "$(ERROR).env file already exists!$(NO_COLOR)"; \
	else \
		cp .env.example .env; \
		echo "$(GREEN).env file successfully created!$(NO_COLOR)"; \
	fi

help:
	@echo -e "$(OK)==== Manual for ${name} configuration ===="
	@echo -e "$(WARN)- make git			: Set git user"
	@echo -e "$(WARN)- make env			: Create .env file"
	@echo -e "$(WARN)- make push			: Push last changes to git"
	@echo -e "$(WARN)- make provider			: Install provider"
	@echo -e "$(WARN)- make wget			: Download provider"
	@echo -e "$(WARN)- make zip			: Unpack provider"$(NO_COLOR)"

provider:
	@if [ ! -f "$(PROVIDER_FILE)" ]; then \
		echo "File $(PROVIDER_FILE) not found!"; \
		exit 1; \
	fi
	@if [ ! -d "$(PLUGIN_DIR)" ]; then \
		mkdir -p "$(PLUGIN_DIR)"; \
	fi
	@mv "$(PROVIDER_FILE)" "$(PLUGIN_DIR)"
	@chmod +x "$(PLUGIN_DIR)/$(PROVIDER_FILE)"
	@rm $(PROVIDER_ARCHIVE)
	@echo "Provider was been successfully Install to $(PLUGIN_DIR)"


push:
	@bash scripts/push.sh

wget:
	@wget "$(DOWNLOAD_URL)"
	@if [ $$? -ne 0 ]; then \
		rm -f "$(PROVIDER_FILE)"; \
		exit 1; \
	fi

zip:
	@unzip -n -q ${PROVIDER_ARCHIVE}
