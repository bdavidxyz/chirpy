---
title: Ruby on Rails, the MVC architecture
author: david
date: 2022-04-25 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Ruby on Rails, the MVC architecture
---

## Understanding the basics of the MVC Architecture and its Components

The Model-View-Controller architecture known as MVC is a software design pattern used to create user interfaces for both web and mobile applications. The key about this pattern is that it isolates the different components of the application in order to maximise asynchronous work and scalability. Thus, the **model** is responsible for the application logic, the **view** for rendering content and the **controller** to connect the model and the user (user requests). But before jumping into detail of these components, let’s take a step back to where all applications start, the [data schema](https://en.wikipedia.org/wiki/Database_schema).

The data schema is the skeleton of the interface. Designing a robust database is the key to developing a proper application and managing user stories. In other words, what should the user be able to do when interacting with the application? The answer to that should be translatable into the database.

The database logic is then transferred to the **models** of the MVC. Broadly speaking, each table should have its own model. Consequently, models are responsible to access, treat and update data.

The second element of the pattern are the **views**, which can amount as many as necessary. Its goal is to communicate with the controller and receive data to present it to the user in a visual way. Hence, each view allows the user to see data and interact with the application.

Finally, and as it can be inferred from the previous, the **controllers** are the glue between models and views. Controllers receive requests from the user through views. Depending on the origin of the request, the controller will execute a particular [method](https://www.tutorialspoint.com/ruby/ruby_methods.htm), which will require data from the associated model, and then render the output as a response in the view for the user.

<figure>  
<img style="display:block;float:none;margin-left:auto;margin-right:auto;width:70%" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/v1650560424/rails/diagram_mvc.png" loading="lazy" alt="Rails MVC">  
<figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:70%">Rails MVC - quick overview</figcaption>  
</figure> 


## Advantages of the MVC Pattern

The benefits of developing highly interactive user interfaces with the MVC pattern are strong. Next, we will analyse the five main advantages of this architecture.

### 1. Scalability of Large-size Mobile and Web Applications

The main principle of this methodology is to split the code in different sections and execute tasks independently. This allows to easily add components to the code and different developers to work on particular parts of the application without having to understand or modify the whole logic.

### 2. Development of Asynchronous Applications

Separating tasks and functionalities makes asynchronous invocation feasible and more efficient. This is also key to large applications to load faster and create a good user experience.

### 3. Facilitates Maintenance and Modifications

The fact that modifications do not affect the entire model is very useful, especially during the first stages of development. The organisation of the MVC architecture and its division of data, logic and display makes it easier to identify bugs and improve functionalities. Also, it enables specialisation of developers and working individually. For example, a front end developer can work on the display of a view without affecting other views nor the back end logic.

### 4. Fosters Test Driven Development

The MVC architecture logically facilitates test-driven-development (TDD) by not only making it easier to design tests to evaluate each section of code, but also to debug in case of error.

### 5. Supports SEO Strategies

The multiple view component is key to generate many different and more precise URL paths to generate engagement and boost traffic into the application. The importance of SEO strategies makes MVC a powerful tool for businesses.

We should bear in mind that the main drawback associated with this pattern is the complexity and dispersion of files. That is why it is key to invest time in the learning curve of understanding and planning before starting to work.


## How to structure MCV with Ruby on Rails

The implementation of the MVC architecture with Ruby on Rails is done by splitting the three components in folders named models, controllers and views. The views folder likewise contains more folders that enable the hosting of multiple views for each section.

For example, we can have a users folder that contains files for views that display a list of users, the details of a single user, the edit options for a user and so on.

Thus, each file inside a view folder represents the display of a page. The view files are html files that allow the embedding of ruby code (.html.erb).

The controllers and models folder contain ruby files (.rb) and each file is directly associated with a controller/model. Every controller inherits from the [Action Controller](https://guides.rubyonrails.org/action_controller_overview.html) and every model inherits from the [Active Record](https://guides.rubyonrails.org/active_record_basics.html).

At this point, we have to get familiar with the routes, which is an additional component to the MVC that is essential in Ruby on Rails. When the application receives a request the routes are responsible to create the correct path to a particular controller and method inside that controller (a method can also be understood as an action).

Without entering into many details, the Action Controller generates the main routes that an application needs following the CRUD method operations (create, read, update and delete actions) and the Active Record enables managing data in a persistent manner.


## MVC Best Practices

In order to avoid complexity and develop a consistent MVC structure the following principles should be respected:

-  Invest time to understand the existing code
    
-  Respect the naming conventions
    
-  Add validations to the models to guarantee business logic and persistent data
    
-  Use partial views and other components such as helpers to keep your code DRY