---
title: How to handle Ruby exceptions
author: david
date: 2022-08-22 11:33:00 +0800
categories: [ruby]
tags: [ruby]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: How to handle Ruby exceptions
---

## Exception handling in the programming world

Every application is meant to enable user interaction and has a specific purpose to add value. However, applications, like any other service, can sometimes run into errors while executing. This is even more probable, as users interact with the interface by creating inputs and requests. Typical error scenarios are entering an input in the wrong format or getting errors as a return from a request to an external API.

While it is close to impossible to prevent all errors and foresee every cause, developers can identify the probable errors and handle them so that the application does not break. This is what we call **exception handling**.

<figure>  
  <img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="https://res.cloudinary.com/shinocloud/image/upload/v1661234399/rails/exception_handling_lmds6v.png" loading="lazy" alt="Exception handling" width="1494" height="646">  
  <figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">Exception handling</figcaption>  
</figure>

## Errors and exceptions

Before moving on into the topic's technicalities, we should be clear about the following concepts:

a) An **error** is a problem in the execution of an application which causes the application to crash. The user typically receives an error message and the process ends there. In this case, the user can reload the application and start a new execution trying a different behavior to avoid the error; or the issue is tracked via logs by the developer, who will try to implement a fix.

b) An **exception** is a situation identified in the production code as a probable error and that triggers a specific execution of code to prevent the application of crashing. We can differentiate between:
- **Handled exceptions**, which are exceptions that are successfully handled and keep the user on track.
- **Unhandled exceptions**, which turn into errors as the workaround defined in the exception block is not supporting the issue properly.

## Handling exceptions in Ruby

Handling exceptions is considered best practice in <a href="https://en.wikipedia.org/wiki/Object-oriented_programming" target="_blank" >object-oriented programming (OOP)</a>, as it is a way to maximize efficiency. Ruby is one of the programming languages that offers a great **exception-handling system** with a clear syntax and structure that favors reusability.

## Exception types in Ruby

In order to structure our exception-handling system, in Ruby we can group exceptions according to its nature.

On one hand, **validation exceptions** pop up when the user input is not supported by the application. Basically, we can identify:
- _Required_ field errors due to missing inputs, files, etc.
- Unique field errors due to type and format mismatches, such as [empty values](https://bootrails.com/blog/ruby-nil-vs-blank-vs-empty-vs-presence/).

On the other hand, **response exceptions** are due to problems when calling an API via request, such as:
- Badrequest
- Unauthorized

## How to implement exceptions in Ruby

Exception handling in Ruby is very straightforward. The structure is executed with the help of the keywords `begin`, `rescue` and `ensure`. The first one is used to scope the block where the exception can take place, `rescue` provides the workaround code in case of exception and `ensure` is executed regardless of whether there is exception or not.

The syntax is as per below:

```ruby
begin
  ...
rescue
  ...
else
  ...
ensure
  ...
end
```

Let us take a practical example:

```ruby
current_year = 2022
birth_year = [USER INPUT]
begin
  age = current_year - birth_year
rescue InputError
  p "The input should be an Integer, '#{birth_year}' is not valid."
  age = 0
else
  p "Age: #{age}."
ensure
  p "Age calculation done."
end
```

In this case, if the user enters an integer `1990`, the exception will not run and the return would be:

```ruby
#=> Age: 32.
#=> Age calculation done.
```

But if the user enters a string, such as "nineteen ninety", the exception would be executed:

```ruby
#=> The input should be an Integer, 'nineteen ninety' is not valid.
#=> Age calculation done.
```

## Multiple rescues

The rescue keyword can be used several times in an exception block, creating a **multiple rescue** to handle different exceptions.

While it is important to identify the different error types to prevent the application to crash, there are two aspects to keep in mind as good practice:
1. Never force Ruby to capture all exceptions with standard rescues
2. Do not try to create rescues for every single possible error and overload your application

In the example below, we can see different rescues for different error types when calling an external API. Also, note that the `ensure` method is not implemented, as it is something optional.

```ruby
begin
  ... API FETCH Request ...
rescue ErrorBadrequest
  p "400 BadRequest response"
  raise_support_alert
rescue ErrorTimeout
  p "Timeout error, retrying in 10 seconds"
  retry_api_call
else
  return data
end
```

## Loop rescue

Another useful feature to handle exceptions in Ruby is adding `rescues` to loops. For example:

```ruby
current_year = 2022
birth_year = [1990, 1999, 2001, "number", 2018]
ages = []
for i in 0..(birth_year.length - 1)
  ages[i] = current_year - birth_year
end rescue age[i] = 0
p ages
#=> [32, 23, 21, 0]
```

In this example, the exception is executed as "number" is not a valid argument. Note that the loop does not cause the application to crash, but the loop is interrupted on the fourth iteration. To amend this, we can use the keywords `retry` and `next`. **Retry** executes a new iteration giving a rescue block and **next** jumps to the next iteration.

The above example with `retry` would look like this:

```ruby
current_year = 2022
birth_year = [1990, 1999, 2001, "number", 2018]
ages = []
for i in 0..(birth_year.length - 1)
  begin
    ages[i] = current_year - birth_year
  rescue TypeError
    birth_year = 1995
    retry
  end
end  
p ages
#=> [32, 23, 21, 27, 4]
```

And with `next`:

```ruby
current_year = 2022
birth_year = [1990, 1999, 2001, "number", 2018]
ages = []
for i in 0..(birth_year.length - 1)
  begin
    ages[i] = current_year - birth_year
  rescue TypeError
    ages[i] = "invalid"
    next
  end
end  
p ages
#=> [32, 23, 21, "invalid", 4]
```

## Conclusion

1. Exceptions keep your code clean and make it more readable, making it easier to understand.
2. Code maintainability becomes easier, as it is more simple to [debug](https://bootrails.com/blog/rails-debug-with-ruby-debug/).
3. It makes your application more flexible and extensible.

All of the above will help you [create Rails applications](https://bootrails.com/blog/how-to-create-tons-rails-applications/) that are efficient by fostering object-oriented programming standards and best practices.