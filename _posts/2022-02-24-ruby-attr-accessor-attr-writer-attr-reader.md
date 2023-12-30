---
title: Ruby - attr_accessor, attr_writer, and attr_reader
author: david
date: 2022-02-24 11:33:00 +0800
categories: [ruby]
tags: [ruby]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Ruby - attr_accessor, attr_writer, and attr_reader
---

Let's start from a simple example. 

## 1. Without any attr_accessor  
  
```ruby  
class Book  
  
  def initialize(title, author)  
    @title = title  
    @author = author  
  end  
  
end  
```  
  
  
And then, create a new object of type Book :  
  
```ruby  
# Create a book object  
book = Book.new("The book title", "Jane Doe")  
```  
  
This seems okay so far. When we create our book object, the `initialize` function will execute, setting the instance variables @title and @author to the strings "The book title" and "Jane Doe" respectively.  
  
But what happens if we try to print one of these attributes?  
  
```ruby  
$> book.title  
Traceback (most recent call last):  
book.rb:9:in `<main>': undefined method `title' for #<Book:0x000055e35f3de580 @title="Ruby on Rails"> (NoMethodError)  
```  
  
this returns an undefined method error. Why is this the case when we have clearly set the title property?  
  
This is because Ruby differs from some other languages when it comes to using dot notation to access object properties. In Ruby, `.` is used specifically for accessing object methods. It can't be used for accessing properties directly.  
  
To get around this, we can define a new method (with the same name as the property) that does one thing: return the property that we want to access. Such a method is known as a getter method — its sole purpose is to get the value of the property and return it. Going back to our Book class, such methods for accessing our title and author variable would look like this:  
  
```ruby  
class Book  
  
  def initialize(title, author)  
    @title = title  
    @author = author  
  end  
  
  # Getter methods  
  def title  
    return @title  
  end  
  
  def author  
    return @author  
  end  

end  
  
book = Book.new("The book title", "Jane Doe")  
  
puts book.title  
# "The book title"  
puts book.author  
# "Jane Doe"  
```  
  
Great! Now we can access the instance variables title and color with the dot (`.`) syntax.  
  
We now want to change/update the title property. We might try to assign a new value to title as follows:  
  
```ruby  
book.title = "Why I love JavaScript"  
Traceback (most recent call last):  
book.rb:13:in `<main>': undefined method `title=' for #<Book:0x0000561c2de061a0 @title="Ruby on Rails"> (NoMethodError)Did you mean? title  
```  
  
Another undefined method error! Why can't we assign a new value to this property?  
  
Well, our title getter method will not allow us to update a variable, as its only job was to return the value. As we now want to change its value, it turns out we need to create another method to handle that (appropriately known as a setter method). In this case, the `title=` method, as this is the method that gets called when we try to assign the value. This method takes the new value as an argument and updates the instance variable. For example, setter methods for our Book class may look like:  
  
```ruby  
class Book  
  
  def initialize(title, author)  
    @title = title  
    @author = author  
  end  
  
  ## Getter methods  
  def title  
    return @title  
  end  
  def author  
    return @author  
  end  
  
  ## Setter methods  
  def title=(new_title)  
    @title = new_title  
  end  
  def author=(new_author)  
    @author = new_author  
  end  
  
end  
  
```  
We now have access to the `title=` and `author=` methods, which take an argument and assign it to the object's instance variable which we specify inside the setter method. Now, if we try to update our book object title variable, we will no longer get an error!  
  
```ruby  
book.title = "Why I love JavaScript"  
puts book.title  
# => "Why I love JavaScript"  
```  
  
## 2. attr_reader, attr_writer & attr_accessor  
  
You might be thinking that needing to create separate functions for each attribute that we want to be able to read and update is quite tedious — and it is. To make this process quicker and simpler Ruby includes some methods in its core API to help out.  
  
### attr_reader  
  
We use this when we need a variable that should only be changed from private methods, but whose value still needs to be available publicly.  
  
The `attr_reader` method takes the names of the object's attributes as arguments and automatically creates getter methods for each. We can replace our getter methods with `attr_reader` and our book class definition becomes much simpler:  
  
```ruby  
class Book  
  
  attr_reader :title, :author # <-- Getter methods  
  
  def initialize(title, author)  
    @title = title  
    @author = author  
  end  
  
  ## Setter methods  
  def title=(new_title)  
    @title = new_title  
  end  
  def author=(new_author)  
    @author = new_author  
  end  
end  
  
book = Book.new("The book title", "Jane Doe")  
puts book.title # Read variable  
# => "The book title"  
```  
  
### attr_writer  
  
With `attr_writer`, only the setter method is defined. The getter method is left out. Maybe we have a secret variable we don’t want other objects to be able to read  
  
The same goes for updating our objects properties. For this however, we need to use the `attr_writer` method. This method works similarly to `attr_reader`, except that it will automatically create setter methods for our class. Replacing our setter method in our Book class with `attr_writer` would look like this:  
  
```ruby  
class Book  
  attr_reader :title, :author  
  attr_writer :title, :author # <-- Setter methods  
  
  def initialize(title, author)  
    @title = title  
    @author = author  
  end  
  
end  
  
book.title = "JavaScript" # Set value  
puts book.title  
=> "JavaScript"  
```  
  
### attr_accessor  
  
This has cleaned up our class definition significantly and saved us a lot of time and lines of code writing out separate getter and setter methods for each instance variable.  
  
However, when using the `attr_reader` and `attr_writer` methods, we still have to repeat all of the property names for each method twice.  
  
`attr_accessor` is a shortcut method when you need both `attr_reader` and `attr_writer`  
  
This is where the `attr_accessor` method comes in handy and allows us to take it one step further, creating all of the getter and setter methods in a single line as follows:  
  
```ruby  
class Book  
  
  attr_accessor :title, :author # <-- Creates both getter and setter method  
  
  def initialize(title, author)  
    @title = title  
    @author = author  
  end  
  
end  
```  
  
And that is why you will often see `attr_accessor` in Ruby classes!  
  
## 3. Summary  
  
`attr_reader` and `attr_writer` in Ruby allow us to access and modify instance variables using the . notation by creating getter and setter methods automatically. These methods allow us to access instance variables from outside the scope of the class definition. `attr_accessor` combines the functionality of these two methods into a single method.  
  
  
Enjoy !