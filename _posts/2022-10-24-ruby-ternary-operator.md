---
title: Ruby ternary operator
author: david
date: 2022-10-24 11:33:00 +0800
categories: [ruby]
tags: [ruby]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Ruby ternary operator
---

## Intro

Operators are a basic tool in programming languages. The main ones are arithmetic and comparison operators. Ruby includes the **ternary operator**, which encapsulates both: an **if statement** and a **comparison** in a single line of code.

## The syntax

The syntax of the ternary operator is easy, and as its name reveals, is structured in three parts: **condition - value if true - value if false**

This means the operator first evaluates a condition and then executes, depending on the result of the condition, the "truthy" or the "falsey" statement.

To understand the logic of it, take the example of [checking emptiness](https://www.bootrails.com/blog/ruby-nil-vs-blank-vs-empty-vs-presence/):

```ruby
x = []
p x.empty? ? "x is empty" : "x is not empty"

# => x is empty
```

## Why a ternary operator ?

Developers prefer to use the ternary operator rather than the if/else statement or other workarounds. The main reasons for that are:

1. It reduces the lines of code and makes it more readable
2. Makes execution of basic if/else logic easier
3. Reduces complexity of the structure when the if/else logic is heavily used

## The Ruby case

Another methodology to do such operations, and specially for those that are more complex, is the **case statement**. [We have written a whole article about the switch statement in Ruby](https://bootrails.com/blog/switch-statement-ruby/), but let's refresh it, because it is interesting to know how to handle each scenario accordingly.

The case statement executes a different code when the first condition of the "case list" is met. For example:

```ruby
level = 60

case
  when level < 50
    p "beginner"
  when level < 70
    p "intermediate"
  else
    p "expert"
end

# => p "intermediate"
```

## Examples of Ruby ternary operator

Going back to the ternary operator, let's take a simple example:

```ruby
level = 60

p level < 50 ? "beginner" : "expert"

# => p "expert"
```

Here you can see how easily we can chunk a multiple if/else statement into one single line.

However, this example seems not able to fit the previous one and allow multiple case scenarios. Don't worry! Ruby does allow multiple conditions within a ternary operator:

```ruby
level = 60
p level < 50 ? "beginner" : level < 70 ? "intermediate" : "expert"

# => p "intermediate"
```

In this example, we can see how to check multiple cases and a final "else" case with the ternary operator. Use this logic in order to keep the lines of code short. However, as soon as it starts to get longer and more complex, you should switch to the case or if/else statements.

## Summary

The ternary operator is very useful and helps us organize and keep our code clean. The most important takeout here is, that as a developer, you should always consider if a ternary operator will simplify readiness and execution, and apply it accordingly.

If you are not familiar with the ternary operator or the case statement, you can use online tools such as <a href="https://replit.com/" target="_blank" >replit</a> and start playing around.