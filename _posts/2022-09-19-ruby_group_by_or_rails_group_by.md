---
title: Ruby group_by or Rails group_by
author: david
date: 2022-09-19 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Ruby group_by or Rails group_by
---

## What is the group_by method in Ruby?

The `.group_by` method is included in Ruby's <a href="https://ruby-doc.org/core-3.1.2/Enumerable.html" target="_blank">Enumerable module</a>. 
We have already written about the [Enumerable module](https://bootrails.com/blog/ruby-enumerable-module/) and [Enumerators](https://bootrails.com/blog/ruby-enumerator-what-why-how/) in previous blog entries. 
This is because of the importance of these concepts, as they are key to interacting with data: iterating through collections of elements, searching, fetching and sorting, among other features.

## group_by: The definition

As per Ruby's Documentation, the group_by method sorts a collection of data according to a condition passed as a block.

```ruby
group_by{|element|...} -> hash
```

Here, being the block: `{|element|...}`.

## Important aspects

- When using group_by with a block, the result is a **hash**. The hash is built of keys and values:
1. **Keys**: Are returned values of the block
2. **Values**: In the form of an **array**, which represents the matching elements of the collection for each key
- When using group_by without a block, the result is an [Enumerator](https://bootrails.com/blog/ruby-enumerator-what-why-how/#:~:text=Copy-,Enumerator,-%3A%20A%20class%20that).

In other words, when using this method we always need a **collection of objects** (data) and a **grouping rule** (block).

One of the basic examples to understand the logic of group_by is grouping a set of strings by its first letter:

```ruby
%w(apple apricot banana orange avocado beetroot).group_by { |element| element[0]}
# => return:
{
  a: ["apple", "apricot", "avocado"],
  b: ["banana", "beetroot"]
  o: ["orange"]
}
```

In this example, we can clearly identify the different aspects explained above:
**The collection of objects**: the array `%w(apple apricot banana orange avocado beetroot)`
**The grouping rule**: the block, which iterates through the elements of the array and fetches the first letter of each element
**The hash**: the result of the method, containing the keys (different starting letters in the collection) and values (elements of the collection that start with each key)

## Using group_by on a Hash

When creating applications and user interfaces with Ruby-on-Rails we use object-oriented-programming language, which means we <a href="https://www.rubyguides.com/ruby-tutorial/object-oriented-programming/#:~:text=What%20Is%20Object%2DOriented%20Programming%3F" target="_blank" >build the application based on objects</a>. This is why it is very practical to be able to apply the group_by method on hashes.

For example, if we have an application with different user status (active and inactive):

```ruby
user_status = {
  mary: "active",
  peter: "inactive",
  rose: "active",
  hans: "active",
  cristian: "active",
  claire: "inactive"
}
```

We can group them as per below, using a multiple line block:

```ruby
user_status_grouped = user_status.group_by do |user, status|
  status = "active" ? :is_active : :is_inactive
end

# => return:
{
  is_active: [
    ["mary", "active"],
    ["rose", "active"],
    ["hans", "active"],
    ["cristian", "active"]
  ],
  is_inactive: [
    ["peter", "inactive"],
    ["claire", "inactive"]
  ]
}
```

This kind of hash (object) is very useful because it is a fast way of organizing data and then accessing it by key. For example, if we want to get all inactive users:

```ruby
user_status_grouped["is_inactive"]

# => [["peter", "inactive"],["claire", "inactive"]]
```

We can combine other methods in order to treat the resulting array as per our needs. In this case, we can use the methods `flatten` and `delete :

```ruby
inactive_users = user_status_grouped.flatten.delete("inactive")

# => ["peter", "claire"]
```

The method **flatten** transforms the multiple-dimension array into a one-dimension array. And the **delete** is used to simplify the data and collect only the user names of those users who are inactive.

## Practical example: Rails Application

When working with real applications, it is especially useful to perform the above exercise with **user ids** instead of names. This is because user ids are unique values linked to each user (object) and it is best practice to rely on them. Also, with the ids, it is easier to use objects as inactive_users to iterate through other objects and match the users.

Let's see an example and imagine inactive_users is now containing Peter's and Claire's ids (123 and 321 respectively):

```ruby
p inactive_users
# => [123, 321]
```

Also, we have an object (hash) called `last_connection`  which contains the last time a user was connected to the application:

```ruby
p last_connection
# =>  
{
  111: ["22-04-19 12:00:11"],
  123: ["20-11-02 13:00:17"],
  233: ["22-06-18 18:33:23"],
  321: ["21-04-25 09:10:00"],
  ...
}
```

Now we can [loop through the inactive users](https://bootrails.com/blog/ruby-loops-overview/) and fetch the last connection date and time stamps for each inactive user (user id):

```ruby
inactive_last_connection = []

inactive_users.each do |user|
  inactive_last_connection << [user, "#{last_connection[user]}"]
end

p inactive_last_connection

# => [[123, "20-11-02 13:00:17"], [321, "21-04-25 09:10:00"]
```

## GROUP BY with Active Record from Rails

As stated in this <a href="https://stackoverflow.com/a/31881463/2595513" target="_blank">StackOverflow answer</a>, if you want to trigger a GROUP BY sql statement thanks to Active Record, you take inspiration from this example :

```ruby
Person.group(:name).count
(1.2ms)  SELECT COUNT(*) AS count_all, name AS name FROM "people" GROUP BY "people"."name"
=> {"Dan"=>3, "Dave"=>2, "Vic"=>1} 
```


## Conclusion

There are 3 main conclusions that can be extracted from this analysis:

1. The Enumerable Module is very powerful and it is important to master its methods, such as group_by.
2. In object-oriented-programming languages, it is key to have different ways to structure and manipulate data as efficiently as possible.
3. The above aspects are very important when building applications. The goal is to save memory space and guarantee speed and performance.