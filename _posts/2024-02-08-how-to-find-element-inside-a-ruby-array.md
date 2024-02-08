---
title: How to find an element inside a Ruby array
author: david
date: 2024-02-08 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:How%20to%20find%20an%20element%20inside%20a%20Ruby%20array,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:A%20simple%20recap,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  alt: How to find an element inside a Ruby array
---


## Use the filter or select method

Like JavaScript, you can choose to `.filter` an Array

Ruby version

```ruby
ary = ['abc', 'bzz', 'aaa']
ary.filter{|e| e.include?('a')}
# ['abc', 'aaa']
```

JS version

```javascript
let ary = ['abc', 'bzz', 'aaa']
ary.filter((e) => e.includes('a'))
// ['abc', 'aaa']
```

Pretty similar right ?


> Side note : When manipulating String, I find the `.include?` (Ruby) and `.includes` (JS) methods are very confusing. I have a special tip to share here 😬 outside relying on IDE auto-completion.
{: .prompt-tip }


Note that `.select` and `.filter` are the same, it's actually an alias - in Ruby! But not in JS.

So both following method are the same :

```ruby
ary = ['abc', 'bzz', 'aaa']
ary.filter{|e| e.include?('a')}
# ["abc", "aaa"]
ary.select{|e| e.include?('a')}
# ["abc", "aaa"]
```

Example above emphasises that both are immutable : the `ary` variable didn't change between consecutives calls.



## Use the include? method

Remember the `.include?` method about String just above ?

Well, it also works with an Array :

```ruby
ary = ['abc', 'bzz', 'aaa']
ary.include?('aaa')
# true
ary.include?(42)
# false
```

Note that the intent is not the same as the paragraph above, so it just depends on what you're looking for.

## How to find the last element inside a Ruby array

"Last" you said ? Well, use the `.last` method

```ruby
ary = ['abc', 'bzz', 'aaa']
ary.last
# 'aaa'
```

> You cannot pass a block to the `.last` method (it would be ignored anyway)
{: .prompt-warning }

## How to find the first element inside a Ruby array

Well, if you're just looking for the first element, `.first` is just here

```ruby
ary = ['abc', 'bzz', 'aaa']
ary.first
# 'abc'
```

> You cannot pass a block to the `.first` method (again)
{: .prompt-warning }


If you want to find the first element to match a given condition, use `.find`

## Find first matching element

`.find` allows you to pass a condition, and will return the first element that matches that condition


```ruby
ary = ['abc', 'bzz', 'aaa']
ary.find{|e| e.include?('z')}
# 'bzz'
```


## How to find the nth matching element

Something I didn't retrieve trivially is the way to find the nth element to match a given condition.

First and last are easy. First match is easy.

But what about the nth match ?

```ruby
ary = ['abc', 'bzz', 'aaa']

# Retrive 2nd element with 'a' char
ary.select{|e| e.include?('a')}[1]
# => 'aaa'

# Retrieve 3rd element with 'a' char
ary.select{|e| e.include?('a')}[2]
# => nil
```

I let you guess how to write a generic function about this - it's a little bit over-engineering in my humble opinion :

```ruby
def nth(array, condition, position)
  # ...
end
```

## Retrieve the index of a given element inside a Ruby array

Use the index method like this :

```ruby
ary = ['abc', 'bzz', 'aaa']
ary.index 'aaa'
# => 2
```

Note that parenthesis are optional in Ruby when calling a method.

## Use of find_index in Ruby arrays

`.find_index` will retrieve the first element that matches the given condition :

```ruby
ary = ['abc', 'bzz', 'aaa']
ary.find_index{|e| e.include?('z')}
# => 1
```

## Summary

I wrote this article because I was wondering how to find the nth element that matches a given condition in a Ruby array. It was a good excuse to sum up how to retrieve things inside a Ruby array.