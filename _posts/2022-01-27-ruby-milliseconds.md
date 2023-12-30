---
title: "Milliseconds in Ruby"
author: david
date: 2022-01-27 11:33:00 +0800
categories: [ruby]
tags: [ruby]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: "Milliseconds in Ruby"
---

## 1. Display time, down to milliseconds in Ruby

```ruby
current_time = Time.now
current_time.strftime('%H:%M:%S.%L')
# => "10:52:07.119"
```

If you want more info about `strftime`, please read this article : [https://www.bootrails.com/blog/ruby-strftime-short-and-long-story/](https://www.bootrails.com/blog/ruby-strftime-short-and-long-story/) - milliseconds, however, were not covered at this time :)

## 2. Get current time system in milliseconds 

First possibility is to use `.strftime`, again :

```ruby
current_time = Time.now
current_time.strftime('%s%L')
# => "1643017927119"
```

Please note the result is a String.

The second possibility is the following :

```ruby
(current_time.to_f * 1000).to_i
# => 1643017927119
```

The result is a number.

## 3. Elapsed time in milliseconds in Ruby

### Ruby-on-Rails method

If you are in the Rails environment, the `.in_milliseconds` method already exists.

```ruby
# Assuming Rails is loaded
time_a = Time.now
sleep(2)
time_b = Time.now
# Just call .in_milliseconds method
(time_b - time_a).in_milliseconds
# => 2016.464
```

### Pure Ruby solution

If you just want the number of milliseconds elapsed since Epoch, type

```ruby
DateTime.now.strftime("%Q")
# => "1643018771523"
DateTime.now.strftime("%Q").to_i
# => 1643018771523
```

But if you need a difference between two time, you will have to write your own method :

```ruby
def time_difference_in_milliseconds(start, finish)
   (finish - start) * 1000.0
end
time_a = Time.now
sleep(2)
time_b = Time.now

elapsed_time = time_difference_in_milliseconds(time_a, time_b)
# => 2020.874
```

If you don't mind about Monkey Patching, here is another possibility :

```ruby
class Time
  def to_ms
    (self.to_f * 1000.0).to_i
  end
end

time_a = Time.now
sleep(2)
time_b = Time.now
elapsed_time = time_b.to_ms - time_a.to_ms  
# => 2028

```
##  A word of caution


We found an interesting article [here](https://blog.dnsimple.com/2018/03/elapsed-time-with-ruby-the-right-way/) about Ruby's lack of precision with the clock. Whereas we do not very often need a high precision in the web industry, it's always good to know.

Enjoy !