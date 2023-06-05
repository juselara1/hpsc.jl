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
# # Functions
# ---
#
# Functions are one of the key concepts in `Julia` that allow to optimize, organize and reuse most of the code. Some of the benefits of using functions include:
#
# - Modular and reusable code.
# - Higher readability and maintainability of the code.
# - JIT compilation, i.e., functions are compiled the first time they're called which generally makes them faster.
# - Easier debugging.
#
# The components of a function are:
#
# - **Name**: name of the function.
# - **Parameters**: variables that are used in the function.
# - **Arguments**: values assigned to the parameters when the function is called.
# - **Body**: code that is executed when the function is called.
# - **Return value**: result of the function execution.

# %% [markdown]
# ## Function Definition
# ---
#
# Let's see an example of the `Julia` implementation of the following function $f$:
#
# $$
# f: x \rightarrow x ^ 2
# $$

# %% [code]
function f(x)
    x ^ 2
end;

# %% [markdown]
# ```{note}
# The `return` statement is optional, `Julia` will return the last value thrown into standard output
# ```

# %% [code]
print(f(3))

# %% [markdown]
# In this case, we create a function named `f`, that has the `x` parameter, returns the square of `x`, and then is called using `3` as argument.
#
# We can also define one-line functions using the following syntax:

# %% [code]
f(x) = x ^ 3;
print(f(3))

# %% [markdown]
# In `Julia` operators are just functions that are defined using a custom mathematical symbol. However, we can still use them as functions. For example the `+` can be used as a function that sums all its arguments:

# %% [code]
res = +(1, 2, 3, 4);
print(res)

# %% [markdown]
# It's possible to define anonymous or lambda functions using the arrow notation, for example the following code defines a function that computes the square root of a number and is immediately called to compute the result:

# %% [code]
res = (x -> x ^ 0.5)(2);
print(res)

# %% [markdown]
# In `Julia` we have two types of function's parameters:
# - **Positional**: arguments are passed in order when the function is called.
# - **Keyword**: the parameter name is specified when passing the argument.
#
# By default, a function in `Julia` uses positional arguments, however, we can use the `;` symbol to define the keyword arguments at the end of the function definition. For example:

# %% [code]
function f(x, y; z=0)
    return x + y - z
end;

# %% [markdown]
# In this case `z` is a keyword argument which is also optional (defaults to 0). Let's see how we can use this function:

# %% [code]
print(f(1, 2))
print(f(1, 2, z=3))

# %% [markdown]
# As you can see, the `z` parameter must be referenced when passing a keyword argument.

# %% [markdown]
# ## Higher-Order Functions
# ---
#
# In `Julia` functions can be treated as data and assigned to variables, this allows partial functions, function composition, lazy evaluation, among other features.
#
# For instance, let us define a function that computes the following mathematical operation:
#
# $$
# g: x, y, z \rightarrow \sqrt{x ^ 2 + y ^ 2 + z ^ 2}
# $$
#
# This function can be defined as:

# %% [code]
function g(x, y, z)
    (x ^ 2 + y ^ 2 + z ^ 2) ^ 0.5
end;

# %% [markdown]
# If we want to define the following function:
#
# $$
# h: x, y \rightarrow g(x, y, 1)
# $$
#
# We can do it using a higher-order function that defines a partial function `h`:

# %% [code]
h(x, y) = g(x, y, 1);
print(h)

# %% [markdown]
# We can evaluate this function for some values:

# %% [code]
res = h(1.2, 3.4);
print(res)

# %% [markdown]
# Similarly, higher-order functions allow the creation of closures (functions that return functions but manage scopes).
#
# For instance, the following function saves an internal status and returns a function that prints the status and increments it when it's called:

# %% [code]
function iownstatus()
    status = 0;
    function get_status()
        status += 1;
        return status
    end
    return get_status 
end

# %% [markdown]
# Let's see an example:

# %% [code]
f_state = iownstatus();
print(f_state())
print(f_state())
print(f_state())

# %% [markdown]
# With higher-order functions we can perform function composition, let's see the following example:
#
# $$
# f: x \rightarrow x ^ 2\\
# g: x \rightarrow x / 3\\
# h: x \rightarrow x - 1
# $$
#
# In function composition we would like to define a new function $z$ such that:
#
# $$
# z = h \circ g \circ h\\
# z: x \rightarrow (h \circ g \circ h)(x)
# $$
#
# First, we can define the individual functions:

# %% [code]
f(x) = x ^ 2; 
g(x) = x / 3;
h(x) = x - 1;

# %% [markdown]
# Now, the composed function:

# %% [code]
z(x) = h(g(f(x)));

