# ---
# jupyter:
#   jupytext:
#     cell_metadata_filter: title,-all
#     formats: jl:percent,ipynb
#     text_representation:
#       extension: .jl
#       format_name: percent
#       format_version: '1.3'
#       jupytext_version: 1.14.5
# ---

# %% [markdown]
# # Variables
# ---
#
# In `Julia` we can define variables that may contain data of different types. Let's see an example of how we can define a variable:

# %% [code]
x = 1 
print(x)

# %% [markdown]
# In this case a variable `x` is created with a value of `1`, we use the `print` function to place the variable content inside the standard output.
#
# Since `Julia` is a dynamically typed language, it's possible to assign any other value to the `x` variable independent of the value's type:

# %% [code]
x = "hello" 
print(x)

# %% [markdown]
# By default, the assignment operation returns the assigned value. That's why you'll see the value as an output when you run the command:
#
# ```julia
# julia> x = "hello"
# "hello"
# ```
#
# This allows multiple variable assiginments by chaining the assignment `=` operator:

# %% [code]
x = y = z = 1 
print(x)
print(y)
print(z)

# %% [markdown]
# Likewise, if you don't want to display the assigned value, you can add the `;` symbol at the end of the line:

# %% [code]
x = "hello"; 

# %% [markdown]
# Let's see the different kind of variables and types that we can use in `Julia`.

# %% [markdown]
# `Julia` allows to define different variables depending on its purpose.
#
# - `const`: this tells the `Julia` compiler that a variable won't be changed. Although `Julia` allows to reasign the variable, it has several performance advantages when `Julia` compiles with `const` variables.

# %% [code]
const const_var = 1;
print(const_var)

# %% [markdown]
# The redefinition of a `const` variable will throw a warning:

# %% [code]
const_var = 2; 
print(const_var)

# %% [markdown]
# - `global`: this defines a variable that may be used in any scope, i.e., it's a variable that is shared in all the execution.

# %% [code]
global x = 2; 
print(x)

# %% [markdown]
# ```{note}
# The use of `global` variables is not adviced, although there are some specific use cases (e.g., global configurations, singletons, among others), in most of the cases it's better to use local variables shared between the different parts of the program.
# ```

# %% [markdown]
# - `local`: this defines a variable that can be used only inside of its scope, this is specially important to ensure the safety of a variable.

# %% [code]
local y = 2;

# %% [markdown]
# ```{note}
# The use of `local` variables is mandatory to avoid conflicts with `global` variables when they exist. This is specially important when dealing with variables within functions' `scopes` as we'll see later.
# ```
#
# Additionally, `local` variables are automatically created inside an `scope`. You can use the `let` keyword to create variables within a `scope` as follows:

# %% [code]
x = 2;
let x = 3
    print(x)
end
print(x)

# %% [markdown]
# As you can see, `x` takes a different value inside the `scope` that is defined between the `let` and `end` statements.
