.PHONY: build generate

ifndef VTENV_OPTS
VTENV_OPTS = "--no-site-packages"
endif

build:
	virtualenv $(VTENV_OPTS) .
	bin/pip install magazine

generate:
	bin/faitmain
