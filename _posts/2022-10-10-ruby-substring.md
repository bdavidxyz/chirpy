---
title: Ruby Substring
author: david
date: 2022-10-10 11:33:00 +0800
categories: [ruby]
tags: [ruby]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Ruby Substring
---

## Ruby String

Strings are one of the main and most used classes in programming languages. **A string is a container of character sequences**. Typically, strings represent text, but they can encapsulate any character (numbers, spaces and special characters).

When interacting with strings, it is very useful to select subsets of them (substrings). There is no method in Ruby dedicated to this special purpose. However, there are several workarounds. In this article we are going to explore the two main ways to interact with substrings:

1. Considering the string an array
2. RegEx

## Ruby Substring from character

The idea of understanding a string as an array helps us interact with the different characters of the string. For example, having the string `"Hello world!"`, we can isolate its characters by doing this:

```ruby
string = "Hello world"
array = string.chars()
p array
# => ["H", "e", "l", "l", "o", " ", "W", "o", "r", "l", "d", "!"]
```

And now, we are able to access the different characters according to their index position:

```ruby
p array[0]
p array [1]
p array.last
# => "H"
# => "e"
# => "!"
```

## Ruby Substring length

Following this logic, it is very convenient to work with the string and substring's length. For this, we can use the methods `size` or `length`.

```ruby
p string.length()
# => 13
```

We can select a substring of a specific length:

```ruby
string = 'Hello, world!'
substring_1 = string[0, 5]
substring_2 = string[7, string.length - 1]

p substring_1
p substring_2
# => "Hello"
# => "world!"
```

## Between two Strings

If we want to create substrings by identifying a particular character, we can easily do so using the `partition` method. For example, a name:

```ruby
full_name = "Chris Smith"
name = full_name.partition(" ")
p name

# => ["Chris", " ", "Smith"]
```

Now, we are able to interact with the first name and last name as per its position in the array:

```ruby
p first_name = name.first
p last_name = name.last
# => "Chris"
# => "Smith"
```

**Important**: Note that `partition` only identifies the first character that matches the condition and returns an array of three elements. If the name was `Chris Smith Doe`, the method would return:

```ruby
full_name = "Chris Smith Doe"
name = full_name.partition(" ")
p name

# => ["Chris", " ", "Smith Doe"]
```

## From index to end

Also, a common practice is to create a substring from a given index position until the end of the main string. Let's do it:

```ruby
string = "abcedfghijklm"
substring = string[5..-1]
p substring

# => "fghijklm"
```

Remember that the last position of a character/element is always -1. And, in order to include that position, we use two dots (..) instead of three as a range.

## Before or after a specific character

Finally, and following this methodology, we might want to build a subset according to one or more specific character or set of characters. This is a little bit more complex, but the idea is to create an array of characters and then, [loop through the elements](https://bootrails.com/blog/ruby-loops-overview/) to obtain the index position of the specific pattern.

```ruby
string = 'Hello, world!'
array = string.chars()

match_index = []
i = 0
array.each do |c|
  if c == "o"
    match_index << i
  end
  i += 1
end

p match_index

# => [4, 8]
```

Now we know that there are two "o" in our string positions 4 and 8. And, for example, we can create a substring containing the characters in between:

```ruby
# Including "o"
substring = string[4..8]
p substring

# => "o, wo"
```

## Regex

The above logic is easy to understand and makes sense when building simple collections of substrings. However, it can easily get more complex and long (too many code lines!). To avoid this and keep our code clean, we can use **Regular Expression, RegEx**.

Regular expressions are a sequence of characters that follow a specific set of rules (language) which enable us to define and search for patterns within strings.

[There is a whole article about RegEx here](https://bootrails.com/blog/ruby-regex-friendly-guide/), but let's see an example using the method `match`:

```ruby
string = "This is the title and this is the body of the document."
p string.match(/^(.*?)title/).to_s

# => "This is the title"
```

There are also great online tools to explore and correct RegEx sequences (i.e. <a href="https://rubular.com/" target="_blank" >Rubular</a>).

## Summary

Interacting with strings and extracting subsets is very useful, especially when checking and analyzing user input (validations, data gathering, etc.). Hence, it is important to know the different ways to do so, and understand when to use each method, with the ultimate goal of writing simple code and free of mistakes.