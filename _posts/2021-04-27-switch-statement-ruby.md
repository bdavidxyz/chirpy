---
title: How to write a switch statement in Ruby
redirect_to: https://alsohelp.com/blog/switch-case-statement-ruby
author: david
date: 2021-04-27 11:33:00 +0800
categories: [ruby]
tags: [ruby]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:How%20to%20write%20a%20switch%20statement%20in%20Ruby,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:A%20simple%20article%20about%20Ruby,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: How to write a switch statement in Ruby
---

## So how do you *switch* to case/when ?

Case statements in Ruby are very powerful. To quote the popular  ProgrammingRuby book, "The Ruby case expression is a powerful beast: a multiway if on steroids."

Let's begin by converting a small-sized if expression into a `case/when` statement. The following `if` expression

```ruby
if name == "Peter Parker"
  hero_name = "Spiderman"
elsif name == "Bruce Wayne"
  hero_name = "Batman"
else
  hero_name = "unknown"
end
```

will look like this

```ruby
case name
when "Peter Parker"
  hero_name = "Spiderman"
when name == "Bruce Wayne"
  hero_name = "Batman"
else
  hero_name = "unknown"
end
```

## Important keywords 

There are 3 important keywords that are used in the case statement:

 - `case` : It is similar to the switch keyword in other programming languages. It takes the variables that will be used by when keyword.

 - `when` : It is similar to the case keyword in other programming languages. It is used to match a single condition. There can be multiple when statements into a single case statement.

 - `else` : It is similar to the default keyword in other programming languages. It is optional and will execute when nothing matches.

`case` operates by comparing the target (the expression after the keyword case) with each of the comparison expressions after the `when` keywords. This test is done using comparison `===` target.

The key differences to note are that you no longer need to write the comparison operator or the `then` keyword. If you have any background with another programming language then you may have also noticed that with Ruby **you don't need to end every individual case with a break clause**.

## Indentation of the case/when statement in Ruby

There is no official standard about this, however developers tend  to put the `when` keyword on the same column as `case`  (source : [stackoverflow](https://stackoverflow.com/questions/17707373/ruby-is-there-a-right-way-to-indent-a-case-statement)) :

```ruby
case bar
when 4 then ...
when 2 then ...
else ...
end
```

Which is quite logical : think about the `if/elsif` indentation.

## Case/When in Ruby : Advanced used... cases

Now it’s time to see more advanced use cases of the case expression. Inside your `when` clauses, you can do much more than single value comparisons. With `case` you can compare ranges, classes, regular expressions, multiple values, and much more. The following is a comprehensive example of the many ways you can use a case statement :


```ruby
def switch_me(something)
  case something
  when /^1/ 
    "param starts with one" # return keyword is optional
  when 80..90
    "B+"
  when 50 then "param is 50" #then keyword allows return on same line
  when 10, 20
    "param is either 10 or 20"
  when String
    "You passed a String"
  end
end
```

In your Ruby console :

```shell
$> switch_me("111")
=> "param starts with one"

$> switch_me(82)
=> "B+"

$> switch_me(50)
=> "param is 50"

$> switch_me(10)
=> "param is either 10 or 20"

$> switch_me("20")
=> "You passed a String"

$> switch_me(42)
=> nil
```

Let's walk through each individual case:

 - The first when clause compares if var matches the regular expression like so `/^1/ === something`. As you can see, the comparison comes before the target of comparison.

 - In the second when clause var will be compared to the range 80..90.
  
 - In the third when clause we have done a simple comparison but instead of putting our return expression on the next line we have shortened it by using the then keyword.

 - In the fourth when clause there are multiple conditions. Each of these conditions will be checked sequentially. So first `10 === var and then 20 === var`.

And finally, in our last when clause we check if the first param is a String object. You may have noticed that there is a puts keyword before the `case` statement. This is possible because as with if, case returns the value of the last expression executed so it can be input to a method call.

Another interesting way is to use the case statement like an if-else statement. You cannot give a value to `case` if using it like this :

```ruby
def case_like_ifelse(param1)
  case
  when param1 == 1, param1 == 2
    "param1 is one or two"
  when param1 == 3
    "param1 is three"
  else
    "unknown"
  end
end
```

In your Ruby console :

```shell
$> case_like_ifelse(1)
=> "param1 is one or two"

$> case_like_ifelse(3)
=> "param1 is three"

$> case_like_ifelse(3)
=> "unknown"
```

Now you’re all set to write complex switch control expressions in Ruby!