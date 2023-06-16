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
# # Base Functions
# ---
#
# `Julia` has several pre-implemented functions that operate over the default primitive types that we've seen.

# %% [code]

# %% [markdown]
# ## Mathematical Functions
# ---
#
# The base Julia package implements a wide range of mathematical functions, including:
#
# - **Arithmetic operations**: addition `+`, subtraction `-`, multiplication `*`, division `/`, and exponentiation `^`. For example, the function `^(x, y)` does the following operation: `x ^ y`

# %% [code]
print(^(2, 3))

# %% [markdown]
# - **Trigonometric functions**: sine `sin`, cosine `cos`, tangent `tan`, cotangent `cot`, secant `sec`, and cosecant `csc`.

# %% [code]
print(sin(pi / 2))

# %% [markdown]
# - **Hyperbolic functions**: hyperbolic sine `sinh`, hyperbolic cosine `cosh`, hyperbolic tangent `tanh`, hyperbolic cotangent `coth`, hyperbolic secant `sech`, and  hyperbolic cosecant `csch`.

# %% [code]
print(tanh(2))

# %% [markdown]
# - **Exponential and logarithmic functions**: exponential `exp`, logarithm `log` (defaults to base $e$ but can use other bases), `log10`, and `log2`.

# %% [code]
print(log(10))

# %% [code]
print(log(2, 4)) # log base 2

# %% [markdown]
# Other mathematical functions: absolute value `abs`, sign function `sign`, floor function `floor`, ceil function `ceil`, round to closest integer `round`, truncate number to a given number of decimals `trunc`, square root `sqrt`, equivalent `isapprox`.

# %% [code]
print(isapprox(0.1, 0.1001, rtol=0.01))

# %% [markdown]
# ## String Functions
# ---
#
# There are several functions that operate on strings, specially, we find functions for: search, spell modification, and structure modification.

# %% [markdown]
# ### Search 
# ---
#
# Search is one of the most common tasks performed over strings. In `Julia` we can do exact and regex matching.
#
# For example, the function `occursin` evaluates if a `Char` or `String` is contained in other `String`:

# %% [code]
print(occursin('o', "hello")) 

# %% [code]
print(occursin('a', "hello")) 

# %% [code]
print(occursin("hel", "hello")) 

# %% [markdown]
# We can also determine the start index of a match with the `findfirst` function: 

# %% [code]
print(findfirst('l', "hello"))

# %% [markdown]
# We can also find the last match:

# %% [code]
print(findlast('l', "hello")) 

# %% [markdown]
# If we want to get multiple matches in a string, we can use the `findnext` function, which allows specifying a start search position:

# %% [code]
print(findnext("this", "this is this", 5))

# %% [markdown]
# The `count` function computes the number of occurrences of a sequence in a string, for example:

# %% [code]
print(count("the", "I'm the man who sold the world"))

# %% [markdown]
# We can use the `length` function to get the number of characters in a `String`:

# %% [code]
print(length("hello"))

# %% [markdown]
# We can perform advanced text search with regular expressions. We can define regular expressions using the `r""` notation, for example:

# %% [code]
pat = r"\d+";

# %% [markdown]
# Now we can search the pattern in the following text: 

# %% [code]
text = "I'm 26 years old";
print(occursin(pat, text))

