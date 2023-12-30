---
title: "Ruby private method , a hack"
author: david
date: 2021-04-13 11:33:00 +0800
categories: [ruby]
tags: [ruby]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: "Ruby private method , a hack"
---

## How to declare a private method

```
class Wolf

  def scare
    "scaring..."
  end
  
  private
  
  def sleep
    "sleeping.."
  end
  
  def eat
  "eating.."
  end
  
end
```

All methods above the keyword "private" is considered as public, all methods below are considered as private.

Note that "private" here is not a keyword, but a method of the Kernel module.

## What is a private method in Ruby

A private method cannot be called from the outside. Let's use a wolf in the IRB console. To use our Wolf above, simply copy/paste the class in the console (console will kindly accept carriage return)

```shell
$irb(main)> w = Wolf.new
=> #<Wolf:0x00007fee2c760440>

$irb(main)> w.scare
=> "scaring..."

$irb(main)> w.sleep
Traceback (most recent call last):
        1: from (irb):38:in `<main>'
NoMethodError (private method `sleep' called for #<Wolf:0x00007fee2c760440>)
```

Now you got the idea. An object can decide to hide its internal behaviour, to ensure consistency. If you don't know what it this about, you can read about [encapsulation](https://en.wikipedia.org/wiki/Encapsulation_%28computer_programming%29), or read this [in-depth article](https://www.rubyguides.com/2018/10/method-visibility/) about method visibility in Ruby.

## Private methods in Ruby : the annoying parts

Why to hack a well-known OOP principle ? Because I find this privacy annoying. There are some corner cases :

 - You want just one other class to access the private method (but no other classes).
 - You want to test a private method because the regular way (test a private method through available public methods) do not work.
 - You have to think about hierarchy, and how "protected" method are handled, and if this hierarchy suits your needs.

Ruby is nice enough to avoid this mental headache : you can use the .send method to bypass the privacy rule.

```
$irb(main)> w.send('sleep')
=> "sleeping.."
```

But why to loose so much energy... One time to define what is private or not, and another one to be sure we can go around the limitation.

## Do we need this privacy anyway ?

Maybe yes. I'm thinking about Open-Source projects. Maintainers don't want the final user to manipulate private things, and break the internal behaviour (and raise some issue on Github...) about the Ruby gem. OOP is there for a reason.

But for your business, daily app, I think it's a burden.  Often these applications are already private anyway. Think about a Rails app : no one can see your code. The /public folder is meant for frontend assets, not your codebase. 

Thus I go around the "private" keyword by using an underscore as a suffix. Our wolf would now look like this :

```
class Wolf

  def scare
    "scaring..."
  end
  
  def _sleep
    "sleeping.."
  end
  
  def _eat
  "eating.."
  end
  
end
```

Each time I encounter an underscore, I know it means "hey be aware this is something fragile, in theory only the class, or fellow class, or test, may use it".

It was not invented here of course. As far as I can remember, Frameworks like VueJS use a double-underscore as a suffix, and I've seen this convention in other projects.

## Private methods in Ruby recursive function

There one last use case for this kind of privacy : private arguments.

Let's say I have a recursive function, and I have to track the number of time the function is called to avoid an infinite loop :

```ruby
def countdown(n, _number_of_calls = 0)
  if n < 1
    return
  elsif  _number_of_calls > 5
    puts 'too much calls, exiting'
    return
  else
    puts n
  end
  countdown(n-1, _number_of_calls + 1)
end  
```

Notice the _number_of_calls is not part of the public parameters :
```
$irb(main)> countdown(2)
2
1
=> nil
```

And if I exceed the number of call, I exit the recursion :

```
$irb(main)> countdown(10)
10
9
8
7
6
5
too much calls, exiting
=> nil
```

## Conclusion

private methods are necessary, it's a basic thing in OOP languages. However for your business app there is a nice shortener : the underscore - or any other convention you prefer.