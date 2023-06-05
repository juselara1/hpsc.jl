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
# ---

# %% [markdown]
# # Data Structures
# ---
#
# `Julia` has some common data structures to manage multiple values, we have `Tuple`, `NamedTuple`, `Dict`, `Set`, `Vector` and `Array`.

# %% [markdown]
# ## Tuple
# ---
#
# The `Tuple` is a data structure that can hold any number of values but can't be modified, i.e., they're immutable.
#
# We can define a `Tuple` using parenthesis `()` to surround all the values and a comma to separate each one. For example:

# %% [code]
x = (1, "hello", 3);
print(x)
print(typeof(x))

# %% [markdown]
# By default, tuples are created using the `Tuple{Any}` type, which means that it can hold any type.

# %% [markdown]
# ### Indexing
# ---
#
# We can retrieve elements from tuples through indexing (similar to strings), for example:
#
# ```{note}
# `Julia`'s index start in 1.
# ```

# %% [code]
print(x[begin])
print(x[2])
print(x[end])

# %% [markdown]
# ### Functions
# ---
#
# There are some base functions that can use `Tuples` as arguments, for example, we can use `length` to get the number of elements in a tuple:

# %% [code]
print(length(x))

# %% [markdown]
# The `all` function validates if all the elements in a `Tuple` are `true`:

# %% [code]
x = (true, true, true);
print(all(x))

# %% [markdown]
# Likewise, the `any` function validates if atleast one element of the `Tuple` is `true`:

# %% [code]
x = (true, false, false);
print(any(x))

# %% [markdown]
# If we want to validate if an element is contained in a `Tuple` with the `in` function:

# %% [code]
x = (1, "hello", 2);
print(in("hello", x))

# %% [markdown]
# In `Julia` a `Tuple` is closely related to the arguments of a function, for instance, we can define the following function:
#
# $$
# f: x, y \rightarrow x ^ 2 - y ^ 2;
# $$
#
# Let us define it:

# %% [code]
function f(x::Number, y::Number)::Number
    x^2 - y^2
end

# %% [markdown]
# Now, we can define a `Tuple` with two numbers:

# %% [code]
vals = (1, 2);

# %% [markdown]
# Now, we pass the tuple to the function to unpack its values using the elipsis `...`

# %% [code]
print(f(vals...))

# %% [markdown]
# Unpacking is the process of removing the contents of a container. In `Julia`, unpacking can be used to pass multiple arguments to a function as a single argument, or to extract multiple values in a single instruction. For example, let us create a `Tuple` with several values:

# %% [code]
x = (5, 4, 3, 2, 1, 0);
print(x)

# %% [markdown]
# We can extract the first two values into `a` and `b` and save the remaining of the `Tuple` in `c`:

# %% [code]
a, b, c... = x;
print(a)
print(b)
print(c)

# %% [markdown]
# Similarly, we can separate the last value of the tuple in a variable `b` and save the remaning values in `a`:

# %% [code]
a..., b = x;
print(a)
print(b)

# %% [markdown]
# With unpacking, we can concatenate multiple tuples, for example:

# %% [code]
x2 = (x..., x..., x...);
print(x2)

# %% [markdown]
# And we can pass multiple tuples as arguments to functions, for example:

# %%
print(+(x..., x...))
print(+(x...) * 2)

# %% [markdown]
# Using unpacking, we can define functions tha receive any number of arguments, for example:

# %% [code]
g(x...) = print(x);

# %% [markdown]
# We can use this function:

# %% [code]
g(1, 2, 3)
g(1, "hello", 2, 4, -1.5)

# %% [markdown]
# ## Named Tuple
# ---
#
# In `Julia` a `NamedTuple` is a data structure that represents keyword arguments of functions. A `NamedTuple` is defined similar to a regular `Tuple` but each value has an assigned name. Let's see an example:

# %% [code]
x = (x = 1, y = 2);
print(typeof(x))
print(x)

# %% [markdown]
# ### Indexing
# ---
#
# We can extract values from a `NamedTuple` using the dot notation, for instance, we can access the `x` field as:

# %% [code]
print(x.x)

# %% [markdown]
# Likewise, we can index a `NamedTuple` using a `Symbol` (we'll talk about this later), for instance we can extract the field at the `:x` name:

# %% [code]
print(x[:x])

# %% [markdown]
# ### Functions
# ---
#
# In most of the cases, we can use a `NamedTuple` as a regular `Tuple`, for example, we can get the number of elements using the `length` function:

