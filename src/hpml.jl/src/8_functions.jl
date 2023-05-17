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
# # Functions
# ---
#
# Functions are one of the key concepts in `Julia` that allow to optimize, organize and reuse most of the code. Some of the benefits of using functions include:
#
# - Modular and reusable code.
# - Higher readability and maintainability of the code.
# - JIT compilation.
# - Easier debugging.
#
# The components of a function are:
#
# - **Name**: name of the function.
# - **Parameters**: variables that are used in the function.
# - **Arguments**: values assigned to the parameters when the function is called.
# - **Body**: code that is executed when the function is called.
# - **Return value**: result of the function execution.
#
# Let's see an example of the `Julia` implementation of the following function:
#
# $$
# f: x \rightarrow x ^ 2
# $$

# %% [markdown]
 
# %% [code]
function f(x)
    x ^ 2
end;

# %% [code]
f(3)

# %% [markdown]
# In this case, we create a function named `f`, that has the `x` parameter, returns the square of `x`, and then is called using `3` as argument.

# %% [markdown]
# ## Anonymous Functions
# ---

# %% [markdown]
# ## Higher-Order Functions
# ---

# %% [markdown]
# ## Composition
# ---

# %% [markdown]
# ## Just-in-Time Compilation
# ---

# %% [markdown]
# ## Multiple Dispatch
# ---
