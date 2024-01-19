---
title: Ruby, The 'unless' keyword
author: david
date: 2021-06-18 11:33:00 +0800
categories: [ruby]
tags: [ruby]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:Ruby%20%20The%20'unless'%20keyword,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:A%20simple%20article%20about%20Ruby,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Ruby, The 'unless' keyword
---

## Unless you already know...  
  
When we use an `if` statement we want to check whether a condition is true or not. If it is true, you execute a block of code. If it is false, the code does not get executed. Simply put `if` checks for a truthy value. Like many other languages.  
  
You can think of `unless` as the exact opposite of this. `unless` can replace the `if` keyword but it will check for a falsy value and execute the code if the condition it is checking is false.  
Syntactically this is shown below:  
  
```ruby  
puts "Passed" if score > 50  
```  
```ruby  
if score > 50  
  puts "Passed"  
end  
```  
  
Becomes  
  
```ruby  
puts "Passed" unless score < 50  
  
unless score < 50  
  puts "Passed"  
end  
```  
  
As you can see the only difference is that you now need to change the condition. So `unless` is just the exact opposite of `if`.  
  
You might be wondering why Ruby gives you a keyword for this specifically. Well writing your control flow this way will improve the visual appeal of the code as you will no longer need to flip your conditions around using the `not` operator in more complex conditions.  
  
Samples:  
  
```ruby  
# okay, understandable, but your eye may miss the "!"  
do_something if !some_condition  
  
# okay, readable, understandable, but "not" is not always liked by Ruby developers  
do_something if not some_condition  
  
# okay, readable, understandable  
do_something unless some_condition  
```  
  
## As a modifier  
  
You may have noticed in the last example that `unless` can also be used as a modifier similar to `if`.  
  
In this sample:  
  
```ruby  
unless score < 50  
  puts "Passed"  
end  
```  
  
Becomes  
  
```ruby  
puts "Passed" unless score < 50  
```  
  
The left-hand side behaves as a then condition (code that will be executed) and the right-hand side behaves as a test condition.  
  
## Notes  
  
Even though it is completely possible to use `else` in the `unless` statement it is suggested in best practices that you should avoid doing this and prefer to use the `if` keyword when you need to have an else condition. This is because using `else` with `unless` can create confusing control flows to read. For example:  
  
```ruby  
# works, but not advised  
unless passed?  
  puts 'failed'  
else  
  puts 'passed'  
end  
```  
  
## Personal thoughts  
  
At the beginning, `unless` is clearly counter-intuitive. It took me some time before to use it daily without additional headaches. This keyword however is a good example of what Ruby is trying to achieve : increase readability.