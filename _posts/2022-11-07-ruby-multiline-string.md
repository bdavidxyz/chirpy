---
title: Ruby multiline String
author: david
date: 2022-11-07 11:33:00 +0800
categories: [ruby]
tags: [ruby]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Ruby multiline String
---

## What is a multiline string ?

A multiline string is a string that, when displayed, returns the output in more than one line.

```ruby
message = "Hello!
This is my first multiline string."

p message
# => Hello!
# => This is my first multiline string.
```

With Ruby, there are different ways to create multiline strings. In this article, we will go over the main methodologies and highlight their functionalities. But before that, there are two things that are relevant when writing multiline strings.

## The two main aspects to consider before writing a multiline string

You might consider these two aspects before choosing the methodology to write a multiline string:

1. If you want to **include or exclude the blank spaces** before each line (in your code). Note that this also includes indentation.
2. If you need to <a href="https://en.wikipedia.org/wiki/String_interpolation#:~:text=String%20interpolation%20is%20common%20in,Tcl%20and%20most%20Unix%20shells." target="_blank" >**interpolate variables** within your string</a>.


## Single and double quotes

The most common way of writing strings with more than one line is by using either **single quotes** or **double quotes**. The characteristics of this method are:

- Single quotes do not allow interpolation, while double quotes do.
- It preserves any blank spaces at the beginning of each line.
- If your string includes quotes as part of its content, make sure to use the opposite quotes to encapsulate your string.
- You can create line breaks in your code even if you write in one line by using `\n`.

 ```ruby
name = "Christian"

message = "Hello #{name},\nHow are you?
        Note the blank spaces here."
p message

# => Hello Christian,
# => How are you?
# =>      Note the blank spaces here.
```

## Multiple lines with HEREDOC

**Heredoc** is a particular syntax that relies on a **delimiting identifier** to write multiline strings. The identifier is used at the beginning (after `<<`) and the end of the string, and it can be any word/character in capital letters.  Normally, and as best practice, developers use the words `HEREDOC`, `TEXT` or `EOF`. When using Heredoc notation, please consider that:

- It allows interpolation.
- It keeps blank spaces and indentations at the beginning of each line. But if you wish to ignore indentation, you can do so by using the special character `~` after `<<`.

```ruby
name = "Marie"

message = <<TEXT
    Hi, #{name}!
      How are you?
TEXT

p message

# =>     Hi, Marie!
# =>       How are you?
```

Now using `~`:

```ruby
name = "Marie"

message = <<~TEXT
  Hi, #{name}!
  What's up?
  TEXT

p message

# => Hi, Marie!
# => What's up?
```

Note that indentation is also ignored on the last delimiter, TEXT. If you need to ignore indentation just in that line, you can use `-` instead of `~`.

## Multiple lines thanks to the percent sign (%)

Finally, the last method to create strings with more than one line is by using % notation. It has several forms, but the most common syntax is `%q(YOUR_STRING)`.  The characteristics of this method are:

- `%q`does not allow interpolation, but `%Q` does.
- It keeps indentations and blank spaces.

```ruby
string = %q(This is the longest
loooooongest string
    I have ever written
)

p string

# => This is the longest
# => loooooongest string
# =>    I have ever written
```

## Summary

We have summed up the different ways to create multiline strings with Ruby. Knowing the characteristics of each method, should help you understand when to use each option to write efficient and readable code. Remember to check other entries that will [help you write efficient Ruby code](https://www.bootrails.com/categories/ruby/)!

On a final note, keep in mind that [when defining hashes and arrays](https://bootrails.com/blog/how-to-define-and-use-a-ruby-hash/) we can use strings, and that also includes multiline strings!