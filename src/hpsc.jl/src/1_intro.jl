# -*- coding: utf-8 -*-
# ---
# jupyter:
#   jupytext:
#     cell_metadata_filter: title,-all
#     formats: jl:percent,ipynb
#     text_representation:
#       extension: .jl
#       format_name: percent
#       format_version: '1.3'
#       jupytext_version: 1.14.6
#   kernelspec:
#     display_name: Julia 1.8.1
#     language: julia
#     name: julia-1.8
# ---

# %% [markdown]
# # Julia Introduction
# ---
#
# `Julia` is a programming language with the following characteristics:
#
# - **Optional typing**: (dynamic) it's not necessary to define types, but they can be defined in certain situations, although generally Julia's compiler infers them.
# - **Just-in-time (JIT) compilation**: allows functions to be compiled only when they are first called.
# - **Multiple dispatch**: allows a function to be used differently depending on the types of data used (an efficient approach to polymorphism).
# - **Scientific environment**: it is a programming language designed for high-performance scientific computing. It contains several libraries for machine learning, visualization, data handling, among others.
#
# There are several ways to run `Julia` code, let's see some of them:

# %% [markdown]
# ## Google Colab
# ---
#
# Google Colaboratory, also known as "Colab", is a cloud-based platform that provides a free environment for running `Julia` and other programming languages in Jupyter notebooks. Colab allows users to write, run and share `Julia` code in a web-based interface, making it easy to collaborate with others and work on projects from anywhere with an internet connection. The platform provides access to powerful computing resources, including GPUs and TPUs, which can be used to accelerate the execution of `Julia` code and perform complex computations. Colab also provides tools for data analysis, visualization, and collaboration, making it ideal for researchers, data analysts, and students who want to experiment with `Julia` and work on data science projects.
#
# If you want to use `Julia` inside of Colab, you can add the following code at the start of your notebook, run it and reload the page.

# %% [code]
# %%shell
set -e

---------------------------------------------------#
JULIA_VERSION="1.8.2" # any version ≥ 0.7.0
JULIA_PACKAGES="IJulia BenchmarkTools"
JULIA_PACKAGES_IF_GPU="CUDA" # or CuArrays for older Julia versions
JULIA_NUM_THREADS=2
---------------------------------------------------#

if [ -z `which julia` ]; then
  # Install Julia
  JULIA_VER=`cut -d '.' -f -2 <<< "$JULIA_VERSION"`
  echo "Installing Julia $JULIA_VERSION on the current Colab Runtime..."
  BASE_URL="https://julialang-s3.julialang.org/bin/linux/x64"
  URL="$BASE_URL/$JULIA_VER/julia-$JULIA_VERSION-linux-x86_64.tar.gz"
  wget -nv $URL -O /tmp/julia.tar.gz # -nv means "not verbose"
  tar -x -f /tmp/julia.tar.gz -C /usr/local --strip-components 1
  rm /tmp/julia.tar.gz

  # Install Packages
  nvidia-smi -L &> /dev/null && export GPU=1 || export GPU=0
  if [ $GPU -eq 1 ]; then
    JULIA_PACKAGES="$JULIA_PACKAGES $JULIA_PACKAGES_IF_GPU"
  fi
  for PKG in `echo $JULIA_PACKAGES`; do
    echo "Installing Julia package $PKG..."
    julia -e 'using Pkg; pkg"add '$PKG'; precompile;"' &> /dev/null
  done

  # Install kernel and rename it to "julia"
  echo "Installing IJulia kernel..."
  julia -e 'using IJulia; IJulia.installkernel("julia", env=Dict(
      "JULIA_NUM_THREADS"=>"'"$JULIA_NUM_THREADS"'"))'
  KERNEL_DIR=`julia -e "using IJulia; print(IJulia.kerneldir())"`
  KERNEL_NAME=`ls -d "$KERNEL_DIR"/julia*`
  mv -f $KERNEL_NAME "$KERNEL_DIR"/julia  

  echo ''
  echo "Successfully installed `julia -v`!"
  echo "Please reload this page (press Ctrl+R, ⌘+R, or the F5 key) then"
  echo "jump to the 'Checking the Installation' section."
fi 

# %% [markdown]
# ## Cocalc
# ---
#
# CoCalc (formerly SageMathCloud) is a cloud-based platform that provides a collaborative environment for scientific computing, including support for the `Julia` programming language and `Pluto` notebooks. CoCalc allows users to create, edit, and share documents and code in a web-based interface, making it easy to collaborate with others and work on projects from anywhere with an internet connection. With CoCalc, users can create and run `Julia` programs and `Pluto` notebooks without needing to install any software locally on their computer, as all computations are performed on CoCalc's servers. The platform also provides features such as version control, chat, and real-time collaboration, making it ideal for teams working on scientific computing projects. Additionally, CoCalc offers a variety of tools for data analysis, visualization, and collaboration, such as LaTeX and Jupyter notebooks, allowing users to choose the tools that best fit their workflow.

# %% [markdown]
# ## Local Instalation
# ---
#
# You can locally install `Julia` in any operating system, you can review [this page](https://julialang.org/downloads/) for additional instructions.
