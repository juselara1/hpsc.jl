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
# # Metaprogramming
# ---
#
# Metaprogramming is a programming technique in which computer programs have the ability to treat other programs as their data. This means that a program can be designed to read, generate, analyze or transform other programs, and even modify itself while running.
#
# `Julia` allows to directly manipulate `Julia` code through symbols and expressions.

# %% [markdown]
# ## Symbols
# ---
#
# In `Julia` a `Symbol` is a type of data that is closely-related to the code. For example, in this code:

# %% [code]
x = 1;
 
# %% [markdown]
# `x`, `=` and `1` are symbols. We can explicitly declare a `Symbol`:

# %% [code]
s = Symbol("x");
display(s)
 
# %% [code]
s = Symbol("=");
display(s)
 
# %% [markdown]
# We can also define a `Symbol` from multiple values:
 
# %% [code]
s = Symbol("x", "_", 1);
display(s)

# %% [markdown]
# The `:` operator allows a simplified manner to define a `Symbol`:
 
# %% [code]
s = :x_1;
display(s)
println(typeof(s))
 
# %% [markdown]
# ## Expressions
# ---
#
# In `Julia` an expression `Expr` is a piece of code meant to be evaluated. An `Expr` is also created with the `:` operator when there's more than one symbol (tokenized by spaces), for example:

# %% [code]
ex = :(x + 1);
display(ex)
println(typeof(ex))
 
# %% [markdown]
# Each `Expr` contains `Symbols` which can be accessed through the `args` field:
 
# %% [code]
display(ex.args)
println(typeof(ex.args))
 
# %% [markdown]
# In this case, we've an expression that contains two symbols (`+` and `x`) and one literal (`1`).
#
# We can also define expressions of multiple lines through `quote`:
 
# %% [code]
ex = quote
    x = 1;
    x += 1;
end;
 
# %% [markdown]
# Let's see the expression:
 
# %% [code]
display(ex)
println(typeof(ex))
 
# %% [markdown]
# We can evaluate an expression through the `eval` function:
 
# %% [code]
eval(ex);
println(x)
 
# %% [markdown]
# Similar to `String`, we can interpolate literals and simbols into `Expr` using the `$` operator. For example:
 
# %% [code]
variable = :x;
ex = quote
    $variable = "hello";
    $variable *= " world";
end;
 
# %% [markdown]
# Let's see the expression:
 
# %% [code]
display(ex)
 
# %% [markdown]
# We can evaluate this expression:
 
# %% [code]
eval(ex)
println(x)
 
# %% [markdown]
# ## Macros
# ---
#
# Macros are a mechanism to transform expressions. A macro can be seen as a function that receives expressions, symbols or literals and returns a new expression that is directly compiled.
#
# Let's see an example:

# %% [code]
macro mymacro(exp)
    display(exp)
    println(typeof(exp))
end;

# %% [markdown]
# To call a macro we must use the `@` operator, let's see an example:

# %% [code]
@mymacro(x = 1)

# %% [markdown]
# The parenthesis are optional, we can invoke a macro by separating the code by spaces:

# %% [code]
@mymacro x = 1 

# %% [markdown]
# We can also have multiple lines of code that is transformed into a quote using a scope:

# %% [code]
@mymacro begin 
    x = 1;
    print(x)
end

# %% [markdown]
# Let's see an example of a macro that measures the time of a piece of code:
#
# ```{note}
# The `time_ns` function returns the current time in nanoseconds.
# ```

# %% [code]
macro measure_time(code)
    ex = quote
        start_time = time_ns();
        $code
        delta = (time_ns() - start_time) * 1e-9;
        println("Total time $(delta) [seconds]")
    end;
    return ex
end

# %% [markdown]
# Let's see the execution:
#
# ```{note}
# The `sleep` function blocks the current task for a given number of seconds.
# ```

# %% [code]
@measure_time begin 
    x = 2;
    x = x ^ 2;
    sleep(2)
end

# %% [markdown]
# Macros can have multiple arguments, for example, the following macro computes the average execution time of some code:

# %% [code]
macro measure_avg_time(code, n) 
    ex = quote
        samples = zeros(Float64, ($n, ))
        for i in 1:$n
            start_time = time_ns();
            $code
            delta = (time_ns() - start_time) * 1e-9;
            samples[i] = delta;
        end
        tot_time = sum(samples) / $n;
        println("Average time $(tot_time) [seconds]")
    end
    return ex
end

# %% [markdown]
# Let's use this macro:
 
# %% [code]
@measure_avg_time begin 
    x = 2;
    x = x ^ 2;
    sleep(0.5)
end 10
