# 参考:
#  https://qiita.com/b4b4r07/items/b70178e021bef12cd4a2
#  https://github.com/b4b4r07/dotfiles

DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*) bin
EXCLUSIONS := .DS_Store .git .gitmodules
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

.DEFAULT_GOAL := help

SUBDIRS    := specific

list: ## Show dot files in this repo
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

install: ## Create symlink to home directory
	@echo 'Copyright (c) 2013-2015 BABAROT All Rights Reserved.'
	@echo '==> Start to deploy dotfiles to home directory.'
	@echo ''
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	@echo 'subdir'
	@$(foreach subdir,$(SUBDIRS),cd $(subdir) && $(MAKE) $@; cd ..;)

clean: ## Remove the dot files and this repo
	@echo 'Remove dot files in your home directory...'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
	#-rm -rf $(DOTPATH)
	@echo 'subdir'
	@$(foreach subdir,$(SUBDIRS),cd $(subdir) && $(MAKE) $@; cd ..;)

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

debug: ## Show values for debugging this Makefile
	@echo "DOTPATH = $(DOTPATH)"
	@echo "CANDIDATES = $(CANDIDATES)"
	@echo "EXCLUSIONS = $(EXCLUSIONS)"
	@echo "DOTFILES = $(DOTFILES)"
