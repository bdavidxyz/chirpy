---
title: Ruby inheritance
author: david
date: 2022-06-27 11:33:00 +0800
categories: [ruby]
tags: [ruby]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Ruby inheritance
---

## What is object oriented programming (OOP)?

Object Oriented Programming aims  to bring the logics of the real world to programming languages in order to simplify and structure code. The easiest and most common way to understand OOP is by taking car manufacturers as example. All manufacturers build cars based on a shared map or blueprint that includes wheels, doors, engines, etc. In other words, every car is build on the same components but has custom attributes and features that also enable each car to do different things.

The basis to OOP are classes, which are the map to every object. Classes define the aspects and characteristics of an object, as well as its behavior. Let's see an example of how a class looks like to start analyzing the different aspects of it:

```ruby
class Car

  def initialize(name, doors, wheels, engine)
    @name = name
    @doors = doors
    @wheels = wheels
    @engine = engine
  end

  def start
    p "Car is on"
  end

  def stop
    p "Stop"
  end

  def accelerate(new_speed)
    @new_speed = new_speed
    p "#{@name} speed is #{new_speed}km/h"
  end
end
```

The structure of a class is simple, we only need to name the class using CamelCase convention (Car). Inside the class we have the block or body that includes as many methods as we need.

```ruby
class NameClass
 #=> BLOCK
end
```

The first method inside a class is the **initializer** or **constructor**. This method is called when a new **instance** of the object is created:

`myCar = Car.new("Smart", 2, 4, "Turbo")`

In this case, the instance is "myCar" and it is a Car object that is a Smart with 2 doors, 4 wheels and a Turbo engine.

The constructor (initializer) is executed automatically when creating the new instance. The so called **attributes** are the data that we pass when calling the method `new` on our class. Note, that to interact with these attributes we need to define getters and setters methods, which of course is much more efficient if we do by using the [attribute reader, writer and accessor](https://www.bootrails.com/blog/ruby-attr-accessor-attr-writer-attr-reader/#:~:text=2.%20attr_reader%2C%20attr_writer%20%26%20attr_accessor).

After the initializer in our class we will find the set of **methods** that will custom each instance and define its behavior. For example, we can `start` our instance and increase its speed to 50km/h as per below:

```ruby
myCar.start
#=> Car is on
myCar.accelerate(50)
#=> Smart speed is 50km/h
```

## What is inheritance and how does it work in Ruby?

Inheritance is a way to reuse code so that a class can inherit or get methods from another class. As the name suggests, inheritance follows the family logic in which we can recognize parent and child classes, the last being the ones that inherit from parent classes. Note that a class can be parent to multiple classes and at the same time child to another one.

The syntax to denote this relationship between classes is achieved by using the symbol `<` as per below:

```ruby
class ElectricCar < Car
  ...
end
```

Regarding methods when using inheritance it is important to know that:
- The **initialize method** is also inherited when creating a child class.
- Any method can be **subscribed** in a child class in order to custom it by defining a method with the same name.

### Class vs interface inheritance

Ruby allows two main types of inheritance **class inheritance** and **interface inheritance**. So far, we have been exploring **class inheritance**, where we have parent classes, also called superclasses, and child classes.

Interface inheritance is different in that that it smoothes the hierarchical relationship and is used to isolate specific behaviors (methods) that are received (included) by certain classes. This behaviors are defined in modules instead of classes:

```ruby
module Repair
  def repair_engine
    p "The engine was repaired."
  end

  def change_oil
    p "The oil was changed."
  end

end
```

The `Repair` module makes sense because we can include it in our `Car` class, but also in other potential vehicle classes that we might have such as bikes or trucks. The way to use this module following the example would be:

```ruby
class ElectricCar < car
  include Repair
  ...
end

class Bike
  include Repair
  ...
end
```

Note that modules can not be instantiated, which means that we can not create an object from a module by using the <a href="https://ruby-doc.org/core-3.1.2/BasicObject.html#method-c-new" target="_blank" >method new</a> as we can do with classes.

It is important to mention that when working with objects and inheritance it is common to [use the keyword self](https://www.bootrails.com/blog/ruby-self/), in both modules and classes.

## How to implement inheritance in your application

We have seen the syntax of class and interface inheritance, now is time to understand where to implement it in an application that follows the [MVC architecture](https://www.bootrails.com/blog/ruby-on-rails-mvc/).

Class inheritance is executed entirely in the models of the application. The path to both, the `Car` and the `ElectricCar` objects, would be:

```ruby
# app/models/car.rb
# app/models/electric_car.rb
```

Interface inheritance is implemented through modules which are build in a separate folder and later included in the models of the classes that inherit from it. Hence, the path to the `Repair` module would be:

`lib/modules/repair.rb`

## Conclusion and final thoughts about inheritance

Inheritance is a powerful feature in Ruby that is used a lot as it translates into simplicity, flexibility and scalability of the code. To conclude, let’s list the main benefits of inheritance:

1. Keeps your code <a href="https://en.wikipedia.org/wiki/Don%27t_repeat_yourself" target="_blank" >DRY</a> and is considered a best practice.
2. Makes it easier to update and debug code as it breaks structure into organized classes, superclasses and modules.
3. Saves memory by using simple associations instead of repeating code structures.
4. Builds robust parent classes and modules that transfer its performance to other classes.
5. Saves time and efforts to the development team.