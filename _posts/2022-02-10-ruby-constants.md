---
title: Ruby constants
author: david
date: 2022-02-10 11:33:00 +0800
categories: [ruby]
tags: [ruby]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Ruby constants
---

## Motivation

We don't have a lot of Ruby constants in the <strong>[bootrAils](http://bootrails.com/)</strong> starter. However, it's always good to know how they work when the need arises.  
"Constants" are variables that are not meant to be changed. Let's see how. In this article we will use the ruby console, if you are in a Rails environment, you can get it by typing `bin/rails console`.

## How to define a Ruby constant

Constants begin with an uppercase letter.

Example :

```ruby
Boiling = 100 # valid
BOILING = 100 # valid
boiling = 100 # invalid
```
Constants defined within a class or module can be directly accessed from the inside. Those defined outside a class or module can still be accessed globally.

Example :

```ruby
class Water
   ICE = 0
   BOIL = 100
   def show
      puts "Celsius temperature for becoming ice is #{ICE}"
      puts "Celsius temperature for becoming steam is #{BOIL}"
   end
end
```

As you can notice, ICE and BOIL are freely accessed from the class where they are defined. From the outside :

```ruby
Water::ICE
# => 0
Water::BOIL
# => 100
Water.new.show
# => Celsius temperature for becoming ice is 0
# => Celsius temperature for becoming steam is 100
```

## Ruby constants that will fail

### Constants cannot be defined inside a method.

Example :

```ruby
class Water
   def show
      ICE = 0
      BOIL = 100
      puts "Celsius temperature for becoming ice is #{ICE}"
      puts "Celsius temperature for becoming steam is #{BOIL}"
   end
end
# Traceback (most recent call last):
# SyntaxError ((irb):117: dynamic constant assignment)
# ICE = 0
```

### Constants cannot start with a lower case.

```ruby
class Water
   ice = 0 # ! fail ! Constant cannot start with lowercase
   boil = 100 # ! fail ! Constant cannot start with lowercase
   def show
      puts "Celsius temperature for becoming ice is #{ice}"
      puts "Celsius temperature for becoming steam is #{boil}"
   end
end
```
This will produce the following error on call :

```ruby
Water::ice
Traceback (most recent call last):
        1: from (irb):87:in `<main>'
NoMethodError (undefined method `ice' for Water:Class)
```

### Uninitialized Constant Error

This kind of error will often happen if you code with Ruby-on-Rails or any other framework. It often means a class or constant inside a module wasn't found. You can easily recreate this error on your computer :

```ruby
class Water
   ICE = 0
   BOIL = 100
   def show
      puts "Celsius temperature for becoming ice is #{ICE}"
      puts "Celsius temperature for becoming steam is #{BOIL}"
   end
end
```

And then try simply to access a constant that doesn't exists :

```ruby
irb(main):131:0> Water::ICE
0
irb(main):132:0> Water::UNEXISTING
Traceback (most recent call last):
        1: from (irb):132:in `<main>'
NameError (uninitialized constant Water::UNEXISTING)
```

## Changing... A Ruby constant

This is something disturbing if you come from another language : Ruby constants can be changed without the raise of any error.

```ruby
Water::ICE = 42
# => warning: already initialized constant Water::ICE
Water::ICE
# => 42
```

A warning is raised, but the program still continues.

If you want to avoid this default behaviour, you have to `freeze` your constant. 

For this example, I'm going to freeze... the ice.

```ruby
class Water
   ICE = 0.freeze
   BOIL = 100.freeze
   def show
      puts "Celsius temperature for becoming ice is #{ICE}"
      puts "Celsius temperature for becoming steam is #{BOIL}"
   end
end
```

It doesn't really work, because you can still make `Water::ICE = 42` and have a simple warning.

> A Ruby constant isn't actually immutable, and you can't [freeze](http://ruby-doc.org/core-2.1.3/Object.html#method-i-freeze) a variable.

See this excellent StackOverflow answer to circumvent this problem : [https://stackoverflow.com/a/26542453/2595513](https://stackoverflow.com/a/26542453/2595513)