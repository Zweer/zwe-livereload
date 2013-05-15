SCRIPTS = coffee/
SCRIPTS_COMPILED = lib/

PATH := ./node_modules/.bin:$(PATH)

RED = \033[35m
GREEN = \033[32m
DEFAULT = \033[39m

# Compile scripts
build:
	@echo -e ""
	@printf "${RED}Compiling ZweLivereload...${DEFAULT}"
	@coffee --compile --output ${SCRIPTS_COMPILED} ${SCRIPTS}
	@echo -e "${GREEN}Success!${DEFAULT}\n"

# Watch less files changes
watch:
	@echo -e "Watching coffee files..."
	@coffee --watch --compile --output ${SCRIPTS_COMPILED} ${SCRIPTS}