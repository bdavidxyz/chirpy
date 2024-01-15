---
title: Ruby Enumerable Module
author: david
date: 2022-07-04 11:33:00 +0800
categories: [ruby]
tags: [ruby]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Ruby Enumerable Module
---

## Introduction to the enumerable module

**Modules are the major result of inheritance**, since they allow us to execute actions without having to write code and sharing features among unrelated classes.
  

Because of Ruby being an **object-oriented programming language**, the role of data collections is very important. Some of the methods included in the enumerable module are so popular that people tend to think they are components of the Ruby language.

The methods included in these module can be grouped depending on the nature of its functionality:

- Querying
- Fetching
- Searching and filtering
- Iterating
- Other

In this article, we will review each group of the module and analyze the main methods in it. But before that, we need to go over some topics that are key to understanding the basics of data collections and how to interact with them.

## Enumerable vs Enumerator

We already wrote about [Ruby Enumerator](https://bootrails.com/blog/ruby-enumerator-what-why-how/).
 
It is common to mix up the concepts of enumerable and enumerator. Hence, it is important to know the difference and how they relate to each other. While the enumerable is a module that encapsulates a set of methods, **the enumerator** is the definition of a class that allows internal and external iteration.

In other words, enumerators support all methods included in the enumerable module. Also, one of the main features of enumerators is that they can be chained together and transformed into new enumerators.

As per Ruby's documentation, to create an enumerator we can use the methods `to_enum` or `Enumerator.new`.

## External vs internal iteration

Probably, you have heard of the different types of iterations and tried to understand its complexity, which is not little! However, we are going to keep it simple in this article and stick to the practical aspects.

Data collections in Ruby (enumerators) allow both, external and internal iteration. When iterating through elements in a collection of items, what we are doing is performing an operation on each element of the list. With **internal iteration** that operation is going to be executed on every element, even if it is an infinite list. While **external iteration** requires to loop through the collection by calling each element explicitly.

## How to implement the enumerable module

Implementing and using the enumerable module is very easy, specially since it is included in the main Ruby classes (array, [hash](https://bootrails.com/blog/how-to-define-and-use-a-ruby-hash/), range, dir), gems (i.e. devise) and projects (Ruby on Rails).
  
However, if you have to manually include the module in a class you can `include Enumerable` following the <a  href="https://ruby-doc.org/core-3.1.2/Enumerable.html#:~:text=element%2C%20cycling%20repeatedly.-,Usage,-%C2%B6%20%E2%86%91"  target="_blank"  >Ruby Documentation</a> guidelines.

## Enumerable methods

### Methods for querying

Querying methods are used to get information about the enumerator. The most common are:  

- include?: Returns a boolean. True, if the collection of data includes a specific object

- all?, any?, none?, one?: Return a boolean. True, if the collection of data meets a specific criterion for all of its elements, some, none or exactly one.

- count: Returns an integer that represents the number of times a criterion is met inside a collection.

```ruby
answers = ("yes", "yes", "no")
answers.count("yes")
#=> 2
```

- tally: Returns a new Hash containing the elements that meet the criterion specified in the block.
  
### Fetching methods

Let's start with the simple fetching methods: first, last, take and drop. The `first` and `last` methods, as per its name, return the elements in that position:

```ruby
user = ["Marta", 34, "Barcelona", 0]

user.first
#=> Marta

user.last
#=> 0
```

To use `take` and `drop`, we need to specify the number of elements that we want to obtain/omit:

```ruby
user.take(2)
#=> ["Marta", 34]

user.drop(1)
#=> [34, "Barcelona", 0]
```

Remember that the logic starts counting elements from the first element, not the index position!

Take and drop can also include blocks that allow us to apply custom criteria by using `take_while` and `drop_while`.

It is also a common practice to use maximal and minimal values to fetch elements. This can be done with the `max` and `min` methods, or a combination of both `minmax`, which returns an array with the minimal and maximal value.

The alternative fetching methods are the ones that divide elements into groups using `group_by`, `partition` and `slice`. The difference between them is that a group returns a hash containing elements grouped according to a given condition in a block. And partition and slice methods return **two or more** new arrays.

Note that slice has different forms: `slice_after`, `slice_before` and `slice_when`.

### Searching and filtering methods

Searching and filtering methods is very useful when validating collections of data. Also, it has many applications when building user interfaces. Typically we use these:  

1.  `find` or `detect`: Returns **one element** given a condition in a block. If there is more than one, then, the first element that meets the condition is returned.

```ruby
numbers = [1, 2, 3, 4, 5]
numbers.find { |i| i > 1}
#=> 2
```

2.  `filter` or `select`: Returns **a collection of elements** given a condition in a block.

```ruby
numbers = [1, 2, 3, 4, 5]
numbers.filter { |i| i > 1}
#=> [2, 3, 4, 5]

```  

3.  `uniq`: Returns **one or more** elements that are unique in the collection of data (if any).

### Sorting methods

Sorting is useful when accessing or displaying long collections of data. The principal methods for that are `sort` and `sort_by`. A quick example would be:

```ruby
array = ["a", "aaa", "aa"]
array.sort_by { |element| element.size }
#=> ["a", "aa", "aaa"]
```

### Iterating methods

For iterating through collections, aside from the `each`, we can use some of its variations included in the module such as `reverse_each`, `each_with_object` or `each_with_index`. Let's take a look at this last variation to understand the logic:  

```ruby
list = ["eat", "sleep", "work", "play"]
list.each_with_index { |element, index| p  "#{index + 1}. #{element}" }

#=> 1. eat
#=> 2. sleep
#=> 3. work
#=> 4. play
```

Remember that the index starts at 0, this is why we add 1 in the example, to have a proper list.

### Other methods

Last but not least, we have additional methods of different nature in this module that are worth analyzing:

-  `map`: Returns a new version of the object, having performed a specific operation on each element (specified on the block):

```ruby
(1..3).map { |e| e+1 }
#=> [2, 3, 4]
```

-  `map_with_index`: [An alternative to the map method worth taking a look at!](https://bootrails.com/blog/ruby-map-with-index/)

-  `filter_map`: Works like the map method but returns a collection of the elements that validate to truth given a filtering condition.


-  `sum`: Returns the sum of the elements composing the collection of data.

```ruby

(1..3).sum
#=> 6

(1..3).sum { |e| e+1 }
#=> 9

```

-  `cycle`: Cycles **repeatedly** through the elements of the collection. 

## Conclusion
 
Enumerators are key to object-oriented languages, where having a robust way to address and interact with collections is critical. Using the methods in the enumerable module is not only a good practice, but also a much more reliable option than trying to write methods on your own.