# %% [code]
x = (a = 1, b = 2, c = 3);
print(x)
print(length(x))

# %% [markdown]
# We can extract all the names of the `NamedTuple` with the `propertynames` function:

# %% [code]
print(propertynames(x))

# %% [markdown]
# We can also extract its values as a `Tuple` using the `values` function:

# %% [code]
print(values(x))

# %% [markdown]
# Unpacking is also possible to pass a named tuple as function arguments:

# %% [code]
print(f(x...))

# %% [markdown]
# In addition, we can define a function with any number of keyword arguments treated as a `NamedTuple`:

# %% [code]
function g(x...; y...)
    println(x)
    println(y)
end

# %% [markdown]
# Now we call the function:

# %% [code]
g(1, 2, 3)
g(x = 1, y = 2, z = 3)

# %% [markdown]
# We can also use unpacking to extract several variables from a `NamedTuple`:

# %% [code]
x = (a = 1, b = 2, c = 3);
(; a, b) = x;
print(a)
print(b)

# %% [markdown]
# ## Dictionaries
# ---
#
# A dictionary in `Julia` is an associative data structure that maps keys to values. It is a convenient way to store data that can be accessed by key. Dictionaries are implemented as hash tables, which means that they can be searched and accessed very quickly.
#
# The general type for a dictionary is `AbstractDict` which represents any type of keys and values. Let us define a dictionary:

# %% [code]
x = Dict("name" => "Juan", "lastname" => "Lara");
print(typeof(x))
print(x)

# %% [markdown]
# A `Dict` is defined as a collection of multiple pairs (key and values), we define a `Pair` using the `=>` symbol:

# %% [code]
y = "book" => "Julia";
print(y)

# %% [markdown]
# We can access the key of a `Pair` using the `first` field and the value through the `second` field:

# %% [code]
print(y.first)
print(y.second)

# %% [markdown]
# ### Indexing
# ---
#
# We can access elements in a `Dict` by providing a key as index:

# %% [code]
print(x["name"])

# %% [markdown]
# ### Functions
# ---
#
# We can get the number of `Pairs` in a `Dict` using the `length` function:

# %% [code]
print(length(x)) 

# %% [markdown]
# We can extract all the keys in a `Dict` using the `keys` function:

# %% [code]
k = keys(x);
print(k)

# %% [markdown]
# Likewise, we can extract all the values in a `Dict` using the `values` function:

# %% [code]
v = values(x);
print(v)

# %% [markdown]
# We can also extract a key in a `Dict` using the `get` function. This function assigns a default value if the key has not been created:

# %% [code]
print(get(x, "name", nothing))

# %% [code]
print(get(x, "phone", nothing))

# %% [code]
print(get(x, "phone", 123456))

# %% [markdown]
# With `haskey` we can validate if a `Dict` contains certain key:

# %% [code]
print(haskey(x, "name"))
print(haskey(x, "phone"))

# %% [markdown]
# If we want to add a new pair into the `Dict` we can assign a value to the new key:

# %% [code]
x["email"] = "julara@unal.edu.co";
print(x)

# %% [markdown]
# This is equivalent to the `push!` function, which adds a new pair into the `Dict`.
#
# ```{note}
# The `!` at the end of a function denotes that it may change the input values in-place.
# ```

# %% [code]
push!(x, "phone" => "12345");
print(x)

# %% [markdown]
# The `merge` function allows combine two dicts:

# %% [code]
x = Dict("x" => 1, "y" => 2);
y = Dict("z" => 3, "e" => 4);
z = merge(x, y);
print(x)

# %% [markdown]
# We can also use `merge!` to combine two dictionaries into the first one.

# %% [code]
x = Dict("x" => 1, "y" => 2);
y = Dict("z" => 3, "e" => 4);
merge!(x, y);
print(x)

# %% [markdown]
# We can filter elements from a `Dict` using the `filter` function. It receives a function that takes a `Pair` and must return a `Bool` indicating if the element must be selected.

# %% [code]
x = Dict("a" => 1, "b" => 2, "c" => 3, "d" => 4);
y = filter(p -> p.first in ("a", "b"), x);
print(y)

# %% [code]
x = Dict("a" => 1, "b" => 2, "c" => 3, "d" => 4);
y = filter(p -> p.second > 2, x);
print(y)

# %% [markdown]
# Similarly, we can use `filter!` as an in-place operation to remove the values that do not match a condition.

# %% [code]
x = Dict("a" => 1, "b" => 2, "c" => 3, "d" => 4);
filter!(p -> p.second > 2, x);
print(x)

