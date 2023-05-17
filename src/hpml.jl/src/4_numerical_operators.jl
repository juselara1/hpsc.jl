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
#       jupytext_version: 1.14.5
# ---

# %% [markdown]
# # Numerical Operators
# ---
#
# There are different types of operators that work between two `Julia` numbers. These include arithmetic, comparison, logical, bitwise and updating operators.

# %% [markdown]
# ## Arithmetic
# ---
#
# You can perform classical arithmetic operations between two numbers in `Julia`. Whenever it's possible, the types are automatically cast in a convenient way. For instance, we can sum two integers with the `+` operator:
#
# %% [code]
x = Int8(2) + Int16(3);
print(x)
print(typeof(x))

# %% [markdown]
# As you can see, the result has the higher numerical precision between the operands. Likewise, if anything is operated with a `Float` value, the results will be cast into floats:

# %% [code]
x = Int32(2) + Float16(3);
print(x)
print(typeof(x))

# %% [markdown]
# Let's see the arithmetic operations.
#
# - **Addition**: this is performed with the `+` operator:

# %% [code]
x = 3.0 + 4;
print(x)

# %% [markdown]
# - **Substraction**: this is performed with the `-` operator:

# %% [code]
x = 3.0 - 1.2;
print(x)

# %% [markdown]
# - **Multiplication**: this is performed with the `*` operator:

# %% [code]
x = 3.0 * complex(2, 3);
print(x)

# %% [markdown]
# - **Division**: this is performed with the `/` operator:

# %% [code]
x = 3.2 / 1.2;
print(x)

# %% [markdown]
# - **Reverse division**: this is performed with the `\` operator:

# %% [code]
x = 1.2 \ 3.2;
print(x)

# %% [markdown]
# - **Exponentiation**: this is performed with the `^` operator:

# %% [code]
x = 2^3;
print(x)

# %% [markdown]
# - **Modulo**: this is performed with the `%` operator:

# %% [code]
x = 5 % 2;
print(x)

# %% [markdown]
# ## Comparison
# ---
#
# We can use comparison operators to validate conditions over numerical values and returns a boolean value of the operation.
#
# - **Equality**: this is performed with the `==` operator:

# %% [code]
x = Int8(2) == Int16(2);
print(x)

# %% [markdown]
# - **Difference**: this is performed with the `!=` operator or the `≠` symbol:

# %% [code]
x = Float16(0.0) != Int8(0);
print(x)

# %% [markdown]
# - **Inequalities**: we have four kind of inequalities. Less than uses the `<` operator, greater than uses the `>` operator, less or equal than uses the `<=` or the `≤` operator, and greater or equal uses the `>=` or the `≥` operator:

# %% [code]
x = Int8(2) < 3.0f0;
print(x)

# %% [code]
x = Int16(32) >= UInt8(3);
print(x)

# %% [code]
x = Float16(4) <= 3.5;
print(x)

# %% [markdown]
# ## Logical
# ---
#
# These operators work over boolean values and implement the three basic boolean algebra operations:
#
# - **And**: it is implemented with the `&&` operator:

# %% [code]
x = false && false;
print(x)

# %% [code]
x = false && true;
print(x)

# %% [code]
x = true && false;
print(x)

# %% [code]
x = true && true;
print(x)

# %% [markdown]
# - **Or**: it is implemented with the `||` operator:

# %% [code]
x = false || false;
print(x)

# %% [code]
x = false || true;
print(x)

# %% [code]
x = true || false;
print(x)

# %% [code]
x = true || true;
print(x)

# %% [markdown]
# - **Not**: it is implemented with the `!` operator:

# %% [code]
x = !true;
print(x)

# %% [code]
x = !false;
print(x)

# %% [markdown]
# ## Bitwise
# ---
#
# Bitwise operations are manipulate the binary representation of integers in `Julia`. The following operators are available:
#
# - **Bitwise and**: this is implemented with the `&` operator. Let's see an example of the and operation between two bytes of data:

# %% [code]
x = 0b10001000 & 0b10000000;
print(x)

# %% [markdown]
# This operation is equivalent too:

# %% [code]
x = UInt8(136) & UInt8(128);
print(x)

# %% [markdown]
# Also with hex literals:

# %% [code]
x = 0x88 & 0x80;
print(x)

# %% [markdown]
# - **Bitwise or**: this is implemented with the `|` operator:

# %% [code]
x = 0b00001111 | 0b11110000;
print(x)

# %% [markdown]
# - **Bitwise not**: this is implemented with the `~` operator:

# %% [code]
x = ~0b11110000;
print(x)

# %% [markdown]
# - **Left shift**: this is implemented with the `<<` operator. It's useful for low-level integer multiplication:

# %% [code]
x = 15 << 1; # 15 * 2
print(x)

# %% [code]
x = 15 << 2; # 15 * 4
print(x)

# %% [code]
x = 15 << 3; # 15 * 8
print(x)

# %% [markdown]
# - **Right shift**: this is implemented with the `>>` operator. It's useful for low-level integer division:

# %% [code]
x = 64 >> 1; # 64 / 2
print(x)

# %% [code]
x = 64 >> 2; # 64 / 4
print(x)

# %% [code]
x = 64 >> 3; # 64 / 8
print(x)

# %% [markdown]
# ## Updating Operators
# ---
#
# These operators allow you to reassign the result of a variable after operating with its value.
#
# Any arithmetic or bitwise operator can be transformed into an updating operator by placing the assignment operator `=` after the operator. For instance, the operator `+=` takes what was previously assigned to a variable, adds a value and reassigns the result:

# %% [code]
x = 1.5;
x += 2;
print(x)
