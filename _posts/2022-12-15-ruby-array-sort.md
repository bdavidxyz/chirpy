---
title: Sort a Ruby array
author: david
date: 2022-12-15 11:33:00 +0800
categories: [ruby]
tags: [ruby]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:Sort%20a%20Ruby%20array,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:A%20simple%20article%20about%20Ruby,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Sort a Ruby array
---

## Nature of arrays

As we have seen in other blog entries, [arrays and hashes are basic concepts in any programming language](https://bootrails.com/blog/how-to-define-and-use-a-ruby-hash/). It is the best way to encapsulate and organize data. Arrays, specifically, are containers of a list of elements that can be of any nature (strings, arrays, hashes, integers, booleans, etc.).

```ruby
my_array = ['a', false, 'z', 'l', 0, -99, 9.8, nil]
```

## Sorting arrays: the Ruby case

Having cleared the concept of arrays, one may suppose how important it can be to interact with them and organize them according to one's needs. Ruby has a special method for this purpose, which is `.sort`. As well, as a "child method" called `.sort_by` that is used to customize the sorting strategy.

## Method: sort

The sort method in ruby sorts any array by comparing each element to another and following ascending logic. In other words, from `a to z` and `-999 to 999`.

```ruby
my_string_array = ['a', 'z', 'l']
p my_string_array
p my_string_array.sort
# => ["a", "z", "l"]
# => ["a", "l", "z"]

my_number_array = [9, 87, -100, 0]
p my_number_array
p my_number_array.sort
# => [9, 87, -100, 0]
# => [-100, 0, 9, 87]
```

Note that you can not sort arrays containing elements of different nature, such as strings and integers.

## sort!

The difference between `.sort` and `.sort!` is that the first one returns "a copy" of the original array sorted, while the second method modifies the order of the original array following the sorted logic. For example:

```ruby
original_array = ["e", "b", "c", "a", "d"]

new_array = original_array.sort
p new_array
# => ["a", "b", "c", "d", "e"]

p original_array
# => ["e", "b", "c", "a", "d"]

original_array.sort!
p original_array
# => ["a", "b", "c", "d", "e"]
```

## Method: sort_by

This method allows you to sort the data of an array according to specific requirements. We have seen [similar behaviour in the group_by method article](https://bootrails.com/blog/ruby-group-by-or-rails-group-by/). The condition to sort the array is passed as a block to the method as per below:

```ruby
fruits = ["strawberry", "banana", "orange", "apple", "melon"]
p fruits.sort
# => ["apple", "banana", "melon", "orange", "strawberry"]

fruits_sorted_by_last_letter = fruits.sort_by { |word| word[-1] }
p fruits_sorted_by_last_letter
# => ["banana", "orange", "apple", "melon", "strawberry"]
```

## Conclusion

We have gone through the most common and easy ways of filtering arrays. However, it is also possible to build the sorting methods by ourselves when we need to customize the filtering. This is going to make our code more complex and might trigger mistakes. However, if you need such customization or if you want to understand the logic behind the built-in methods, <a href="https://akashkinwad.medium.com/how-to-sort-an-array-without-using-sort-method-in-ruby-8cd733acbd8d" target="_blank" >there are a lot of examples out there</a>!

Being able to filter arrays is very useful, especially if we want to organize the data of an application so that users can have optimal interaction.