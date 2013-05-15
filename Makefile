.PHONY: build generate dev

config = kompost.ini
CURDIR := $(shell pwd)

ifndef VTENV_OPTS
VTENV_OPTS = "--no-site-packages"
endif

build:
	virtualenv $(VTENV_OPTS) .
	bin/pip install https://github.com/faitmain/kompost/archive/master.zip

generate:
	bin/kompost $(config)

dev:
	bin/kompost kompost-dev.ini
