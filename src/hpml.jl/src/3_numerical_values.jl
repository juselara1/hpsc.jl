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
# # Numerical Values
#
# ---
# There are different numerical values that can be defined in `Julia`, including integers, floats, complexes, rationals, and Booleans.

# %% [markdown]
# ## Integer
# ---
#
# In `Julia`, an integer is a data type that represents a whole number without a fractional component. Integers in `Julia` can be signed or unsigned and have a numerical precision.
#
# `Julia` supports the following integer types:
#
# - `Int8`: an 8-bit signed integer (-128 to 127)
# - `UInt8`: an 8-bit unsigned integer (0 to 255)
# - `Int16`: a 16-bit signed integer (-32768 to 32767)
# - `UInt16`: a 16-bit unsigned integer (0 to 65535)
# - `Int32`: a 32-bit signed integer (-2^31 to 2^31-1)
# - `UInt32`: a 32-bit unsigned integer (0 to 2^32-1)
# - `Int64`: a 64-bit signed integer (-2^63 to 2^63-1)
# - `UInt64`: a 64-bit unsigned integer (0 to 2^64-1)
# - `Int128`: a 128-bit signed integer (-2^127 to 2^127-1)
# - `UInt128`: a 128-bit unsigned integer (0 to 2^128-1)
#
# By default, `Julia` uses the `Int` type, which is either a 32-bit or 64-bit signed integer depending on the platform. You can check the type of an integer in `Julia` using the `typeof` function, like this:

# %% [code]
x = 42;
print(typeof(x))

# %% [markdown]
# You can create an integer in `Julia` by simply writing its value without any fractional component. You can also create an integer by specifying its type explicitly, as shown below:

# %% [code]
x = Int32(42);
print(typeof(x))

# %% [code]
y = UInt8(255);
print(typeof(y))

# %% [markdown]
# ## Float
# ---
#
# In `Julia`, a floating-point value is a data type that represents a number with a fractional component. Floats are used to represent real numbers, which can have decimal places. `Julia` supports several floating-point types, which differ in their precision (number of bits used to represent the number) and range (largest and smallest values that can be represented):
#
# - `Float16`: also known as half-precision, uses 16 bits to represent a number, with 1 sign bit, 5 exponent bits, and 10 significand bits. This type has a range of approximately 6.10^-5 to 6.55 x 10^4 and a precision of about 3 decimal places.
# - `Float32`: also known as single-precision, uses 32 bits to represent a number, with 1 sign bit, 8 exponent bits, and 23 significand bits. This type has a range of approximately 1.18 x 10^-38 to 3.4 x 10^38 and a precision of about 7 decimal places.
# - `Float64`: also known as double-precision, uses 64 bits to represent a number, with 1 sign bit, 11 exponent bits, and 52 significand bits. This type has a range of approximately 2.23 x 10^-308 to 1.80 x 10^308 and a precision of about 16 decimal places.
#
# You can create a float value in `Julia` by writing its value with a decimal point, like this:

# %% [code]
x = 3.14;
print(typeof(x))

# %% [code]
y = 1.23f0;
print(typeof(y))

# %% [markdown]
# When working with float values in `Julia`, it is important to keep in mind that they are not exact, and that operations involving floats may introduce rounding errors or other inaccuracies.

# %% [markdown]
# ## Complex
# ---
#
# In `Julia`, complex numbers are a composition of two numbers (integer or float). These numbers can be defined using the `im` keyword:

# %% [code]
x = 3im;
print(typeof(x))

# %% [markdown]
# Complex numbers of any numerical precision can be defined in Julia. For example:
# %% [code]
x = Float64(3.0)im;
print(typeof(x))

# %% [code]
x = complex(1, 2);
print(x)

# %% [markdown]
# ## Rational
# ---
#
# In `Julia`, rational numbers are represented using the `Rational` type. A rational number is a number that can be expressed as the ratio of two integers, in the form `p // q`, where `p` and `q` are integers and `q` is not zero.
#
# You can create a rational number in `Julia` by using the `//` operator to divide two integers. For example:

# %% [code]
x = 1 // 2;
print(typeof(x))

# %% [markdown]
# In this example, `x` represents the rational number $\frac{1}{2}$

# %% [markdown]
# ## Bool
# ---
#
# In `Julia`, a bool value (short for boolean value) is a data type that can only take on one of two possible values: `true` or `false`. Bool values are commonly used in programming for logical operations, such as conditionals and loops, where the outcome depends on whether a certain condition is true or false. In `Julia`, bool values are represented using the `Bool` type, which is a subtype of the `Integer` type. The value `true` is equivalent to the integer value `1`, while the value `false` is equivalent to the integer value `0`.
#
# Let's create a variable with a bool value:

# %% [code]
x = true;
print(typeof(x))
