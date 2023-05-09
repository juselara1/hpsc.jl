# ---
# jupyter:
#   jupytext:
#     cell_metadata_filter: -all
#     formats: jl:percent,ipynb
#     text_representation:
#       extension: .jl
#       format_name: percent
#       format_version: '1.3'
#       jupytext_version: 1.14.5
# ---

# %% [markdown]
# # Strings
# ---
#
# In `Julia`, we can store textual information in form of characters `Char` of strings `String`.

# %% [markdown]
# ## Characters
# ---
#
# A `Char` represents a simple character, in `Julia` characters can be codified through the ASCII standard or through Unicode and UTF-8. We can create a character using single quotes `'` as follows:

# %%
x = 'h';
print(x)
print(typeof(x))

# %% [markdown]
# We can obtain the char representation of any ASCII/Unidecode value using `Char`, for instance, we know that the hexadecimal `0x61` corresponds to the letter `a`:

# %%
x = Char(0x61);
print(x)

# %% [markdown]
# If we use more a more larger number, we can obtain a unicode representation

# %%
x = Char(0x1F600);
print(x)

# %% [markdown]
# Similarly, the espace character `\` can be used to define ASCII or unicode characters:

# %%
x = '\x61';
print(x)

# %%
x = '\U1F600';
print(x)

# %% [markdown]
# ## Strings
# ---
#
# In `Julia` a `String` is an **immutable** secuence of characters `Char`. A `String` literal can be defined using double quotes `"` or triple double quotes `"""`.
#
# Let's see an example:

# %%
x = "hello world";
print(x)

# %% [markdown]
# Likewise, multi-line strings can be defined as:

# %%
x = """hello
this string
contains multiple lines.
""";
print(x)

# %% [markdown]
# Similar to `Char`, we can use the `\` character as a scape character. We have the following abbreviations:
#
# - `\t`: tab
# - `\r`: carriage return
# - `\b`: backspace
# - `\f`: form feed
# - `\"`: double quote
# - `\'`: single quote
# - `\\`: backslash
#
# For example:

# %%
print("hello\nworld")

# %%
print("hello\tworld")

# %%
print("hello\rworld")

# %%
print("hello\fworld")

# %%
print("\\hello\\ \"world\"")

# %% [markdown]
# Likewise, ASCII and Unicode are also interpreted in strings:

# %%
print("hello \U1F600")

# %% [markdown]
# In some cases, we want to use raw text inside of strings. The `raw"` literal allows it:

# %%
x = raw"hello\nworld";
print(x)

# %% [markdown]
# We can deffine Perl-compatible regular expressions with the `r"` literal:

# %%
pat = r"\d";
print(typeof(pat))

# %% [markdown]
# It's possible to define version numbers using the `v"` literal:

# %%
version = v"0.1.0"
print(typeof(version))

# %% [markdown]
# Finally, we can define arrays of bytes through the `b"` literal:

# %%
bytes = b"123";
print(bytes)
