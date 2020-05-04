
# Detect platform type
UNAME_S:= $(shell uname -s)
UNAME_N:= $(shell uname -n)
PFTYPE:=
ifeq ($(UNAME_S),Linux)
	ifeq ($(UNAME_N),raspberrypi)
		PFTYPE := raspi4
	endif
endif
ifeq ($(UNAME_S),Darwin)
	PFTYPE := osx
endif

CURPATH       := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

.DEFAULT_GOAL := help

all:

install: ## Create symlink to home directory
	@echo 'Start to deploy specific dir to home directory.'
	@echo ''
	@ln -sfnv $(abspath $(CURPATH))/$(PFTYPE) $(HOME)/specific

clean: ## Remove the specific dir
	@echo 'Remove specific dir in your home directory...'
	@-rm -vrf $(HOME)/specific

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

debug: ## Show values for debugging this Makefile
	@echo "PFTYPE = $(PFTYPE)"
	@echo "CURPATH = $(CURPATH)"
	@echo "MAKEFILE_LIST = $(MAKEFILE_LIST)"
	@echo $(abspath $(CURPATH))/$(PFTYPE) $(HOME)/specific
