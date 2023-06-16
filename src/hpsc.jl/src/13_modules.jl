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
# # Modules
# ---
#
# In `Julia` we can use modules to manage different namespaces (each one has its scope). Likewise, modules are useful to create libraries and can be imported to reuse existing code.

# %% [markdown]
# ## Creation
# ---
# Let's see an example of the creation of a module:

# %% [code]
module MyModule

function hello()
    println("hello world")
end

end;

# %% [markdown]
# We can create modules in other files:
#
# ```{note}
# We use `open` and `close` functions to create a file in write `"w"` mode.
# ```

# %% [code]
f = open("file.jl", "w");
text = """
module OtherModule

function average(args...)
    return sum(args) / length(args)
end

end
"""
print(f, text)
close(f)

# %% [markdown]
# We can use the modules in this file with the `include` function:

# %% [code]
include("file.jl")

# %% [markdown]
# Now, we can use the module contained in that file:

# %% [code]
println(OtherModule.average(1, 2, 3))

# %% [markdown]
# ## Usage
# ---
#
# We can use modules in two ways. First, the `using` keyword imports a module:
#
# ```{note}
# We use a dot before the module name, because we define the module in the current scope.
# ```

# %% [code]
using .MyModule

# %% [markdown]
# We can use functions that are defined in a module through the dot notation:

# %% [code]
MyModule.hello();

# %% [markdown]
# Similarly, the `import` keyword allows to collect a given element from a module:

# %% [code]
import .MyModule.hello
hello();

# %% [markdown]
# We can import multiple elements at the same time using a comma separator. For example, we define a module with three functions:

# %% [code]
module ThreeModule

f(x::Number, y::Number) = (x ^ 2 + y ^ 2) ^ 0.5 ;

g(x::Number, y::Number) = x + y;

h(x::Number, y::Number) = (y > 0) ? y : x;

end

# %% [markdown]
# We can include only `f` and `g` with the following code:

# %% [code]
using .ThreeModule: f, g

# %% [markdown]
# We won't have imported the `h` function. This is also possible with `import`:

# %% [code]
import .ThreeModule: f, g

# %% [markdown]
# Finally, we can rename elements while importing to avoid conflicts:

# %% [code]
import .ThreeModule: f as my_fun

# %% [markdown]
# ## Packages
# ---
#
# `Julia` includes a flexible package manager that allows to dependency management, i.e., we can create, download, update and delete libraries.
#
# Currently, the default package manager in `Julia` is `Pkg`, let's import this:

# %% [code]
using Pkg 

# %% [markdown]
# Let's initialize the project:

# %% [code]
Pkg.generate("test");

# %% [markdown]
# It'll create the following structure:
#
# ```sh
# test
# ├── Project.toml
# └── src
#     └── test.jl
# ```
#
# The `Project.toml` is a file that saves general project metadata and its dependencies. And the `test.jl` file is the main entrypoint for our package.
#
# We can activate this project:

# %% [code]
Pkg.activate("test")

# %% [markdown]
# Now, we can import our module:

# %% [code]
using test

# %% [markdown]
# In this project, we can download a package using the `add` function, for example, we can download the `DataFrames.jl` library (we'll talk about this library later).

# %% [code]
Pkg.add("DataFrames")

# %% [markdown]
# This will authomatically download the package and its dependencies. We can import this package:

# %% [code]
using DataFrames 

# %% [markdown]
# We can update a package using `Pkg.update`:

# %% [code]
Pkg.update("DataFrames") 

# %% [markdown]
# We can remove a package with `Pkg.rm`:

# %% [code]
Pkg.rm("DataFrames")