# %% [markdown]
# ```{note}
# we can use any `String` search function with a regex pattern.
# ```
#
# `Julia` uses Perl-like regex (same as Python), therefore, we've the following identifiers:
#
# | Identifier | Meaning |
# | --- | --- |
# | `\d` | Digit |
# | `\D` | Non digit |
# | `\w` | Alphanumeric |
# | `\W` | Non alphanumeric |
# | `.` | Any character |
# | `\s` | Any whitespace character |
# | `\S` | Not a whitespace character |
# | `\t` | Tab character |
# | `\n` | New line |
# | `\r` | Carriage return |
# | `\f` | New page |
# | `\v` | Vertical tab |
# | `\x` | ASCII character |
# | `\u` | Unicode character |
# | `^` | Sequence start |
# | `$` | End of sequence |
#
# We can also create custom identifiers with the `[]` pattern, for instance `[aeiou]` represents any vowel and `[a-z]` represents any lowercase letter.
#
# Also, we have can define quantifiers using the `{}` pattern, for instance `{1,3}` represents that an identifier can appear from 1 to 3 times sequentially. There are some abbreviations for quantifiers:
#
# | Abbreviation | Quantifier |  Meaning |
# | --- | --- | --- |
# | `+` | `{1,}` | Appears one ore more times |
# | `*` | `{0,}` | Appears 0 or more times |
# | `?` | `{,1}` | Optional |
#
# Let's see an example of a regex to extract any URL from a text, first we define the pattern:

# %% [code]
pat = r"https?://\S+[ $]";

# %% [markdown]
# Now let's define a text for the search:

# %% [code]
text = "I'm hosting my project at https://github.com/juselara1/hpml.jl feel free to take a look.";

# %% [markdown]
# We can use the `match` function (similar to `findnext` but returning match objects) to find the pattern:

# %% [code]
res = match(pat,  text);
print(res)

# %% [markdown]
# The `RegexMatch` provides more information about the search, for instance, we can extract the matched text with the `match` field:

# %% [code]
print(res.match) 

# %% [markdown]
# Likewise, we can get the start index of the match using the `offset` field:

# %% [code]
print(res.offset) 

# %% [markdown]
# We can also define groups using the `()` pattern or named groups using the `(?<tag>)` pattern to get specific information in the match, for example, the following pattern extracts the username and repository name from a GitHub repository:

# %% [code]
pat = r"https://github.com/(\w+)/(?<repo>[\w\.]+)";

# %% [markdown]
# Now we define the search text:

# %% [code]
text = "my repo is https://github.com/juselara1/hpml.jl you can clone it";

# %% [markdown]
# The match: 

# %% [code]
res = match(pat, text) 
print(res)

# %% [markdown]
# We can extract the groups by indexing over the match object, for example, the first group:

# %% [code]
print(res[1]) 

# %% [markdown]
# Or the named group:

# %% [code]
print(res["repo"])

# %% [markdown]
# We can also obtain the start position of each group using the `offsets` field:

# %% [code]
print(res.offsets) 

# %% [markdown]
# If we want to replace a match with any other text, we can use the `replace` function.
#
# For instance, the following code replaces the GitHub URL with only the username and the repository:

# %% [code]
print(replace(text, pat => s"\1/\g<repo>"))

# %% [markdown]
# ```{note} 
# `s""` denotes a substitution string, `\1` obtains the first group, and `\g<repo>` obtains the text of the named group `repo`.
# ```

# %% [markdown]
# ### Spell Modification 
# ---
#
# Spell modification involves operations that transform the strings, for instance `uppercase` transforms a string to uppercase letters:

# %% [code]
print(uppercase("hello"))

# %% [markdown]
# Similarly, `lowercase` transforms a string to lowercase letters:

# %% [code]
print(lowercase("HeLlo")) 

# %% [markdown]
# We can also capitalize a string using the `uppercasefirst` function:

# %% [code]
print(uppercasefirst("hello world")) 

# %% [markdown]
# We can also capitalize the first letter of each word using the `titlecase` function:

# %% [code]
print(titlecase("this is a hello world example"))

# %% [markdown]
# ### Structure Modification
# ---
#
# There are several functions that modify the structure of strings, for example we can reverse a string with the `reverse` function:

# %% [code]
print(reverse("hello")) 

# %% [markdown]
# We can also split a string using a separator:

# %% [code]
print(split("a,csv,format,is,separated,by,comma", ',')) 

# %% [markdown]
# For instance, we can implement a basic word tokeniser using using the space separator:

# %% [code]
print(split("this is a sentence", " "))

# %% [markdown]
# We can use the `join` function to merge multiple strings into a single one, for example:

# %% [code]
print(join(split("hello,world", ","), " "))
