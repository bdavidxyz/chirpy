---
title: How to get a random number in Ruby
author: david
date: 2022-05-05 11:33:00 +0800
categories: [ruby]
tags: [ruby]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:How%20to%20get%20a%20random%20number%20in%20Ruby,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:A%20simple%20article%20about%20Ruby,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: How to get a random number in Ruby
---

## rand() method

Ruby's `rand` method belong to the kernel module. Which means you could use it in any Ruby's environment.

For example, if you want to emulate a dice roll, you would write :

```ruby
rand(1..6)
# => 4
rand(1..6)
# => 2
```

Note that without range, output will be from 0 to N.

```ruby
rand(6)    #=> gives a random number between 0 and 5.
```

## random_number

Another possibility is tu use `SecureRandom.random_number`.

If a positive integer is given as X, `random_number` returns an integer like this : 0 <= `random_number` < X.

```ruby
SecureRandom.random_number(2)
# => will output 0 or 1
```

```ruby
SecureRandom.random_number(100)
# => will output any  number from 0 to 99
```

Without any argument, `SecureRandom.random_number` will output a float between 0 and 1.

```ruby
irb $> SecureRandom.random_number
# => 0.25562499980914666
```

```ruby
irb $> SecureRandom.random_number
# => 0.8439818588730659
```

## The Random class

```ruby
r = Random.new
r.rand(0...42) 
# => 22
r.bytes(3) 
# => "\xBAVZ"
```

Please note that the Random class act itself as a random generator, so that you can call it directly, like this :

```ruby
Random.rand(0...42) 
# => same as rand(0...42)
```

## Random.new

As stated in this excellent <a href="https://stackoverflow.com/a/2773866/2595513" class="fw-bold" target="_blank" noopener noreferrer>StackOverflow answer</a>, 

> In most cases, the simplest is to use  `rand`  or  `Random.rand`. Creating a new random generator each time you want a random number is a  _really bad idea_. If you do this, you will get the random properties of the initial seeding algorithm which are atrocious compared to the properties of the  [random generator itself](http://en.wikipedia.org/wiki/Mersenne_twister).


That means should **not** use Random.new, excerpt for a few noticeable exceptions :

 - You use it only once in your application, for example `MyApp::Random = Random.new` and use it everywhere else,
 - You want the ability to save and resume a reproducible sequence of random numbers (easy as  `Random`  objects can marshalled)
 - You are writing a gem, and don't want a conflict with any sequence of rand/Random.rand that the main application might be using,
 - You want split reproducible sequences of random numbers (say one per Thread)