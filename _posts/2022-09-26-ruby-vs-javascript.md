---
title: Ruby vs JavaScript
author: david
date: 2022-09-26 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Ruby vs JavaScript
---

## JavaScript and Ruby are beautiful ❤

The choice of the programming language will definitely affect what projects you will create and what companies you will be able to work for in the future.

In this article, we decided to compare Ruby and JavaScript, which are good languages to start learning to code. Of course, both have advantages and disadvantages, and it often depends on your goals in programming.

Ruby was invented in 1995 by Yukihiro Matsumoto as he "wanted a genuine object-oriented, easy-to-use scripting language".
JavaScript was invented by Brendan Eich and was originally thought to be used only in the browser as an interface language and first appeared also in 1995 in Netscape 2.0 under the name LiveScript.

In bare outlines, JavaScript is a lightweight, interpreted, multi-paradigm scripting language that is dynamic and supports object-oriented, imperative, and functional programming styles. It is most known as the scripting language for web pages but is used in many non-browser environments as well such as Node.js. 

And Ruby is an interpreted, dynamic, high-level, general-purpose programming language that supports multiple programming paradigms, including procedural, object-oriented, and functional programming with a focus on simplicity and productivity. It is an open-source programming language that balanced functional programming with imperative programming.

## Use cases

For now, JavaScript has evolved into quite a complex and powerful language. One of the most significant boosts in JavaScript is the creation of Node.js which has modified it into a front-end and back-end language. With this, you can actually build a full-stack web application using only one language. As is known, JavaScript is commonly used as a front-end programming language for a client-side application because it allows us to implement complex elements on web pages, and is also used for server-side, browser-level interaction and changes. 9 of 10 web pages contain JavaScript codes on their front end.
 
Ruby is a general programming language. As an example, it has a range of working applications for prototyping, logic, data analysis, and web scraping. And if you want to implement your idea, the list has no fixed endpoint. A beginner with no deep knowledge of programming could quickly realize the codes written in the Ruby language. However, it is mostly used in web development in the mix with the <a href="https://rubyonrails.org/" target="_blank">Ruby-on-Rails</a> framework, which turns this into the server-side scripting language. Ruby is often used as a back-end programming language. With it, we can generate HTML and JavaScript pages that run on the server side and can interact with the database.

As statistics show Ruby is used by 5.7% of all the websites whose server-side programming language we know. While JavaScript is only 2.2% (Sept. 2022).

Let's draw a line under:

JavaScript is an object-oriented front-end scripting language and it can be utilized in the back-end process with the help of the Node.js framework.
Ruby is also an object-oriented language a priori, but it is a general programming language. In web development, it is commonly used in the back-end using Ruby On Rails.
The main point of intersection is the frameworks: Ruby-on-Rails and Node.js. These programming languages are very different from each other in use without them.

## Ruby Syntax vs JavaScript syntax

Ruby’s syntax is short, very clean, easy to perceive, and often has only one way to get the desired result. We can say that it is easier to both read and write than JavaScript’s syntax and so it is easy to get started with.

JavaScript syntax has a lot of curly braces and punctuation (less true nowadays) which might seem difficult to understand for a newbie. Unlike Ruby, it often has multiple ways of achieving a result. For beginning programmers, this could be a mess with the focus on trying to figure out the meaning of obscure characters, but not on the program itself.

## Hashes, Arrays, Objects & Falsey Values

In JavaScript,  variable declaration and assignment are a bit longer compared to Ruby. For example

`let var_name = value`

Hashes are defined as objects and access its value as hash_name.key

```Javascript
let pets = { dog: "Lucky", cat: "Rudy", hamster: "Fluffy" }
pets["cat"] 
// returns "Rudy"
```

Compared to JavaScript, declaring and assigning variables in Ruby looks a little simpler:

`var_name = value`

