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
# # Types
# ---
#
# As we stated before, `Julia` is a dynamically typed programming language. However, it's able to leverage from static typing when needed. This is specially important if we want to optimize some code.
#
# `Julia` allows type declarations, has three kind of types, and some mechanisms for types generation.

# %% [markdown]
# ## Type Declarations
# ---
#
# In `Julia` we can explicitly declare the type of any variable using the `::` operator, for example, the following variable has a `Int8` type:

# %% [code]
x::Int8 = 3;
print(x)
print(typeof(x))
 
# %% [markdown]
# When we declare a variable with an explicit type, it can not be changed:
 
# %% [code]
try
    x = 3.5;
catch err
    print(err)
end
 
# %% [markdown]
# ```{note}
# We use the `try` statement to capture the error `err` without raising it.
# ```

# %% [markdown]
# We can use any base type to define a variable, for example: `Int64`, `Int32`, `Float32`, `Float64`, `String`, `Char`, `Bool`, and others.
 
# %% [markdown]
# ## Type Kinds
# ---
#
# One of the most important features in `Julia` is that it provides flexible and robust type definition mechanisms. Specially, we can define custom types from three base types: abstract, primitive and composite.

# %% [markdown]
# ### Abstract
# ---
#
# Abstract types are defined using the `abstract` keyword. These types have the following properties:
#
# - Abstract types can not be instantiated, they are used to define a group of similar types.
# - Abstract types allow to define code that applies over a group of similar types.
# - It allows to improve the maintainability and readability of the code.
#
# For instance, the `AbstractFloat` is an abstract type which is a group that covers all float numbers regardless its numerical precision

# %% [markdown]
# ### Primitive
# ---

# %% [markdown]
# ### Composite
# ---

# %% [markdown]
# ## Type Generation
# ---

# %% [markdown]
# ### Sub-Typing
# ---
#

# %% [markdown]
# ### Unions
# ---
#

# %% [markdown]
# ### Parametric
# ---
#