# %% [markdown]
# If we want to remove a `Pair` from a `Dict`, we can use the `delete!` function.

# %% [code]
x = Dict("a" => 1, "b" => 2, "c" => 3, "d" => 4);
delete!(x, "a");
print(x)

# %% [markdown]
# We can also delete and retrieve a value using the `pop!` function:

# %% [code]
x = Dict("a" => 1, "b" => 2, "c" => 3, "d" => 4);
y = pop!(x, "a");
print(x)
print(y)

# %% [markdown]
# ## Set
# ---
#
# A `Set` in `Julia` is an unordered collection of unique elements. Let's see how to define it from a `Tuple`:

# %% [code]
x = Set((1, 2, 3, 4));
print(typeof(x))
print(x)

# %% [markdown]
# Since `Set` involves unique elements, any duplicated value will be removed:

# %% [code]
x = Set((1, 1, 1, 2, 2, 3));
print(x)

# %% [markdown]
# ### Indexing
# ---
#
# Since a `Set` is an unordered collection, it can not be directly indexed.

# %% [markdown]
# ### Functions
# ---
#
# We can combine sets in several ways, for example, `union` combines two sets:

# %% [code]
x = Set(('a', 'b', 'c'));
y = Set(('b', 'c', 'd', 'e'));
z = union(x, y);
print(z)

# %% [markdown]
# Similarly, `union!` is the equivalent in-place function:

# %% [code]
x = Set(('a', 'b', 'c'));
y = Set(('b', 'c', 'd', 'e'));
union!(x, y);
print(x)

# %% [markdown]
# If we want to extract the values in common between two sets we can use the `intersect` function:

# %% [code]
x = Set(('a', 'b', 'c'));
y = Set(('b', 'c', 'd', 'e'));
z = intersect(x, y);
print(z)

# %% [markdown]
# The `intersect!` function is the in-place equivalent:

# %% [code]
x = Set(('a', 'b', 'c'));
y = Set(('b', 'c', 'd', 'e'));
intersect!(x, y);
print(x)

# %% [markdown]
# The function `setdiff` determines which elements are in the first `Set` and not in the second:

# %% [code]
x = Set(('a', 'b', 'c'));
y = Set(('b', 'c', 'd', 'e'));
z = setdiff(x, y);
print(z)

# %% [markdown]
# The `setdiff!` function is the in-place equivalent:

# %% [code]
x = Set(('a', 'b', 'c'));
y = Set(('b', 'c', 'd', 'e'));
setdiff!(x, y);
print(x)

# %% [markdown]
# ## Vector
# ---
#
# In `Julia` a `Vector` is a ordered and mutable collection of values. We can define a `Vector` using brackets `[]`, for example:

# %% [code]
x = [1, 2, 3, 4, 5];
print(typeof(x))
print(x)

# %% [markdown]
# `Vector` may be a container for any type, and may contain nested values:

# %% [code]
x = [1, 1.0, 3im, true, [1, 2], "hello", 'a'];
print(typeof(x))
print(x)

# %% [markdown]
# ### Indexing
# ---
#
# We can access elements in a `Vector` through indexing, for example:

# %% [code]
x = [1, 2, 3, 4, 5, 6, 7];
print(x[begin])
print(x[end])
print(x[3])

# %% [markdown]
# We can also use ranges to select certain values in a `Vector`:

# %% [code]
print(x[3:end])

# %% [markdown]
# ### Functions
# ---
#
# Similar to other data structures, we can obtain the number of elements with the `length` function:

# %% [code]
print(length(x))

# %% [markdown]
# `Vector` also allows unpacking:

# %% [code]
x = [1, 2, 3, 4, 5, 6];
a, b, c... = x;
print(a)
print(b)
print(c)

# %% [markdown]
# Some other functions also apply on `Vector`, for example, the `map` function to apply a function over each element of the `Vector`:

# %% [code]
x = [1, 2, 3, 4, 5, 6];
y = map(x -> x^2, x);
print(y)

# %% [markdown]
# The `filter` function to match a condition. For example, the following code extracts the strings that start with `hel` using a regular expression:

# %% [code]
x = ["hello", "hell", "hells", "sugar", "pie"];
y = filter(x -> occursin(r"^hel.+$", x), x);
print(y)

# %% [markdown]
# We can also add a value at the end of the array using the `push!` function:

# %% [code]
x = ["hello", "hell", "hells", "sugar", "pie"];
push!(x, "bye");
print(x)

