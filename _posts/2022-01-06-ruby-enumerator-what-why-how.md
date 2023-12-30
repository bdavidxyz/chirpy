---
title: "Ruby Enumerator , the what, the why, the how"
author: david
date: 2022-01-06 11:33:00 +0800
categories: [ruby]
tags: [ruby]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: "Ruby Enumerator , the what, the why, the how"
---

## What are Enumerators ?

This section will give you a general understanding of a few important terms and their distinctions. Before we start using them, we need to understand the concept of Enumeration and the tools Ruby gives us for Enumeration. Also, we will be assuming that you are comfortable with blocks in Ruby.

## *Enumeration*, The *Enumerable* Module and *Enumerator*

*Enumeration*: As a concept simply means to traverse a list of items according to some logic. In programming, we often come across lists and the need to traverse these *lists* is a common programming necessity.

*Enumerable*: When using lists we commonly use either the `for` loop or the `.each` method to iterate over the items in them. We know the `for` loop is a form of flow-control but where does this `.each` method come from ? You might think it comes from whichever *Class* the list belongs to but in fact, it is an inherited method from the *`Enumerable`* module. 

This module, when included inside a *Class* that contains a set of elements, allows any *Class* to inherit a number of methods that one would need to traverse that set of elements. 
There are many built-in enumerables in Ruby such as *Array*, *Hash*, and *Range* and all of them receive their enumeration capabilities by using the *`Enumerable`* module. 

This module relies on a method called `.each`, which needs to be implemented in any *Class* it's included in. Other important methods like `.map`, `.reduce` and `.select` that rely on the implementation of the `.each` method to function can then be used for free.

When called with a block on an array, the `.each` method will execute the block for each of the array's elements:
  
```ruby
nums = [1,2,3] # An Array is an Enumerable
nums.each { |i| puts "* #{i}" }
# => 1
# => 2
# => 3
```

*Enumerator*: A class that is instantiated by either defining a `Enumerator.new` or by calling an instance method of an `Enumerable` object. So if we call the `.each` method on an array without passing a block to execute for each of its elements, we'll receive an instance of `Enumerator`. Sounds a bit confusing I know. Lets simplify with a basic example:

```ruby
nums = [1,2,3]
puts nums.each
# => <Enumerator: 0x00007fa3657f90f8>
```

## Why it's nice

We previously discussed how the `for` loop can also be used to iterate over a list. So why do we need to use the methods provided by the `Enumerable` module? Well, you see when we use a `for` loop we risk introducing a bug into our code by inadvertently overwriting a previously declared variable's value. 

Sample below:  

```ruby
fighter = 'Jackie'
fighters_list = ['Bruce', 'Rocky', 'Rambo']

for fighter in fighters_list
  puts fighter
end

puts "Your Fighter has changed => " + fighter # Unintended change
```

Console output:

```shell
=> Bruce
=> Rocky
=> Rambo
=> Your Fighter has changed =>  Rambo
```

Clearly, this is not desirable. This is where `Enumerable#each` can be pretty handy. If we were to use the following code, the value of the *"fighter"* variable would remain unchanged.

```ruby
fighters_list.each { |fighter| puts fighter }
```

This is why it is almost always better to use the `.each` method provided by an Enumerable to iterate over it. There are also many other common things we wish to do with lists such as reduce a list down to a single value like its sum, modify the whole list, and write our own custom logic to iterate over a list if we want to protect some data on the client-side. We can do all of that and more if we use an `Enumerable`. We will discuss usage in detail in just a bit.

## How do I use enumerables ?

So how do we end up using Enumerable in our code? You have a lot of freedom in this and there are plenty of places where using *enumerables* is useful.

### Chained Enumeration

You can use the .each method to traverse over the list, but what if we wanted to modify the list and our mapping logic uses the index of each element. The `Enumerable#map` method seems like a good first thought. However, this can modify the list but cannot track indexes of individual elements.

```ruby
nums_enum = [1, 2, 3].map
nums_enum.each { |num| puts num }
# => 1
# => 2
# => 3
```