# %% [code]
print(z(2.5))

# %% [markdown]
# However, there's an alternative way to do function composition through the pipe `|>` operator:

# %% [code]
res = 2.5 |> f |> g |> h;
print(res)

# %% [markdown]
# Or as a function:

# %% [code]
z(x) = x |> f |> g |> h;

# %% [code]
print(z(2.5))

# %% [markdown]
# ## Recursion
# ---
#
# Recursion can be seen as a function that calls itself. This is useful for the definition of functions that depend on its previous calls, for example a Fibonacci number can be defined as:
#
# $$
# f: n \rightarrow f(n - 1) + f(n - 2)
# $$
#
# Let's see this implementation

# %% [code]
function fib(n)
    (n == 0 || n == 1) && return 1
    return fib(n - 1) + fib(n - 2)
end;

# %% [markdown]
# ```{note}
# We use logical operators to condition when the function must return 1.
# ```

# %% [markdown]
# We can use this function: 

# %% [code]
print(fib(1))
print(fib(4))
print(fib(5))

# %% [markdown]
# ## Multiple Dispatch
# ---
#
# Multiple dispatch is a feature of `Julia` that allows a function to be called with different types of arguments and have different implementations for each type. This is in contrast to single dispatch, where a function has a single implementation that is used for all types of arguments.
#
# Let's see an example of multiple dispatch for the computation of norms. We'll compute the $L_1$ norm if the parameters are integers and $L_2$ norm if the parameters are floats.
#
# First, we define the integer case:
#
# ```{note}
# `abs` is a function that computes the absolute value of any number.
# ```

# %% [code]
function norm(x::Integer, y::Integer)::Integer
    return abs(x) + abs(y)
end;

# %% [markdown]
# Now, the float case:

# %% [code]
function norm(x::AbstractFloat, y::AbstractFloat)::AbstractFloat
    return (x ^ 2 + y ^ 2) ^ 0.5
end;

# %% [markdown]
# Let's see what happens when we use the function:

# %% [code]
print(norm(1, 2))

# %% [code]
print(norm(1.0, 2.0))

# %% [markdown]
# As you can see, the function returns different results depending on the input types. We can combine this with custom types to represent complex behaviors.
#
# In the following example we define the abstract type `AbstractShape` which defines any geometrical figure:

# %% [code]
abstract type AbstractShape end

# %% [markdown]
# Now, we define the `Circle` and `Rectangle` sub-types:

# %% [code]
struct Circle{T} <: AbstractShape
    radius::T
end

struct Rectangle{T} <: AbstractShape
    width::T
    height::T
end

# %% [markdown]
# Finally, we define a function to compute the area of every shape:

# %% [code]
function area(shape::Circle)
    pi * shape.radius ^ 2
end;

function area(shape::Rectangle)
    return shape.width * shape.height
end;

# %% [markdown]
#

# %% [markdown]
# Let's see the computation of the area for different shapes:

# %% [code]
c = Circle{Float64}(1.0);
r = Rectangle{Float64}(2.0, 1.0);

# %% [markdown]
# The area of a circle of radius `1.0` is:

# %% [code]
print(area(c))

# %% [markdown]
# The area of a rectangle of width 2 and height 1 is:

# %% [code]
print(area(r))

# %% [markdown]
# Additionally, it's possible to define functions with parametric types, for instance, the following function defines a product between three numerical values:

# %% [code]
function product(x::T, y::T, z::T)::T where {T <: Number}
    return x * y * z
end

# %% [markdown]
# We can see how this function works:

# %% [code]
print(product(1, 2, 3))

# %% [markdown]
# However, if we have any argument of a different type the code will generate an error:

# %% [code]
try
    print(product(0x01, 2, 3))
catch err
    print(err)
end

# %% [markdown]
# ## Constructors
# ---
#
# Constructors are special functions used in the creation of certain types. For example, we can define the following type for any positive number. However, any number will be saved as its absolute value.

# %% [code]
struct PositiveNumber
    value::Number
    PositiveNumber(value::Number) = new(abs(value))
end

# %% [markdown]
# Let us define a positive number:

# %% [code]
num = PositiveNumber(-2);
print(num)

# %% [code]
num = PositiveNumber(-3.5);
print(num)

# %% [markdown]
# It's also possible to have constructors outside of the type definition, first we define the type:

# %% [code]
struct IdentityPoint
    x::Number
    y::Number
end

# %% [markdown]
# Now we define the constructor for a single value:

# %% [code]
IdentityPoint(x::Number) = IdentityPoint(x, x)

# %% [markdown]
# Let's see how this works:

# %% [code]
p = IdentityPoint(2);
print(p)
