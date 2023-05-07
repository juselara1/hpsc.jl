SHELL=/bin/bash
NB_PATH='./src/hpml.jl/src/'

all: build-ipynb build-book

build-ipynb:
	./scripts/build notebook ${NB_PATH}

build-book:
	jupyter-book build book/
