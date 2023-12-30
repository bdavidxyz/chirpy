---
title: Ruby loops overview
author: david
date: 2022-08-29 11:33:00 +0800
categories: [ruby]
tags: [ruby]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Ruby loops overview
---

## What is a loop?  
  
We can explain looping as the action of repeating the same thing over and over. In programming, as in real life, we need assembly lines. Imagine a cake factory that has a defined process: mix ingredients, bake cake, unmold cake, pour frosting and pack the cake. This process takes place every day 100 times. If the factory's activity was translated into code and the process was defined in a method called "cake_process", we could program each day as per below:  
  
```ruby  
# DAY 1  
cake_process()  
cake_process()  
...  
# continue 97 times  
...  
cake_process()  
```  
  
Or we could do something much simpler, **loop** 100 times through the baking method:  
  
```ruby  
# DAY 1  
100.times do  
  cake_process()  
end  
```  
  
## Ruby loops  
  
Looping is a key notion in <a href="https://en.wikipedia.org/wiki/Object-oriented_programming" target="_blank" >Object-Oriented Programming</a> languages, where creating instances according to the interface data is recurrent. In other words, looping is a feature that enables iteration through objects such as loop through array or loop through hash.  
  
Ruby-on-Rails is specially well prepared for this purpose, as it comes with a set of **helper methods** that make looping very straightforward. These methods provide the logic of iteration as an abstraction of the code, so that the code stays more readable.  
  
## The most useful looping methods in Ruby  
  
Let's analyze the syntax of the different looping options that we have in Ruby. The goal is to understand when we should use each method.  
  
### for ... in  
  
Normally, we use `for...in` when we know the exact number of times that the loop needs to be executed.  
  
For example:  
  
```ruby  
ingredients = "eggs, flour, sugar, milk"  
  
for ingredients in 0..99 do  
p "First step is mix ingredients: #{ingredients}"  
end  
#=> First step is mix ingredients: eggs, flour, sugar, milk  
#=> First step is mix ingredients: eggs, flour, sugar, milk  
#=> ...  
```  
  
Note that the action related to the variable `ingredients` will be executed 100 times as per the range (0..99) that includes both values, 0 and 99.  
  
### times  
  
We have seen this method above in the article. It is very intuitive and it can be used to execute very simple tasks (see below) or more complex ones by passing a block.  
  
```ruby  
# Simple syntax:  
5.times p "Hello"  
```  
  
### each and each_with_index  
  
The method each is used to iterate through elements, when the elements run out, the loop ends. Hence, there is no need to specify a range or a number of times for the iterations.  
  
```ruby  
ingredients.each do |ingredient|  
p "Add the #{ingredient}"  
end  
#=> Add the eggs  
#=> Add the flour  
#=> ...  
```  
  
Remember that in this example we are using arrays, but you can also [loop through hash](https://www.bootrails.com/blog/how-to-define-and-use-a-ruby-hash/#:~:text=Copy-,Iterate,-The%20most%20common) or any other object.  
  
If preferred, and if we want to keep track of the index position of the element, we can also use `each_with_index`:  
  
```ruby  
ingredients.each_with_index do |ingredient, index|  
p "#{ingredient} is the #{index + 1} in the list."  
end  
#=> eggs is the 1 in the list.  
#=> flour is the 2 in the list.  
#=> ...  
```  
  
Very similar is the `map` method; and it also allows [looping with index](https://www.bootrails.com/blog/ruby-map-with-index/).  
  
### each_with_object  
  
In Object-Oriented Programming languages, the each_with_object can be very useful. For example, if we want to **convert an array into a hash**:  
  
```ruby  
cakes = ["Brownie", "Cheesecake", "Brownie", "Brownie", "Carrotcake", "Cheesecake"]  
cakes.each_with_object(Hash.new(0)) do |element, hash|  
hash[element] += 1  
end  
  
#=> { "Brownie": 3, "Cheesecake": 2, "Carrotcake": 1 }  
```  
  
To understand the logic here, we must know that the object that we pass is a hash, in which each element represents a key with value 0. Then, every time the loop finds the element on the array, it increases the value by one.  
  
### while and until  
  
These methods are used when we want to iterate a number of times through an object but we don't know it beforehand. In this cases we always need a variable (declared before the start of the loop) and a condition:  
  
```ruby  
i = 0  
while i < 3  
p i  
i += 1  
end  
#=> 0  
#=> 1  
#=> 2  
```  
  
## Loop control  
  
Loops allow a certain level of control from inside the block. This help us avoid complexity in some cases and also makes the code more readable. Let's see an example with numbers and using the `next` and `break` keyword features:  
  
```ruby  
i = 0  
  
while i < 100  
i += 1  
if i == 10  
p "hey this is 10"  
next  
end  
p i  
if i == 20  
break  
end  
end  
```  
  
This would print the numbers from 1 to 9, then enter the if statement and print "hey this is 10" and **skip the rest of the loop** in this particular iteration because of the `next` keyword. Then the loop would resume with i=11 and continue printing numbers until 19. When i reaches 20, the if statement causes to **stop the loop** thanks to the `break`.  
  
## Conclusion  
  
Mastering loops is very important. Ruby provides powerful methods that will help you keep your code DRY, save space, write code that is easy to navigate and create efficient [Rails applications](https://bootrails.com/blog/how-to-create-tons-rails-applications/).