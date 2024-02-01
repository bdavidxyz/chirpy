---
title: How to check if hash has key in Ruby
author: david
date: 2024-02-01 11:33:00 +0800
categories: [ruby]
tags: [ruby]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:How%20to%20check%20if%20hash%20has%20key%20in%20Ruby,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:A%20simple%20answer,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  alt: How to check if hash has key in Ruby
---

With Ruby, there are some cases where you want to check if a given key is already in the hash.

If you're new to hashes, I wrote a [basic blog article about Ruby hashes](https://bootrails.com/blog/how-to-define-and-use-a-ruby-hash/).

## Is checking the key of a hash already exists in the Ruby API ?

What if you want to check that a given hash has a given key ? Before writing any code, the first thing you should think about is "does this already exist somewhere in the API" ?

It's very uncommon that a utility function is missing - excerpt may be for JavaScript, for historical reasons.

But not for Ruby, even more in a Ruby-on-Rails environment.

## Ruby core : a one-liner way to check if key exists

For those who already know Ruby, here is the quick answer

```ruby
$> my_hash.key?("my_key")
```

## Ruby : Check presence of key by casting to a boolean

Start the Ruby console (in a Rails project, enter "bin/rails console").

```ruby
$> my_hash = {'a' => 40, a: 41, b: 'some_value'}
```

Note by the way that the String `'a'` is considered as a different key than symbol `a:`

I want to check that the key belongs to my_hash, so a naive approach would be to use the double `!!` that will convert any value to a boolean. It's a trick used in other languages like JavaScript.

```shell
$> my_hash[:b]
'some_value'
$> my_hash[:c]
nil
$> !!my_hash[:b]
false
$> !!my_hash[:c]
true
```

## A more expressive way to check presence of a specific key of a Ruby hash

The Ruby hash has an expressive API for the most common use cases. You can use the .key? method instead of the !! seen above.

It's a lot more readable for other developers.

Examples :

```ruby
$> my_hash[:b]
'some_value'
$> my_hash[:c]
nil
$> my_hash.key?[:b]
false
$> my_hash.key?[:c]
true
```

## Ruby-on-Rails : check if hash has key

You can use the `.has_key?` as well. I prefer this solution because it makes the intent a lot clearer. Since you expect a boolean, starting the method by is_ or has_/have_ is better.

```ruby
$> my_hash[:b]
'some_value'
$> my_hash[:c]
nil
$> my_hash.has_key?[:b]
false
$> my_hash.has_key?[:c]
true
```

## The most robust possible answer

So now what if you're not quite sure about the hash you're checking.

Case one :  You're not sure if the keys are symbols or not - think about a hash that is extracted from a remote API.

```ruby
$> my_hash.deep_symbolize_keys.try(:key?, :a)
true
```

Case two : you're not sure if it is actually a hash (could be nil or a wrong type)

```ruby
$> my_hash.try(:key?, :a)
true
```

Note that this could be considered as over-engineering, depending on the context.

## Conclusion

Checking if a hash has a key in Ruby is pretty straightforward, all you need is to pay a little attention in which context you're writing this verification.

See also this <a href="https://stackoverflow.com/questions/4528506/how-to-check-if-a-specific-key-is-present-in-a-hash-or-not" target="_blank">SO question</a>.