---
title: How to use the reduce method in Ruby
author: david
date: 2024-03-21 11:33:00 +0800
categories: [ruby]
tags: [ruby]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600%2Ch_836%2Cq_100/l_text:Karla_72_bold:How%20to%20use%20the%20reduce%20method%20in%20Ruby%2Cco_rgb:ffe4e6%2Cc_fit%2Cw_1400%2Ch_240/fl_layer_apply%2Cg_south_west%2Cx_100%2Cy_180/l_text:Karla_48:Explanation%20and%20examples%2Cco_rgb:ffe4e680%2Cc_fit%2Cw_1400/fl_layer_apply%2Cg_south_west%2Cx_100%2Cy_100/newblog/globals/bg_me.jpg
  alt: How to use the reduce method in Ruby
---
## Why we use reduce

You need the `.reduce` method when you want to transform a collection into a simple element (hence the name).

The classic example is when you want to sum up all elements of an array. You start from a collection (the array), and you end up with a number (the sum).

```ruby
(1..10).reduce { |sum, n| sum + n } # 55 
```

Thus the initial argument is "reduced".

It's not specific to Ruby, you will find this same method in many other languages.

## How to understand the reduce method

I would say that the easiest way to understand the reduce method is to avoid using shorteners. It's opinionated here, I know, but the reduce method is not so often encountered, so IMHO stick with plain old syntax helps others to read your code

```ruby
(1..10).reduce(0) do |memo, n|  
  memo + n
end
# 55
```

The use word "memo" helps a lot here. 

The initial value of memo is given as first argument of reduce.

> Remember that the result of the block is reinjected in the first argument, so it's a good idea to name it "memo"
{: .prompt-tip }


## Other ways to write a memo

I don't enjoy them much, so I put it here just as reference for later.

```ruby
(1..10).reduce(0){|memo + n| memo + n}
# 55
(1..10).reduce{|memo + n| memo + n}
# 55
```

Note that without an initial explicit value, ruby automatically sets it as zero.

```ruby
(1..10).reduce(:+) 
# 55
```

It was the shortest possibility. You can set the initial value like this :


```ruby
(1..10).reduce(0, :+) 
# 55
(1..10).reduce(1, :+) 
# 56
```

Notice in the last example, how the initial memo value affect the final result.

## Reduce examples

Often the "sum array" example is given, but let's explore some other use case, in order to better understand how `.reduce` works.

```ruby
{ 'a': 1, 'b': 2, 'c': 3 }.reduce({}) do |memo_array, (key, value)|  
  memo_array[key] = value * 3;
  memo_array
end
```

A `.map` would have been more appropriate here (since the resulting shape is the same as the first one), but maybe reading this code excerpt will help to understand how it works.

Another (extracted from <a href="https://ruby-doc.org/core-2.4.0/Enumerable.html#method-i-reduce" target="_blank">enumerable docs</a>)

```ruby
longest = %w{ cat sheep bear }.inject do |memo, word|
   memo.length > word.length ? memo : word
end
longest 
# sheep
```

## Reduce vs Inject with Ruby

There is no difference. In other words, there are aliases, you can use them indifferently

```ruby
(1..10).inject { |sum, n| sum + n } # 55 
```

```ruby
(1..10).reduce { |sum, n| sum + n } # 55 
``` 

## Summary

It was a quick review of a big classic. Remember that "reduce" is properly named, it helps to remember when to use. I hope this article helped to see "how" to use it.