and [hashes](https://www.bootrails.com/blog/how-to-define-and-use-a-ruby-hash/) are defined as hash_name = {key: value, key1: value1} and access key’s value as hash_name[:key]

```ruby
cars = { ford: 1, lincoln: 2, cadillac: 3 }
cars[:ford]
# returns 1
```

Both Ruby and JavaScript have Arrays, which are more or less logically the same. But, the Object Array functions in JavaScript and the Class Array methods in Ruby sure have different syntax. For example, to find the index of an element in an array, in JavaScript you write `arrayName.indexOf("element");`. In Ruby, this is accomplished by `array_name.index("element")`.

There is a big difference between Ruby and JavaScript with the falseyness of certain values. In JavaScript like in Ruby, `null` (in Ruby, it’s `nil`) and `false` will return `false`, however, some truthful values in Ruby will return `false` in JavaScript, like `0`, empty strings (`""`), and undefined.

**Objects** in JavaScript (similar to Ruby’s hash), declared as variables, are a way of organizing key/value pairs. For example, `let dog = {breed: "beagle", name: "Lucky"};`. To access the value of an associated key, you can call that on the variable name: `dog.name` returns "Lucky". You can also easily delete a key/value pair by writing `delete dog.name`. To declare a new key/value pair, write: `dog.age = "10";`.

In Ruby **Objects** are instances of the class Object. Objects consist of data and methods and are modified and communicate with each other via methods. A custom object can be created with the `new` keyword (Method `new` of the class). You can write `dog = Dog.new`.

When you plan to declare the `new` method with parameters, you need to declare the method `initialize` at the time of the class creation. Method `initialize` is a special type of method, which will be executed when the new method of the class is called with parameters. Example:

```ruby
class Dog
   def initialize(name, breed)
      @dog_name = name
      @dog_breed = breed
   end
end
```

From here, you can create objects as follows `dog = Dog.new("Lucky", "beagle")`

Let's continue with syntax examples. In JavaScript, `===` helps to determine if two objects are the same object (having the same typeof and the same value). For example: `1 === 1` returns `true`.
In Ruby, that is achieved through `==`. (`1 == 1` returns `true`).
But JavaScript has its own double equals, which only determines if the values match. For example: `"3" == 3` returns `true`.

Moving on. In JavaScript, to turn a string "100" into the integer 100, you can write `parseInt("100");`. In Ruby, you can use `"100".to_i`.

To increment or decrement by 1 in JavaScript, you can write `++` or `--` (for example, `let x = 2; x++;` returns 3. In Ruby, it’s `x += 1`. But it must be noted, that you can write the same as well in JavaScript, however, in addition to this you have the handy `++` and `--` as well.

In JavaScript to determine what type of value something is (a string, an Object, a number, an array, etc.), you write `typeof` and then the object.
As for Ruby, you append `.class` to the end of the object.

As for the classes themselves:

**Class declaration in JavaScript** 

```Javascript
class Rectangle {
  constructor(height, width) {
    this.height = height;
    this.width = width;
  }
}
```

**Class declaration in Ruby**

```ruby
class Sample
   def function
      statement 1
      statement 2
   end
end
```

## JavaScript and Ruby inheritance

Let's see two same examples, one written in Ruby, one in JavaScript

In Ruby, you would write :

```ruby
#!/usr/bin/ruby
class Person
 
    # constructor of super class
    def initialize(name)
        @name = name
    end
     
    # method of the superclass
    def greet
        puts "Hello #{@name}"
    end
end
 
# subclass or derived class
class Author < Person
 
end
 
# creating object of superclass
author1 = Author.new('Jane')
author1.greet
# => "Jane"
```

In JavaScript, the same example is here :

```javascript
// JavaScrippt
class Person { 
    constructor(name) {
        this.name = name;
    }

    greet() {
        console.log(`Hello ${this.name}`);
    }
}

// inheriting parent class
class Author extends Person {

}

let author1 = new Author('Jane');
author1.greet();
// Hello Jane
```

## Functions and Functional programming

Functions in JavaScript are the same as methods in Ruby.
In Ruby:

```ruby
def hello
  puts 'hello'
end
```

the same logic in JavaScript can be written as:

```Javascript
function hello() {
  console.log("hello");
}
```

As another example, let's look at `each` method in Ruby. That method is often used for iterating through an array of elements to change or manipulate them. In JavaScript there is also `each` function that does the same thing, however, the syntax is different, as you might have already guessed:

```Javascript
let arr = [1,2,3];
a.forEach(function(n) {
  console.log(n);
});
```

in Ruby, the same is written as:

```ruby 
arr = [1,2,3]
a.each {|n| puts n}

#or

a.each do |n|
  puts n
end
```

Time to talk about **Functional programming** -- a programming paradigm designed to handle pure mathematical functions. This paradigm is focused on writing more compounded and pure functions.

Speaking of pure functions we mean that these functions satisfy two main conditions: the first is that they will not cause any side effects and the second is that depending on their arguments they will return the same result. When we create pure functions we must try to make them take care of one thing, so they could be very easy to test and scale. This topic is worthy of a separate discussion, but we will touch on the basic concepts a little.

## First-Class and Higher-Order Functions

A higher-order function can take a function or return one as an argument. Ruby can handle such actions, those higher-order functions need to be [`lambdas` (or `procs`).](https://www.bootrails.com/blog/ruby-block-procs-and-lambda/) 

```ruby 
add = lambda { |x,y| x + y }
sub = lambda { |x,y| x - y }

def math(method, x, y)
  method.call(x,y) * 2
end
```

And functions in JavaScript are first-class objects, also known as "first-class citizens." This means that we can work with functions in JavaScript in the same way as variables.

```Javascript
function greaterThan(n) {
   return x => x > n;
}
let greaterThanTwo = greaterThan(2);
console.log(greaterThanTwo(5));
```

## Composition

Composition is one of the fundamental concepts that describe relationships between objects when the output of one function as an input to another function.
Example in JavaScript: `let compose = (f, g) => (x) => f(g(x));`
And another one from previous in Ruby: `math(add, 1, 2)`

For a more detailed immersion in the question, you can continue to consider the concepts of State Changes, Referential transparency, etc.

## Performance comparison

When comparing Ruby's performance against JavaScript, it is slower. Some benchmarks show that JavaScript is almost 4 times faster than Ruby in a few operations (comparison with Ruby 3). We know that speed is crucial to a programming language because it defines how fast your application will be able to perform tasks.

If we want to keep this comparison fair, we need to focus on comparing Ruby to JavaScript’s runtime environment Node.js. Because JavaScript is natively a frontend language and Ruby is a backend one. If someone is looking to compare the performance of these two languages, this is the aspect they’ll be looking at. There are already benchmark tests for a Node.js vs Ruby comparison. As said before Node.js beat Ruby every time.

That being said, you shouldn't take care much about performance if you have to choose between the two.

> Ruby was fast enough in 2003 to build a business like Basecamp with no impediments. Ruby is so much faster and so much cheaper in 2016 it’s ridiculous. On the other hand, skilled programmers have never been more expensive” gets truer still with each year.

Quoted from a <a href="https://twitter.com/dhh/status/1342500106088677377" target="_blank">tweet from Rails creator</a>. 



## Conclusion

I hope you had already a good introduction to both JavaScript and Ruby languages.

Considering all of the above, JavaScript is the best choice for future programmers who have more interest in web development. You can become a full-stack developer. Using it, you can for sure set up the front end and also manage the back end.

As we said, Ruby is for general purposes. For comparison, you need to put this language head to head with a language like Python. If you learn Ruby, you of course can build useful programs, but it’s not actually beat JavaScript in web development. Indeed there is the framework, Ruby-on-Rails, which makes it easy to handle server-side tasks. But, for now, it does not have any feature to beat JavaScript when implemented in the front end. 

Though Ruby also has advantages like database migration, simplicity, quick to develop, meta-programming, and a great community. We can use Ruby for CPU-intensive applications and rapid application development.