---
title: How to define and use a Ruby hash
author: david
date: 2022-06-02 11:33:00 +0800
categories: [ruby]
tags: [ruby]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: How to define and use a Ruby hash
---

## What is a hash and how is it different from an array?

Hashes, just as arrays, can be understood as lists of data that can be accessed, updated and deleted. As long as they share some similarities, its structure is different. Let's take a look into arrays first :

`["Paris", "Barcelona", 3]`

Arrays generally contain strings, integers, booleans and arrays as
values. The way to interact with arrays and its items is via the index position. In the previous array, the index for Paris is [0], the index for Barcelona is [1] and so on.

Interacting with arrays and indexes is easy but not scalable when the data gets more complex or the list of items gets longer. And here is where hashes appear to make a difference, as they substitute the index position by a key.

A key is a unique representation that is paired to a value. For example, we can build a user by creating a hash:

```ruby
user = {
  name: "Marie",
  city: "Paris",
  age: 34
}
```

In this case, the keys are "name", "city" and "age", and the values
"Marie", "Paris" and "34".

We will be analyzing the Syntax of hashes later, but for the moment we should be able to understand the similarities between arrays and hashes, and most important, its differences, which are:

-   An array index is always an integer,
-   Hashes use keys to identify values,
-   A key can be almost any object (String, Integer, Symbol, Object)

## What are the benefits of using hashes?

First of all, hashes are the best option to organize and visualize data, no matter whether the data structure is simple or complex and whether its size is large or small.

Using hashes is very common in Ruby and Rails applications and it is considered a best practice. Moreover, hashes are very easy to use and recognize.

And last but not least, hashes enable fast access to data by using keys instead of relying on the index position.

## Symbols and the hash syntax for Ruby

Because the implementation of hashes has proven very effective, its syntax has evolved in order to improve its use. We will now take a look at the different syntaxes that you might encounter when looking into existing code, the first being the "hash rocket":

```ruby
  user = {
    "name" => "Marie",
    "city" => "Paris",
    "age" => 34
  }
```

The hash rocket is very visual but not agile when it comes to writing.
Hence, the approach to convert unique keys into symbols to simplify the syntax as per below:

```ruby
user = {
  name: "Marie",
  city: "Paris",
  age: 34
}
```

Please note that you might also see symbols between brackets: `'name':`

Symbols in Ruby are defined as "scalar value objects used as identifiers, mapping immutable strings to fixed internal values." In
other words, symbols are strings that can not change, that are unique.

Symbols are preferred because they are more efficient and they use less memory than strings. In Ruby, symbols are represented with a colon before the string **:name**, however when building hashes the colon position is reversed for the sake of aesthetics (see example above).

## Nested hashes

Nested hashes, also called multidimensional hashes, are structures of hashes that contain one or more hashes inside. This allows us to organize data into different levels and build more complex and detailed associations. You will often find this type of structure when getting responses from external APIs into your application. Find an example of a weather API response below:

```ruby
forecast = {
  city: "Barcelona",
  coordinates: {
    lat: "934876",
    lon: "39705"
  },
  weather: {
    status: "cloudy",
    wind: "13 km/h",
    rain: "0%"
  }
}
```

## The 5 hash operations that you should master

After having a clear understanding of what hashes are and its use, we need to know how to interact with them. You will find a complete list of the methods that can be applied with hashes in the  <a href="https://ruby-doc.org/core-3.1.2/Hash.html" target="_blank" >Ruby Documentation</a>, which as you might suspect at this point are very similar to the <a href="https://ruby-doc.org/core-3.1.2/Array.html" target="_blank" >array's methods</a>. We will now take a look into the main operations that you should be able to
recognize and implement with hashes.

1.  **Create a hash** To create a hash you just need to follow the old or
    the new syntax as explained above in this article. Remember that the
    new syntax is easier and will save you some memory space.

2.  **Access a hash** You can access a hash and its components in several
    ways. By simply calling the hash you will receive the complete list
    of keys and values of itself. You can use the methods **.keys** and
    **.values** to access all the keys or values of a hash:


    ```ruby
    user.keys #=> ["name", "city", "age"]
    user.values #=> ["Marie", "Paris", 34]
    ```

Most importantly, you can access specific values by reaching out to their key:  `user[:name] #=> ["Marie"]`

And the same works for nested hashes: `forecast[:weather][:status] #=> ["cloudy"]`

3.  **Update** To update a hash you just need to follow the accessing logic and then proceed to add, modify or delete pairs of values and keys.

    For example:

    ```ruby
    user[:name] = "Clara" #=> Changes name value
    user[:last_name] = "White" #=> Adds pair of key and value to hash
    ```

4.  **Merge hashes** Merging two or more hashes will create a new hash containing the keys and values of all them (adding key-value pairs from left to right). There are several ways to handle key duplicates when merging that are detailed in the <a href="https://ruby-doc.org/core-3.1.2/Hash.html" target="_blank" >Ruby Documentation</a>.

    In the example below, if there were any key duplicates the last one would prevail as key values are overwritten :
    
 ```ruby
    hash1 = {name: "Pete", country: "Germany" }
    hash2 = {food: "pasta", beverage: "wate"}

    user.merge(hash1, hash2) #=> {name: "Pete", city: "Paris", age: 34, country: "Germany", food: "pasta", beverage: "wate"}
 ```

6.  **Iterate** The most common way to loop through a hash is by using the method **.each** and passing keys and values as parameters:

    ```ruby
    user.each do |key, value|
      puts "#{key} is the key and #{value} is the value."
    end


    #=> "name is the key and Maria is the value."
    #=> "city is the key and Paris is the value."
    #=> "age is the key and 34 is the value."
    ```

**Side note** A well-known method in functional programming is `map`, here is a tutorial that shows [how to map with index](https://www.bootrails.com/blog/ruby-map-with-index/) on arrays, you can try to "map with index" on a hash as an exercise.

##  Conclusion

Hashes are used a lot in Ruby and in Rails applications that use the  [MVC pattern](https://www.bootrails.com/blog/ruby-on-rails-mvc/). That is why it is worth taking a deep dive on how hashes work and how to make the most of them.