# %% [markdown]
# If we want to delete an element at a certain position we can use the `deleteat!` function:

# %% [code]
x = ["hello", "hell", "hells", "sugar", "pie"];
deleteat!(x, length(x));
print(x)

# %% [markdown]
# Similarly, we can extract and delete any value from a `Vector`:

# %% [code]
x = ["hello", "hell", "hells", "sugar", "pie"];
y = popat!(x, 2);
print(x)
print(y)

# %% [markdown]
# The `reduce` function can generate accumulated values using different functions that take two values.
#
# For instance, we can compute the following operation:
#
# $$
# a = \sum_{i=1}^N x_i
# $$
#
# This operation can be seen as the iterative application of the following function:
#
# $$
# a_i = a_{i - 1} + x_i
# $$
#
# Let's implement this function:

# %% [code]
acum_sum(a, x) = a + x;

# %% [markdown]
# Now, we define the `Vector` that we want to sum:

# %% [code]
x = [1.2, 3.5, 4.3, 5.6, -2.2];

# %% [markdown]
# Finally, we apply the `reduce` function while specifying the initial accumulated value:

# %% [code]
acum = reduce(acum_sum, x; init = 0.0);
print(acum)

# %% [markdown]
# Similarly, we can define a product using the reduce function:
#
# $$
# a = \prod_{i=1} ^ N x_i
# $$
#
# Let's see the implementation:

# %% [code]
x = [1.2, 3.5, 4.3, 5.6, -2.2];
print(reduce(*, x; init = 1.0))

# %% [markdown]
# The `zip` function allows to concatenate two vectors element-by-element as tuples, for example:
#
# ```{note}
# The `collect` function retrieves the values of a pending operation or iterable (we'll see them later).
# ```

# %% [code]
x = ["first", "second", "third", "fourth"];
y = [1, 2, 3, 4];
z = collect(zip(x, y));
print(typeof(z))
print(z)

# %% [markdown]
# In `Julia` we can apply any operator to all the elements of a `Vector` through vectorized operations. This is achieved using the `.` symbol preceding any operator. For example, we can add 1 to all the elements as follows:

# %% [code]
x = [1.2, 3.5, 4.3, 5.6, -2.2];
print(x .+ 1)

# %% [markdown]
# For instance, we can compute a dot product between two vectors as follows:
#
# $$
# \mathbf{x} \cdot \mathbf{y} = \sum_i x_i \cdot y_i
# $$

# %% [code]
x = [1.2, 3.5, 4.3, 5.6, -2.2];
y = [2.3, 4.5, -1, 3.5, 2.1];
z = sum(x .* y);
print(z)

# %% [markdown]
# ## Array
# ---
#
# In Julia, an `Array` is a data structure that stores a collection of elements. Arrays are indexed by integers, and each element can be accessed by its index. The `Array` is a more general type of `Vector` which allows multiple dimensions.
#
# For example, we can create a `Vector` from an `Array` using a single dimension:
#
# ```{note}
# `undef` represents that the array must be initialized as an empty array.
# ```

# %% [code]
x = Array{Float64,1}(undef, 3);
print(typeof(x))
print(x)

# %% [markdown]
# We can validate that `Vector` is a sub-type of `Array`:

# %% [code]
print(Vector <: Array)

# %% [markdown]
# Hovewer, we can define more complex data structures like matrices with `Array`. The following code creates an empty matrix of size `(3, 3)`:

# %% [code]
x = Array{Float64,2}(undef, 3, 3);
print(typeof(x))
print(x)

# %% [markdown]
# We can also create multi-dimensional arrays with this approach:

# %% [code]
x = Array{Float64,3}(undef, 4, 4, 3);
print(typeof(x))
print(x)

# %% [markdown]
# To get the size of an `Array` we can use the `size` function:

# %% [code]
print(size(x))

# %% [markdown]
# We can also create arrays from literals using the brackets `[]`. Nevertheless, an `Array` is defined using spaces as the values separator instead of commas:

# %% [code]
x = [1 2 3 4];
print(typeof(x))
print(x)

# %% [markdown]
# These literals may include the `;` character as a separator  of values in different dimensions. For instance, the following defines a matrix:

# %% [code]
x = [
    1 2 3 4
    5 6 7 8
    9 10 11 12
];
print(typeof(x))
print(size(x))

# %% [markdown]
# Furthermore, we can define multidimensional arrays using this notation:

