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
# ---

# %% [markdown]
# # String Operators
# ---
#
# There are different operators that work on string variables. This includes: indexing, concatenation, interpolation, and comparison.

# %% [markdown]
# ## Indexing
# ---
#
# Indexing refers to accessing a specific character or sequence in a string using its position or index. In `Julia`, the indexing operation can be performed using square brackets `[]` immediately after the string. The first character in a string has an index of 1, while the last character has an index equal to the length of the string.
#
# Let's see an example of indexing the first character of a string:

# %% [code]
x = "hello world";
print(x[1])

# %% [markdown]
# Likewise, it's possible to index the `begin` or the `end` of a string:

# %% [code]

# %% [code]

# %% [code]
print(x[begin]) 

# %% [code]
print(x[end]) 

# %% [markdown]
# The `begin` and `end` instructions can be also combined with arithmetic operations to index other values, for instance, the following code indexes the third element of a string:

# %% [code]
print(x[begin + 3]) 

# %% [markdown]
# Similarly, the following code extracts the penultimate character of the string:

# %% [code]
print(x[end - 1]) 

# %% [markdown]
# We can also define index ranges through the range operator `:`:

# %% [code]
y = 2:5; 
print(y)
print(typeof(y))

# %% [markdown]
# A range can be used to select sub-strings:

# %% [code]
print(x[2:5])

# %% [markdown]
# Ranges can be also defined using steps, for instance, we can define a range between 3 and 7 using steps of 2:

# %% [code]
y = 3:2:7; 
print(y)
print(typeof(y))

# %% [markdown]
# This is useful when indexing a string:

# %% [code]
print(x[3:2:7])

# %% [markdown]
# ## Concatenation
# ---
#
# In `Julia` we can concatenate strings using the `*` operator. Let's see an example

# %% [code]
x = "hello ";
y = "world";
print(x * y)

# %% [markdown]
# It's possible to use `*=` as a concatenation and updating operator:

# %% [code]
x = "hello" ;
x *= " world";
print(x)

# %% [markdown]
# ## Interpolation
# ---
#
# String interpolation allows to embed variables or expressions directly within a string. In `Julia` this can be achieved on non-raw strings using the `$` pattern. For example, the following code replaces the content of the `x` variable within a string:

# %% [code]
x = "hello";
print("$x world")

# %% [markdown]
# We can interpolate variables of different types, for instance:

# %% [code]
x = 4;
print("I've $x friends")

# %% [markdown]
# It's possible to evaluate expressions and interpolate the result if we use the `$()` pattern:

# %% [code]
x = 2; 
print("We went to $(x * 2) places")

# %% [markdown]
# ## Comparison 
# ---
#
# We can use comparison operators like `==`, `>`, `<`, `<=`, `>=`, `!=` to compare two strings, for example, the following cell determines if two strings are equal:

# %% [code]
x = "hello" == "hello";
print(x)

# %% [code]
x = "hello" == "Hello";
print(x)

# %% [markdown]
# `Julia` allows a lexicographical comparison of strings, for example:

# %% [code]
x = "abc" < "abd"; 
print(x)

# %% [markdown]
# This is valid since `d` is lexicographically higher than `c`. 
