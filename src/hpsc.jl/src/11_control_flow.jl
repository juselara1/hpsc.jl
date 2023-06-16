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
# # Control Flow
# ---
#
# Control flow is the order in which individual statements, instructions, or function calls of a program are executed or evaluated. A control flow statement is a statement that results in a choice being made as to which of two or more paths to follow, or repetitions to perform.
#
# We'll see how we can perform this through conditionals and loops.

# %% [markdown]
# ## Conditionals
# ---
#
# In `Julia` a conditional uses `Bool` variables to deterimne which code must be executed. Let's see the following example of the ternary operator `?`, first we define a variable `x`:

# %% [code]
x = 3;
print(x)

# %% [markdown]
# We can validate if this variable is higher than 5:

# %% [code]
y =  x > 5;
print(y)

# %% [markdown]
# Now, with the ternary operator we can do a conditional assignment:

# %% [code]
z = y ? "x is higher or equal than 5" : "x is lower than 5";
print(z)

# %% [markdown]
# The syntax of the ternary operation is the following:
#
# ```julia
# bool ? condition_false : condition true
# ```
#
# However, the ternary operator can be only used when we want to assign a value, if we want to perform more operations for each case, we can use the `if` statement.
#
# For example, we want to implement the following condition.
#
# - If `x` is less than 5, then, divide `x` by 2 and print `"lower"`.
#
# We can do:

# %% [code]
x = 2;
if x < 5
    x *= 2;
    print("lower")
end
print(x)

# %% [markdown]
# Let's see the same example when `x` has a higher value:

# %% [code]
x = 7;
if x < 5
    x *= 2;
    print("lower")
end
print(x)

# %% [markdown]
# We can use an `if-else` statement to execute different code for a given condition, for example, we can implement the following:
#
# - If `x` is equal to `"password"`, then print `"Login successful"`.
# - Otherwise print `"access denied"`.
#
# Let's see how to do this in `Julia`:

# %% [code]
x = "test"
if x == "password"
    print("Login successful")
else
    print("Access denied")
end

# %% [markdown]
# Finally, we can evaluate multiple conditions by adding `elseif` statements.
#
# Let's see the following example:

# %% [code]
x, y = 3, 4;
if x > y
    print("x is higher than y")
elseif x < y
    print("x is lower than y")
else
    print("x and y are equal")
end

# %% [markdown]
# We can use multiple `elseif` to validate several conditions.

# %% [code]
x = 3;
if x == 0
    print("x is cero")
elseif x == 1
    print("x is one")
elseif x < 0
    print("x is negative")
else
    print("x is higher than 1")
end

# %% [markdown]
# ## Loops 
# ---
#
# Loops allow a controlled way to repeat some code. In `Julia` we can use loops through the `for` and `while` stetement or with an `iterator` 

# %% [markdown]
# ### For
# ---
#
# The `for` statement allows to sequentially extract values from any iterable data structure.
#
# Let's see an example with the following `Vector`:

# %% [code]
x = [3, 2, 1, 3, 2, 1, 3, 2, 1];

# %% [markdown]
# Now, we can iterate over a range between 1 and the number of elements:

# %% [code]
for i in 1:length(x)
    println("Element $i")
end

# %% [markdown]
# We can also index the `Vector` and print its value:

# %% [code]
for i in 1:length(x)
    println("Index $i\tValue $(x[i])")
end

# %% [markdown]
# We can directly iterate over the `Vector` to extract its values:

# %% [code]
for x_i in x
    println("Element $x_i")
end

# %% [markdown]
# Likewise, we can use the `enumerate` function to iterate over the index and the values:

# %% [code]
for (i, x_i) in enumerate(x)
    println("Index $i\tValue $(x[i])")
end

# %% [markdown]
# We can use `for` loops for comprehension, it is a syntactic construct for creating a `Vector` based on existing iterables. Comprehensions are often used to create vectors that are the result of some operation applied to all or some elements of another iterable.
#
# Let's see an example:

# %% [code]
x = [i ^ 2 for i in 1:10];
print(x)

# %% [markdown]
# ### While
# ---
#
# A while loop in Julia is a control flow statement that allows you to execute a block of code repeatedly as long as a specified condition is met.
#
# Let's see an example with the Collatz conjecture, it states that for any arbitrary positive integer:
#
# - If the number is even, divide it by two.
# - Otherwise, triple it and add one.
#
# The conjecture states _this process will eventualy reach the number 1, regardless of which positive integer is chosen initially_.
#
# Let's see an example with the number 10:

# %% [code]
x = 10;
while x != 1
    x = Bool(x % 2) ? x * 3 + 1 : div(x, 2);
    println(x)
end

# %% [markdown]
# The code is iteratively called while `x` is different from 1.

# %% [markdown]
# ### Iterator
# ---
#
# We can define how we want to iterate over custom data types, let's see an example with the following composed type:

# %% [code]
struct Values
    pos::Int16
    neg::Int16
end

# %% [markdown]
# We have to use **multiple dispatch** to define how we'll iterate over this new type. This is achieved through the definition of the `iterate` function with the following conditions:
#
# 1. It must have a default stateless implementation, that returns the next value and the state.
# 2. We must define a general function for an input value and state that returns the next value and state.
# 3. The function must return `nothing` when the iteration must be stopped.
#
# Let's see an example of an iterator that increments the `pos` field and decrements the `neg` field on each iteration.

# %% [code]
Base.iterate(v::Values) = return (Values(v.pos + 1, v.neg - 1), 1);
function Base.iterate(v::Values, state::Integer)
    if state < 10
        return (Values(v.pos + 1, v.neg - 1), state + 1)
    else
        return nothing
    end
end

# %% [markdown]
# Let us define an initial value:

# %% [code]
v = Values(3, -1);
state = 0;

# %% [markdown]
# Now, we can iterate it:

# %% [code]
next = iterate(v);
while next !== nothing
    v, state = next;
    next = iterate(v, state);
    println(v)
    println(state)
end

# %% [markdown]
# We can use `iterate` with existing data structures:

# %% [code]
x = [4, 3, 2, 1, 4, 3, 2, 1]; 
next = iterate(x);
while next !== nothing
    val, state = next;
    next = iterate(x, state);
    println(val)
end
