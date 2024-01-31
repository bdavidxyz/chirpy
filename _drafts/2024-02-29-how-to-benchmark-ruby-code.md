---
title: How to benchmark Ruby code
author: david
date: 2024-02-29 11:33:00 +0800
categories: [ruby]
tags: [ruby]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600%2Ch_836%2Cq_100/l_text:Karla_72_bold:How%20to%20benchmark%20Ruby%20code%2Cco_rgb:ffe4e6%2Cc_fit%2Cw_1400%2Ch_240/fl_layer_apply%2Cg_south_west%2Cx_100%2Cy_180/l_text:Karla_48:Three%20attempts%2Cco_rgb:ffe4e680%2Cc_fit%2Cw_1400/fl_layer_apply%2Cg_south_west%2Cx_100%2Cy_100/newblog/globals/bg_me.jpg
  alt: How to benchmark Ruby code
---

## What is benchmarking?

Benchmarking is the measure of performance of a piece of code. I personally find this area a little controversial. since something more readable, but that doesn't perform as well as a less performant piece of code.

But after playing with some Ruby methods, here are 3 ways that I tried to see if one way to solve a problem performs better than another.

## Let's try a Ruby way to...

Today I'm going to try a while loop in Ruby. There are multiple available syntax, so I'm going to try 2 of them.

It will be mostly an example-based article. By googling around, I found 3 ways to benchmark a while loop. Let's go.


## First, Benchmark.realtime


```ruby
require 'benchmark'

time = Benchmark.realtime do
  x = 1
  loop do
    x += 1
    break if x > 100
  end
end
puts "loop took #{time} seconds."

time = Benchmark.realtime do
  x = 1
  while true
    x += 1
    break if x > 100
  end
end
puts "while took #{time} seconds."
```

Will result in:

```shell
loop took 8.14200029708445e-06 seconds.
while took 1.203499959956389e-05 seconds.
```

Ok, not super-readable report, but it seems that loop performs better.

## Second, Benchmark.bm

```ruby
require 'benchmark'

Benchmark.bm do |benchmark|
  benchmark.report("loop.") do
    x = 1
    loop do
      x += 1
      break if x > 100
    end
  end
 
  benchmark.report("while") do
    x = 1
    while true
      x += 1
      break if x > 100
    end
  end
end
```

Gives following results:

```shell
       user     system      total        real
loop.  0.000020   0.000006   0.000026 (  0.000022)
while  0.000003   0.000001   0.000004 (  0.000003)
```

"real" column gives the total time spent.

Yikes! It seems that now that the `while` version performs better.

Let's try once again with the same method.

```shell
       user     system      total        real
loop.  0.000014   0.000002   0.000016 (  0.000011)
while  0.000004   0.000000   0.000004 (  0.000004)
```

Ok it seems that 2 consecutive launch gives very different result. At least this time, the same method performs better.

## Third, Benchmark.measure

```ruby
require 'benchmark'

puts Benchmark.measure {
  50_000.times do
    x = 1
    loop do
      x += 1
      break if x > 100
    end
  end
}

puts Benchmark.measure {
  50_000.times do
    x = 1
    while true
      x += 1
      break if x > 100
    end
  end
}

```

It gives the following results :

```shell
  0.261000   0.003973   0.264973 (  0.266082)
  0.083610   0.000001   0.083611 (  0.083994)
```

The first line is the result about the `.loop` method, and the second one about the `.while` method.

The result between parenthesis is the aggregate (full time to compute the operation).

`.while` seems to be better here.

## Summary

We have seen 3 ways to measure performance of a Ruby method, however, it's hard to conclude about anything, since I had different results here. I need to investigate, in order to be sure about what is going on.