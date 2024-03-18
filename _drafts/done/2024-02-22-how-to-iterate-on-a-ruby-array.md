---
title: How to iterate on a Ruby array
author: david
date: 2024-02-22 11:33:00 +0800
categories: [ruby]
tags: [ruby]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600%2Ch_836%2Cq_100/l_text:Karla_72_bold:How%20to%20iterate%20over%20a%20Ruby%20Array%2Cco_rgb:ffe4e6%2Cc_fit%2Cw_1400%2Ch_240/fl_layer_apply%2Cg_south_west%2Cx_100%2Cy_180/l_text:Karla_48:A%20Ruby%20ballad%2Cco_rgb:ffe4e680%2Cc_fit%2Cw_1400/fl_layer_apply%2Cg_south_west%2Cx_100%2Cy_100/newblog/globals/bg_me.jpg
  alt: How to iterate on a Ruby array
---

## The classic way to iterate over a Ruby array

Let's take a simple Ruby array :

```ruby
a = [11, 'foo', 42]
```

You can use the `.each` method

```ruby
a.each { |x| puts x }
# 11
# foo
# 42
```

If you are confused about the syntax, I wrote an article about [Ruby blocks, procs and lambda](https://bootrails.com/blog/ruby-block-procs-and-lambda/), so it's equivalent to the following :

```ruby
a.each do |x| 
  puts x 
end
# 11
# foo
# 42
```


## The for loop


The for loop is available in Ruby, to be honest I don't see it very often, so I put it here as reference :

```ruby
for e in a
  puts e
end
# 11
# foo
# 42
```

## each_with_index for a Ruby array

If you need to know about the index, the following syntax is available :

```ruby
a.each_with_index {|e, index| puts "#{e} => #{index}" }
# 11 => 0
# foo => 1
# 42 => 2
```

Again, this is equivalent to :

```ruby
a.each_with_index do |e, index| 
  puts "#{e} => #{index}" 
end
# 11 => 0
# foo => 1
# 42 => 2
```

## Do you want to create an array from an existing one?

You probably want the `.map` method here


```ruby
a.map {|e| e.to_s + ' z' }
# ["11 z", "foo z", "42 z"]
```

You actually iterate on the array, in order to extract an array of the same size.

Note that array "a" is left unchanged.

Lastly, I wrote an article about how to [map with index in Ruby](https://bootrails.com/blog/ruby-map-with-index/).

## Do you want to reject unwanted values?

Now it's `.reject` 
```ruby
a.reject {|e| e.is_a?(String) }
# [11, 42]
a.reject {|e| e.is_a?(Numeric) }
# ["foo"]
```


## Conclusion

Iterate over a Ruby array is quite simple, given it's a big classic in programming. Just take time to feel at ease with the block notation, it's more or less like the anonymous JS functions. If you have a specific need, also have a look at the [Enumerable module](https://ruby-doc.org/3.3.0/Enumerable.html).


