SHELL=/bin/bash
NB_PATH='./src/hpml.jl/src/'
LANG="JULIA"

all: build-ipynb build-book

build-ipynb:
	./src/scripts/build notebook ${NB_PATH} ${LANG}

build-book:
	jupyter-book build book/
