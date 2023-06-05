SHELL=/bin/bash
NB_PATH='./src/hpml.jl/src/'
LANG="JULIA"

all: install build-ipynb build-book

install:
	pip install .[dev]

build-ipynb:
	./src/scripts/build notebook ${NB_PATH} ${LANG}

build-book:
	jupyter-book build book/
