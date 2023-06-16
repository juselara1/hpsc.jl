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
# # Coroutines
# ---
#
# In parallel programming, a coroutine is a computer program component that generalizes subroutines for non-preemptive multitasking, by allowing multiple entry points for suspending and resuming execution at certain locations. Coroutines are used for cooperative multitasking, where the control is explicitly passed between different coroutine functions, rather than relying on the operating system's thread scheduler for context switching.
#
# Unlike traditional subroutines, which have a single entry point and return point, coroutines allow for multiple entry and exit points within a single function. This means that a coroutine can be paused, its state saved, and then resumed later from where it left off. This ability to suspend and resume execution at specific points makes coroutines well-suited for managing concurrent and asynchronous tasks.

# %% [markdown]
# ## Tasks 
# ---
#
# In `Julia` we can create a task using the `@task` macro. For example:
#
# ```{note}
# the `sleep` function indicates that a task must be idle for a given number of seconds.
# ```

# %% [code]
t = @task begin 
    println("Task start")
    sleep(2)
    println("Task end")
end

# %% [markdown]
# We can start a task with the `schedule` function, also, the `wait` function validates when the task has finished:

# %% [code]
schedule(t);
wait(t)

# %% [markdown]
# Let's see an example of the creation of multiple tasks that execute concurrently: 
#
# First, we define a function that returns a task:

# %% [code]
function get_task(i::Int64)::Task
    t = @task begin
        println("Starting task $i")
        sleep(1)
        println("Ending task $i")
    end
    return t
end;

# %% [markdown]
# Now, we can create 10 tasks: 

# %% [code]
tasks::Vector{Task} = []; 
for i in 1:10
    push!(tasks, get_task(i));
end

# %% [markdown]
# We can schedule all the tasks and await them:

# %% [code]
for task in tasks 
    schedule(task)
end

for task in tasks
    wait(task)
end

# %% [markdown]
# As you can see, the code is executed concurrently. 

# %% [markdown]
# ## Async
# ---
#
# We can call functions asynchronously using the `@async` macro. This creates a `Task` that has already been scheduled.
#
# Let's see an example with the following function:

# %% [code]
function f(x::AbstractFloat)::AbstractFloat
    t0 = time_ns()
    sleep(1)
    t1 = time_ns()
    return Float64(t1 - t0) * x / 1e9
end

# %% [markdown]
# We can execute this function: 

# %% [code]
print(f(1.))
print(f(1.))

# %% [markdown]
# Now, we can call the functions asynchronously using `@async`: 

# %% [code]
tasks = [];
for i in ones(Float32, (3, ))
    push!(tasks, @async f(i))
end

for task in tasks
    wait(task)
end

# %% [markdown]
# We can collect the results:

# %% [code]
for task in tasks 
    println(task.result)
end