We also have the `Enumerable#each_with_index` method. This won't modify the list but we can at least track indexes with it. You can already see where I am going with this. Yes indeed with the help of `Enumerators` we can chain these two together to create our very own "Map with Index"-like function call ! Sample below:

```ruby
nums_enum = [1, 2, 3].map # Called without a block so returns #Enumerator
# => #<Enumerator: ...>  

p nums_enum.each_with_index{ |n, i| n * i } # Called with block so will iterate with index
# => [0, 2, 6]

p [1,2,3].map.each_with_index{ |n, i| n * i } # Shortened to a single line
# => [0, 2, 6]
```

You can play around with this and chain a large number of methods as long as it serves your goals.

```ruby
10.times.reverse_each.cycle.first(11)

=> [9, 8, 7, 6, 5, 4, 3, 2, 1, 0, 9]
```

### Manual Iteration

In some cases, you may want to have manual control over your iterations. The Enumerable module provides the `.next` method and you can call this on an Enumerator as well:
  
```ruby
nums_enum = [1, 2].each
nums_enum.next
# => 1

nums_enum.next
# => 2

nums_enum.next
# => `next': iteration reached an end (StopIteration)
```

### Custom Classes and Iterations

The beauty of Enumeration in Ruby is the amount of customization it provides. What if you wanted to half custom traversal logic for some list or *Class*.

#### 1. Enumerator

```ruby
digits = (1..10).to_a # Range to Array

def odd_digits(digits)
  index = -1
  Enumerator.new do |yielder|
    loop do
      index += 1
      yielder << digits[index] if digits[index] % 2 == 0
    end
  end
end
```

Console:

```shell
$> puts odd_digits(digits).first(4)
=> 2
=> 4
=> 6
=> 8
```

#### 2. `Enumerable` Implementation

By far the coolest and most detailed implementation use case is when you have a custom class that contains a set of elements. As discussed previously we will need to add two things to the *Class* to grant it the powers of Enumeration. Firstly we need to include the `Enumerable` module. Secondly, we need to implement the `each` method in the class to iterate over the elements. Most cases allow falling back to the `each` method of another object such as an array.

Let' implement a linked list *Class* with a custom structure so that it cannot rely on the `Array#each` method to iterate over the nodes.

```ruby
class LinkedList
  
  def initialize(head, tail = nil)
    @head, @tail = head, tail
  end

  def add(item)
    LinkedList.new(item, self)
  end

end

LinkedList.new(0).add(5).add(10)
# => <LinkedList:0x1 @head=10, @tail=<LinkedList:0x2 @head=5, @tail=<LinkedList:0x3 @head=0, @tail=nil>>>
```

We have created our linked list but have no way of iterating over the individual nodes/elements. To do this, we finally visit the last and possibly most important piece of code.

```ruby
class LinkedList include Enumerable # We inherit enumerable methods that use .each

  def initialize(head, tail = nil)
    @head, @tail = head, tail
  end

  def add(item)
    LinkedList.new(item, self)
  end

  def each(&block) # Implement our custom each

    if block_given?
      block.call(@head)
      @tail.each(&block) if @tail
    else
      to_enum(:each) # Return enumerator if block not provided
    end

  end

end
```

  

So what does this code do? The inclusion of `Enumerable` is self-explanatory by this point. More importantly, we implement the `.each` method to let other enumerable methods know how to iterate our linked list.

In the `.each` method if a block is given we simply call the block on the current node and recursively call *.each* on the rest of the list until the final node is `nil`. If a block was not provided then return an *Enumerator* that uses our *.each* method. This last bit will allow the chaining of methods discussed in an earlier use case.

  

Console:

```shell
$> linked_list = LinkedList.new(1).add(5).add(10)

$> linked_list.each{ |node| puts node }
=> 0
=> 5
=> 10

$> linked_list.select{ |node| node % 5 == 0 } # Select if divisible by 5
=> [10, 5]
```

Congratulations! Our linked list implementation now has access to other useful methods like `.map` and `.select` as shown in the example above.
 
Hopefully, all of this made sense. In case some things are still hazy, then try practicing by creating your own enumerators and using them in your code.

Thanks for reading. That’s a wrap!