# %% [code]
x = [
    1 2 3; 4 5 6; 7 8 9;;;
    1 2 3; 4 5 6; 7 8 9;;;
    1 2 3; 4 5 6; 7 8 9;;;
    1 2 3; 4 5 6; 7 8 9
];
print(typeof(x))
print(size(x))

# %% [markdown]
# ### Indexing
# ---
#
# Multidimensional arrays provide different indexing mechanisms:
#
# - **Single integer**: it extracts the value at the given position (memory-based), let's see an example:

# %% [code]
x = [
    1 2 3;
    4 5 6;
    7 8 9;;;

    1 2 3;
    4 5 6;
    6 8 9;;;
];
print(size(x))

# %% [markdown]
# In this case, we will select the first value in the first dimension of the `Array`:

# %% [code]
y = x[1]
print(size(y))
print(y)

# %% [markdown]
# We can index another value:

# %% [code]
y = x[4];
print(size(y))
print(y)

# %% [markdown]
# - **Range**: when we use a `Range` (defined with `:`) we can specify how the array will be indexed, for example, the following code extracts a matrix of `(3, 3)` from the `Array` by indexing its last dimension:

# %% [code]
y = x[:, :, 1];
print(y)
print(size(y))

# %% [markdown]
# We can also extract a `(3, 2)` matrix by indexing the first value in the first dimension:

# %% [code]
y = x[1, :, :]; 
print(y)
print(size(y))

# %% [markdown]
# Likewise, the following example selects the first two elements of the first dimension, the last two elements of the last dimension and the first value of the third dimension:

# %% [code]
y = x[begin:2, 2:end, 1];
print(y)
print(size(y))

# %% [markdown]
# - **Sequence**: we can use a sequence to extract certain positions of an `Array`, for example, in the following example we select the first and third rows of a matrix:

# %% [code]
x = [
    3 2 1;
    4 5 6;
    7 8 9
];

# %% [markdown]
# Now, we extract the rows using a `Vector`:

# %% [code]
print(x[[1, 3], :])

# %% [markdown]
# - **Mask**: we can use a `Vector{Bool, n}` of the same `size` of the vector for a conditional selection of values, for example, the following code selects the values of the matrix that are higher than 3:

# %% [code]
y = x[x .> 3];
print(y)

# %% [markdown]
# We can combine this with logical operators to get a more complex conditional selection:

# %% [code]
y = x[((x .> 3) .& (x .< 6)) .| (x .== 8)];
print(y)

# %% [markdown]
# - **Cartesian**: `Julia` has the `IndexStyle` abstract type to define a custom index for arrays, For example:

# %% [code]
idx = CartesianIndex(
    (1, 1)
);
print(idx)

# %% [markdown]
# Now we use the index:

# %% [code]
res = x[idx];
print(res)

# %% [markdown]
# Likewise, the `CartesianIndices` allows to define indices for each dimension:

# %% [code]
idx = CartesianIndices(
    (
    1:2,
    1:2
    )
);

# %% [markdown]
# We can use these indeces:

# %% [code]
res = x[idx];
print(res)

# %% [markdown]
# ### Functions
# ---
#
# There are some functions that generate arrays of a given size and type. For example, `range` generates a given number of values between two numerical values:

# %% [code]
x = range(1, 10, 50); # start = 1, end = 10, n_points = 50
print(x)

# %% [markdown]
# We can generate a vector from this with the unpacking notation:

# %% [code]
x..., = range(1, 10, 20);
print(x)

# %% [markdown]
# There are also functions that generate constant arrays, for example the `zeros` function uses a type to generate an array of any number of dimensions:

# %% [code]
x = zeros(UInt8, (5, 5));
print(typeof(x))
print(size(x))

# %% [markdown]
# We can generate multidimensional arrays with this approach:

# %% [code]
x = zeros(Float32, (10, 10, 3, 3));
print(size(x))

# %% [markdown]
# With the `ones` function we can generate a constant array initialized with ones, it also receives a type and a size:

# %% [code]
x = ones(UInt16, (3, 3));
print(typeof(x))
print(size(x))

# %% [markdown]
# Similarly, we can initialize an array with any value using the `fill` function:

# %% [code]
x = fill('a', (2, 3));
print(typeof(x))
print(size(x))
print(x)

# %% [markdown]
# There are some functions for array manipulation. For example, the `sum` function returns the sum of all the array elements. Let us define a matrix:

# %% [code]
x = [
    1.3 2.2 3.5
    0.1 3.2 0.9
];

# %% [markdown]
# Let's see the sum of these values:

# %% [code]
res = sum(x);
print(res)

