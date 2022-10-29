.PHONY: all
all: build

.PHONY: clean
clean:
	git clean -dfX -e !.images

.PHONY: build
build:
	./scripts/install.sh
