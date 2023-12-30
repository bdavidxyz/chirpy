---
title: Ruby pattern matching
author: david
date: 2022-05-19 11:33:00 +0800
categories: [ruby]
tags: [ruby]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Ruby pattern matching
---

## What is pattern matching?

If you are new to the feature, welcome to the typical "Pattern matching journey"; where first, you don’t know what it is, then, you don’t understand it, and finally, you don’t know how you could work without it.

The pattern matching feature consists in checking data given an expected result or pattern. Some people tend to confuse pattern matching with [Regex (Regular Expression)](https://www.bootrails.com/blog/ruby-regex-friendly-guide/), because this searching tool allows us to find and replace string searchable patterns. Pattern matching is much more than that, we could say it is the evolution of Regex, as it enables us to work with not only string patterns but arrays, hashes,  and any other object.

Using pattern matching simplifies the code because its syntax is intuitive and declarative. As you will see, we write the expected outcome instead of having to break down components and creating complex structures, using loops and conditionals such as `if ... elsif ... else`.

## Ruby syntax

The pattern matching syntax in Ruby is very similar to a conditional case statement, but instead of using `case when`, we use `case in` as per below:

```ruby
case <variable or expression>
 in <pattern1>
   ...
 in <pattern2>
   ...
 else
   ...
end
```

The syntax allows to match both, variables and expressions, towards one or more patterns. Note that after each pattern we could add an if or [unless statement](https://www.bootrails.com/blog/ruby-unless/) to create a guard:

```ruby
case <variable or expression>
  in <pattern2> if <expression>
    ...
  else
    ...
end
```

Now that we have seen the basic syntax of pattern matching, we will be able to understand how it works and the additional components that will help us get the most of this feature.

## How does pattern matching work in Ruby?

Let’s start with an easy example to get familiar with the matching feature:

```ruby
a = ["Paul", 27]
case a
  in [String, Integer]
    p "match"
  else
    p "not match"
end
#=> match
```

In this example we are validating if the given expression `["Paul", 27]` follows the pattern of having a string element in the first position of the array and an integer in the second position. The same logic can be applied to hashes as per below:

```ruby
case {name: "Paul", age: 27}
  in {name: "Paul"}
    p "Hi #{:name}!"
  else
    p "not match"
end
#=> Hi Paul!
```

Applying pattern matching in hashes allows us to check subsets of the hash, like in the example, where only the name is validated in the pattern. While it is true, that when matching arrays, the whole array is taken into account, there is an easy workaround to tell Ruby that we do not need to consider certain elements by using `*`.

```ruby
a = ["no", "no", "YES", "no"]
case a
  in [*, "YES", *]
    p "match"
  else
    p "not match"
end
#=> match
```

Naturally, pattern matching also allows to match more complex structures of nested arrays and hashes, which is especially useful in order to avoid confusing looping and conditional functions. For this matter it is very important to understand the concepts of **binding** and **pinning**, that come into play when using variables inside the expression and pattern structures.

### Pattern matching: binding variables

The concept of binding implies that when matching a variable towards a value, the validation will not only be truthfully but the variable will be reassigned with the given value. Let’s see an example using two variables, `a` and `b`:

```ruby
case ["book", "table", "chair" ]
  in [a, b, "chair"]
    p "variable a is #{a} and b is #{b}."
end
#=> variable a is book and b is table.
```

In this case, the pattern matches and the variables a and b are assigned with the values of "book" and "table" respectively.

### Pinning variables

As the name might suggest, pinning variables is used to evaluate the value of a variable without reassigning it. While binding variables is a default behavior, to pin a variable has to be specified by using `^`:

```ruby
case ["book", "table", "chair" ]
  in [a, ^a, "chair"]
    p "match"
  else
    p "not match"
end
#=> not match
```

In this example, the pattern is not matched because when validating, element by element the variable first matches and gets reassigned to  `a = "book"`, but then it is not possible to validate the pinned variable `^a` against `"table"` because `"book" != "table"`.

## Use cases

Having a clear view of the feature and how it works to validate and match patterns, the questions now are: When to implement it? And, why is it specially useful when building applications based on the [MVC architecture](https://www.bootrails.com/blog/ruby-on-rails-mvc/)?

1. To create **guards and validations** that are easily understood when reading the code and therefore easy to update.
2. To handle **Json data**. This is very remarkable because Json files are structured into hashes and the use of patterns rather than conditional functions results in a great minimization of complexity and code.
3. To **scope and identify strange behavior** in the application.
4. To create **best practices** when developing larger interfaces with many controllers and models, by using special methods in every class that make pattern matching even more intuitive. This special methods are `deconstruct` and `deconstruct_keys`. <a href="https://www.toptal.com/ruby/ruby-pattern-matching-tutorial#:~:text=Deconstruct%20and%20Deconstruct_keys" target="_blank" >Read this tutorial about deconstruct</a> to have a better understanding of this methods.

## Conclusion

The pattern matching feature is relatively new in Ruby. It was first released in Ruby 2.7 and improved in the 3.1 version. Hence, there is still room to further improve its current performance  and create new methods to support it.

It might seem complicated at the beginning or just easier to keep using conditionals, but once you start playing around with this feature you will see how powerful it is and the benefits of its declarative nature when working together with other developers.