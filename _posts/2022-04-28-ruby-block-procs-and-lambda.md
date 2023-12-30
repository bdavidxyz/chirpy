---
title: "Ruby block, procs and lambda"
author: david
date: 2022-04-28 11:33:00 +0800
categories: [ruby]
tags: [ruby]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: "Ruby block, procs and lambda"
---

## Why the need for anonymous functions ?

Ruby is a language that uses multiple programming paradigms, most commonly object-oriented and functional, and with its functional nature comes the idea of functions. Ruby uses three  types of *closures* : blocks, procs, and lambdas.

<section class="landing-badge">
  If you want to see when such anonymous functions are used, see an example here : 
  <div> 
    <a href="/blog/ruby-map-with-index/">How to map with index with Rails</a>
  </div>
</section>

## Ruby blocks : why ?

Ruby blocks are little anonymous functions that can be passed into methods. They are enclosed in a do / end statement (often when the block have multiple lines) or between brackets `{}` (if the block is a one-liner), and they may have multiple arguments. 

There are a few important things about blocks in Ruby:

- Block can accept arguments and returns a value.
- Block does not have its own name.
- Block is made up of pieces of code.
- A block is always called with a function or can be passed to a method call. 
- To call a block in a method with a value, the yield statement is used.
- Blocks can be called as methods from within the method they are passed to.

## How to define a Ruby block

Here we have defined the block_method method. Below is a method call after which we pass a block. Can you guess the output ?

```ruby
def say_something
 puts "we are in a method"
end
say_something { "The block is called" }
```

Yes. "We are in a method". The last line is a call to the `say_something` method.

But we never told `say_something` to read the block.

## How to render a block with Ruby

What's really going on in the code below?

```ruby
def say_hey
  puts "I am inside the method"
  yield
  puts "I am ending the method"
end
say_hey { puts "This is inside the block" }
```

This time, if you call the say_hey method (without any argument, like the last line does), the following will be printed : 

```ruby
# => "I am inside the method"
# => "This is inside the block"
# => "I am ending the method"
```

We first created a method called `say_hey`. Then on the next line we print the string "I am inside the method". In the next line, notice that we have used the `yield` keyword which will find and invoke the block the method was called with.

> Calling `yield` inside a method will invoke the block passed as argument when this method was called

Somehow the execution flow could be trivially interpreted like this : 

1) The `say_hey` method execute normally.
2) `yield` will execute the block code (always think "anonymous function" if you are lost) passed when called. The regular execution flow is somehow "paused" to execute this anonymous function.
3) Once the block has finished, then method body execution continues.


## How to pass parameters to a block

What if you want to pass parameters to yield ? Think about how you pass arguments to methods, like each time you give it a block.

```ruby
[1, 2, 3].each {|x| puts x*2 }
# => 2
# => 4
# => 6
```

In this case, the `.each` method takes a block that has one argument.

How about doing this with our defined block ? And  let's see how `yield` takes the arguments.

```ruby
def say_also
  yield 2
  yield 3
end
say_also {|e| puts "e is #{e}"}
# => e is 2
# => e is 3
```

Here, `yield` will invoke the block passed with the method call. 

In our case, give an argument to the block since the block takes a parameter.

The first round will invoke the block with parameter 2. The control resumes the method, then it will call the block again this time with parameter 3.

### Blocks : what if the calling function also have arguments ?

Let's see an example :

```ruby
def say_again(a, b)
  puts "a is #{a}"
  yield 2
  puts "b is #{b}"
  yield 3
end
say_again("foo", "bar") {|e| puts "e is #{e}"}
# => a is foo
# => e is 2
# => b is bar
# => e is 3
```

From what we have seen above, there should be no surprise here


## What are Procs ?

What if you want to pass two blocks to your function ? How can you save your block in a variable?

Ruby introduces procs so that we can pass blocks. Proc objects are blocks of code that have been bound to a set of local variables. Once bound, the code can be called in different contexts and still access those variables.

### How to define Procs

You can call new on the `Proc` class to create a `proc`. You can use the `proc` kernel object. The `proc` method is simply an alias for `Proc.new`. This can be assigned in a variable. And called with the `.call` method.

Let's see an example :

```ruby
my_proc = Proc.new {|name| puts "Hello #{name}" }
def hello_world(named_proc)
  named_proc.call('Jane')
end
hello_world(my_proc)
# => Hello Jane
```

## What are Lambdas ?


With Ruby, the `lambda` keyword is used to create a lambda function. It requires a block and *can set zero or more parameters*.  You call the resulting lambda function using the call method.

Examples :

```ruby
lamb_one = lambda {|n| "Lambda one was called with #{n}"}
lamb_two = -> (n) { puts "Lambda two with #{n}" }
lamb_one.call("foo")
lamb_two.call("bar")
# => Lambda one was called with foo
# => Lambda two with bar
```

## What are the differences between Procs and Lambdas :

 - Procs don't care about the correct number of arguments, while lambdas will throw an exception.
 - `return` and `break` behave differently in procs and lambdas. Lambdas will not interrupt the flow, even if `return` or `break` is encountered. 
 - `next` behaves the same in Procs and Lambdas.

|  | Block | Proc | Lambda |
|--|--|--|--|
| Class | Proc | Proc | Proc |
| Will stop execution flow | N/A | Yes | No |
| May be assigned to variable | No | Yes | Yes |
| Is number of args important? | No | No | Yes |


## Key takeaways

Now that we've covered the two blocks, procs and lambdas, let's step back and summarize the comparison.

 - Blocks are widely used in Ruby to pass bits of code to functions. By using the yield keyword, a block can be passed implicitly without having to convert it to proc.
 
 - When using parameters preceded by ampersands, passing a block to a method results in a proc in the context of the method. Procs behave like blocks, but they can be stored in a variable.
 
 - Lambdas are procs that behave like methods, meaning they enforce arity and return as methods rather than in their parent scope.