# %% [markdown]
# Hovewer, most of the functions that receive arrays as arguments also have the `dims` parameter. It controls which dimensions must be aggregated or eliminated. The following example computes the sum over all the columns (eliminating the row dimension) of the matrix:

# %% [code]
res = sum(x, dims = (1,));
print(size(res))
print(res)

# %% [markdown]
# We can also compute the sum over the rows:

# %% [code]
res = sum(x, dims = (2,));
print(size(res))
print(res)

# %% [markdown]
# We can use the `argmax` and `argmin` functions to identify the index of the maximum and minimum values respectively:

# %% [code]
res = argmin(x);
print(res)
print(x[res])

# %% [code]
res = argmax(x);
print(res)
print(x[res])

# %% [markdown]
# These functions can also be combined with the `dims` parameter:

# %% [code]
res = argmin(x; dims=(1,));
print(res)
print(x[res])

# %% [code]
res = argmax(x; dims=(2,));
print(x[res])

# %% [markdown]
# The `sort` function allows to sort a multidimensional array:

# %% [code]
x = [
    3 2 1 5 0 4 5 3;
    4 5 2 3 1 8 2 1
];

# %% [markdown]
# We can sort on any dimension:

# %% [code]
res = sort(x; dims=1);
print(res)

# %% [code]
res = sort(x; dims=2);
print(res)

# %% [markdown]
# We can use the `map` function to apply a function to each element of the array:

# %% [code]
x = [
    1 2 3
    4 5 6
];

# %% [code]
res = map(x -> sqrt(x), x);
print(res)

# %% [markdown]
# Likewise, we can use the `map` function to apply a function over several arrays:

# %% [code]
x = [
    1 2
    3 4
];
y = [3 4; 1 2];
res = map(*, x, y);
print(res)

# %% [markdown]
# The reduce function works similar as it was shown with vectors:

# %% [code]
x = [
    1 2 3;
    4 5 6
];

# %% [markdown]
# Let's see the result:

# %% [code]
res = reduce((x, y) ->  x + y, x);
print(res)

# %% [markdown]
# However, it's possible to specify the `dims` parameter to aggregate over certain dimensions:

# %% [code]
res = reduce((x, y) -> x * y, x; dims=(1, ), init=1);
print(res)

# %% [markdown]
# We can combine the `reduce` function with `min` and `max` functions to get the result on a dimension:

# %% [code]
res = reduce(min, x; dims=(1, ));
print(res)

# %% [code]
res = reduce(max, x; dims=(2, ));
print(res)

# %% [markdown]
# When we're dealing with multidimensional arrays it's common to use broadcast operations. Broadcasting is a mechanism that allows operations between arrays of different shapes. This is done by "broadcasting" the smaller array across the larger array so that they have compatible shapes. If the arrays have different sizes in any dimension, then the size of the smaller array is broadcast to the size of the larger array by repeating the values of the smaller array.
#
# In `Julia` we can implement this behavior with the `broadcast` function, let's see an example:

# %% [code]
x = [
    1 2 3;
    4 5 6;
    7 8 9;
    1 2 3
];
y = [0 1 0;]
print(size(x))
print(size(y))

# %% [markdown]
# Now, we'll use broadcast to multiply the `y` row vector to each row of the matrix `x`:

# %% [code]
res = broadcast(*, x, y);
print(res)

# %% [markdown]
# ```{note} 
# If you already program in `Python` with `numpy` or in `matlab`, the broadcasting rules are the same.
# ```
#
# In addition, most of the numerical operations also receive input arrays, for example the `cos` function:

# %% [code]
x = [
    1. 2 3;
    4 5 6;
    7 8 9;
    ];
y = cos(x);
display(y)

# %% [markdown]
# ```{note} 
# The `display` function allows a better view of the data, it uses the richest multimedia output of the input.
# ```
#
# The `reshape` function allows to change the `size` of an `Array`:

# %% [code]
x..., = 1:10;
print(x)

# %% [markdown]
# We can create a new `Array` of size `(2, 5)` using the `reshape` function:

# %% [code]
y = reshape(x, (2, 5));
display(y)

# %% [markdown]
# Finally, the `convert` function allows to change the type of an `Array`:

# %% [code]
x = [
    1 2 3;
    4 5 6
];
print(typeof(x))

# %% [markdown]
# Now, we convert the `Matrix{Int64}` into a `Matrix{Float64}`:

# %% [code]
y = convert(Matrix{Float64}, x); 
display(y)
typeof(y)
