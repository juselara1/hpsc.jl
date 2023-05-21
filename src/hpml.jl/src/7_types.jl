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
# For instance, the `AbstractFloat` is an abstract type which is a group that covers all float numbers regardless its numerical precision. We can define abstract types using the `abstract` and `type` keywords. For example, the following code defines the `Being` abstract type:

# %% [code]
abstract type Being end

# %% [markdown]
# This type defines a group of types that may operate in a similar manner. We can define sub-types using the `<:` operator. For instance, we define three subtypes:

# %% [code]
abstract type Animal <: Being end 
abstract type Plant <: Being end 
abstract type Fungus <: Being end 

# %% [markdown]
# ### Primitive
# ---
#
# Primitive types in `Julia` are the basic building blocks of data. They are concrete types whose data consists of plain bits. For example, `Int` or `Float` are primitive types.
#
# In `Julia` primitive types are useful for compilation purposes, they are used to define a low-level and efficient representation of the data. We can define primitive types through the `primitive` keyword by specifying the number of bits that the type uses, for example:

# %% [code]
primitive type Animal8 <: Animal 8 end

# %% [markdown]
# In practice, it's better to use existing types instead of new primitive types.

# %% [markdown]
# ### Composite
# ---
#
# Composite types in `Julia` are collections of named fields, an instance of which can be treated as a single value. Their main goal is to collect all information about one object within one structure. Let's see an example of the composite `CartesianPoint64` type that defines the `x` and `y` elements.

# %% [code]
struct CartesianPoint64
    x::Float64
    y::Float64
end

# %% [markdown]
# We can create a variable using this composite type:

# %% [code]
p = CartesianPoint64(1, 2);
print(p)

# %% [markdown]
# We can also access the fields of the composite data using the dot notation:

# %% [code]
print(p.x)

# %% [markdown]
# By default composite types are immutable, therefore, we can't re-define its values:

# %% [code]
try
    p.x = 3
catch err
    print(err)
end
 
# %% [markdown]
# However, we can define mutable types using the `mutable` keyword as follows:
 
# %% [code]
mutable struct MutCartesianPoint64
    x::Float64
    y::Float64
end
 
# %% [markdown]
# Let's define a new point:
 
# %% [code]
p = MutCartesianPoint64(1, 2)
p.x = 3
print(p)
 
# %% [markdown]
# ## Type Generation
# ---
#
# Based on abstract, primitive and composite types, it's possible to define more flexible types using different mechanisms like sub-typing, union types and parametric types.

# %% [markdown]
# ### Sub-Typing
# ---
#
#

# %% [markdown]
# ### Unions
# ---
#

# %% [markdown]
# ### Parametric
# ---
#
