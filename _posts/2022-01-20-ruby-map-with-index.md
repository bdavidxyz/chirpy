---
title: "Ruby, map with index"
author: david
date: 2022-01-20 11:33:00 +0800
categories: [ruby]
tags: [ruby]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: "Ruby, map with index"
---

## Intro

Just like many other programming languages, the Map method is also in ruby. You use a ruby map or map, in general, to transform the data and perform functions on each element of the object. You can use it with the hashes, ranges, and arrays. All these work as an Enumerable object with a map. Let's dive into this guide and learn more about the ruby map method.

## Map with index

There is no direct "map_with_index" method in Ruby. Instead, you could do one of these :

```ruby
my_array = [:mouse, :bat, :pangolin]
newly_created_array = my_array.each_with_index.map { |value, index| "The #{value} is at position #{index}" }
# => ["The mouse is at position 0", "The bat is at position 1", "The pangolin is at position 2"]
```

In this example, `my_array` is left as-is.

Unsurprisingly, the `each_with_index` method returns a two-dimensional array

```ruby
my_array = [:mouse, :bat, :pangolin]
newly_created_array = my_array.each_with_index.to_a
# => [[:mouse, 0], [:bat, 1], [:pangolin, 2]]
```

Another nice possibility, and probably more intuitive way to achieve a "map with index" is as follow (since Ruby 1.9)

```ruby
my_array = [:mouse, :bat, :pangolin]
newly_created_array = my_array.map.with_index { | value, index | "The #{value} is at position #{index}" }
# => ["The mouse is at position 0", "The bat is at position 1", "The pangolin is at position 2"]
```

Now we've seen how to map with indexes, let's go back to basics.

## Ruby Map Method - Basic Understanding

A ruby map method features an enumerable object (object on which you are calling the map method) and a block. For each element of the object, the map executes the block and applies that particular functionality to it. The map returns an array as a result which is constructed by the result of evaluating the block. Once you'll see the syntax, it'll start making sense for you.

## Ruby Map Method - Syntax

The syntax of the ruby map method is pretty simple. Let's say your enumerable object is an array of numbers. Then it would simply look like `my_array.map`. This part of the syntax is followed by the block which is defined inside the two brackets `{}`. 

You define the functions and tasks inside this `{}` block. You define how you would like to transform every element of `my_array`.  For instance, you want to multiply each element of the array with 2. Then, you'll define it by declaring a variable inside the block. Take a look at the following piece of code.

```ruby
my_array = [1, 2, 3]
p my_array.map { |n| n * 2 } # |n| -> declaring a variable, n*2 performing the function
# output: [2, 4, 6]
```

Now that you have a basic understanding of the ruby map, let's take a look at more examples for concrete understanding.

## Examples - Ruby Map

If you are familiar with the functionalities in ruby, you can simply define them in a map and use that to your advantage. For instance, let's convert a string array into an integer array using the ruby map method.

### Converting a String Array into an Integer Array Using Ruby Map

```ruby
my_array = ["10","9","8"]
p my_array.map {|str| str.to_i} 
# output: [10, 9, 8]
```

`to_i` is the function that is used to convert a string into an integer.

### Using Map on String Array

You can also use the maps to transform every element of the string to upper case. 

```ruby
my_array = ["x", "y", "z"]
p my_array.map { |string| string.upcase }
# output: [X, Y, Z]
```

### Using Map on Hash

Let's see a bit of a complex example. We can also use a map on a hash. As we all know that the hash contains a key-value pair. So, there are basically two arguments in this case instead of one. We'll have to define two variables and we'll be able to perform the functionality/transform on every key-value pair present in the hash.  In the following example, we are converting every element of the hash into a symbol using `to_sym`. 

```ruby
hash = { protein: "Meat", fruit: "orange" }
p hash.map { |k,w| [k, w.to_sym] }
# output: [[:protein, :Meat], [:fruit, :orange]]
```

In the previous examples, we have learned that a map returns a result in the form of an array. As you can see in the above code example, the map returned an array. A multidimensional array. One element of an array contains two elements. So, how do we get the hash that we require? See the following example.

```ruby
hash = { protein: "Meat", fruit: "orange" }
p hash.map { |k,w| [k, w.to_sym] }.to_h
# => {:protein=>:Meat, :fruit=>:orange}
```

As you can see, just by simply writing `to_h` which is used to convert objects into a hash, we convert the resultant array from the map into a hash. 

You can also use ruby maps to execute the following tasks. 

```ruby
c = [18, 22, 3, 3, 53, 6] 
p c.map {|num| num > 10 } 
# => [true, true, false, false, true, false]
p c.map {|num| num.even? }
# => [true, true, false, false, false, true]
```

The above code example is pretty clear. In the first map method, you are checking if the elements of the array are greater than 10 or not. The output then should be self-explanatory. In the second map method, you are checking which of the elements of the array are even numbers. 

### Ruby Map with Indexes

If you want the resultant array to show up with indexes, you can simply do that by using `with_index` method. Let's see the code example.

```ruby
my_array = ["a","b", "c"]
p my_array.map.with_index { |ch, idx| [ch, idx] }
# output: [["a", 0], ["b", 1], ["c", 2]]

############

my_array = [10, 50, 100]
p my_array.map.with_index { |ch, idx| [ch, idx] }
# output: [[10, 0], [50, 1], [100, 2]]

############

my_array = %w(1 2 3)
p my_array.map.with_index { |ch, idx| [ch, idx] }
# output: [["1", 0], ["2", 1], ["3", 2]]
```

As you can see that `with_index` can be used with any data type. Using this method, the map will generate a resultant array featuring indexes. Take a look at the last example. `my_array = %w(a b c)`, you must be noticing something unusual here. `%w` is a shortcut for creating strings. If you see the output, you'll notice that the values of the resultant array are of string data type. 

## Ruby Map vs Each 

You can say `.each` is just a basic version of `.map`. It works the same as a ruby map. The only difference is that it does not collect the results. The resultant array in the case of `.each` will always be unchanged and in its original state. It means that in the case of each, it does not collect the result. On the other hand, the `.map` has the same functionality but it collects and stores the resulting array. 

```ruby
my_array = [1, 2, 3]
p my_array.each { |n| n * 2 }
# [1, 2, 3]
p my_array.map { |n| n * 2 }
# [2, 4, 6]
```

Notice that the original array is unchanged. 

## Ruby Map vs Collect

Ruby `.map` and `.collect` happen to be different names for the same purpose. They are used for the same functionality and tasks. But overall, the `.map` is more commonly used.

## Final Thoughts

In this guide, you learned the basic understanding of ruby maps. Now it's time for you to practice more and more. Get a good grip on its functionalities and try to use it in different programming tasks.