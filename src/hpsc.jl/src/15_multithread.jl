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
# # Multithreading
# ---
#
# `Julia` directly allows multithreading with the base `Threads` package. However, the default repl uses a single thread.
#
# To enable several threads in `Julia`, it must be spawn as follows:
#
# ```sh
# julia --threads 4
# ```
#
# This allows, `Julia` to use 4 threads.
#
# We can validate the number of threads in the current repl with the `nthreads` function:

# %% [code]
println(Threads.nthreads()) 

# %% [markdown]
# ## Manual Threads
# ---
#
# We can manually create a thread using the `@spawn` macro. This creates a `Task` as in coroutines.
#
# Let's see an example of this with a simple example:

# %% [code]
import Base.Threads.@spawn
 
# %% [code]
t1 = @spawn begin 
    println("Entering background thread")
    sleep(5)
    println("Exiting background thread" )
end;

sleep(2)
println("Code executing in the main thread")
wait(t1)

# %% [markdown]
# The `@spawn` macro can be used to parallelize different operations. For example, we can parallelize several element-wise product between two random matrices.
#
# ```{note}
# The `randn` function generates a normally-distributed random `Array` of the given size.
# ```
#
# First, let us perform this operation without threading:

# %% [code]
@time begin
    res = [];
    for i in 1:100
        y = randn(Float64, (1000, 1000));
        push!(res, y .* y)
    end
end
 
# %% [markdown]
# Now, let's see the same code with threading:
 
# %% [code]
@time begin
    tasks::Vector{Task} = [];
    for i in 1:100
        y = randn(Float64, (1000, 1000));
        push!(tasks, @spawn(y .* y))
    end

    res = [];
    for t in tasks
        wait(t)
        push!(res, t.result)
    end
end

# %% [markdown]
# Generally, you can find that the code with threading is around four times faster than the code without threading.

# %% [markdown]
# ## Thread Loops
# ---
# 

# %% [markdown]
# ## Sharing Memory
# ---
#
