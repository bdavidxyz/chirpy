---
title: Active Support, Rails delightful additions to Ruby
author: david
date: 2021-03-11 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Active Support, Rails delightful additions to Ruby
---

## About 

[Sebastien](https://twitter.com/websebdev), has written a course about ActiveSupport, which is [available here](https://courses.webseb.dev/activesupport-the-unnocited-power-behind-rails). Below is an interview of Sebastien.

## What Is ActiveSupport ? 

ActiveSupport is one of the components of Ruby on Rails. As its name suggest, it "supports" applications by providing many utilities like encrypting, querying data, callbacks, security utilities, and a lot more. Even though it's part of Rails, ActiveSupport can be installed in any Ruby project with its gem. Which is what many libraries are doing. 

##  As a Rails developer, I didn't know what it actually was, before I discovered one of your tweet. What is the risk of **not** being aware of ActiveSupport ? 

I'm not sure if I would call that a risk but not being aware of ActiveSupport might make you write a lot of code for a feature that ActiveSupport was giving out of the box with a one-liner. 

##  Is there a way to "learn" it, outside googling around ? 

Rails do provide official documentation on some parts of ActiveSupport, for example, the core extensions: [[https://guides.rubyonrails.org/active_support_core_extensions.html…](https://t.co/dQ9KJZgwLu?amp=1)]([https://guides.rubyonrails.org/active_support_core_extensions.html…](https://t.co/dQ9KJZgwLu?amp=1)). There are also the API docs, however, I do find them lacking a bit. My favorite way to learn it was to dive into the source code. 

##  What if you need a function that does not yet exist in ActiveSupport ? 

ActiveSupport, like anything Rails, is just Ruby. If you need something that ActiveSupport doesn't provide, you will have to do it yourself. 

If a feature has a bug or doesn't do exactly what you need and you think your addition needs to be done in ActiveSupport, then  you can create an issue or PR in the Rails repository. Monkey patching should only be done if really problematic / urgent. I never had to do this personally.

## What would be the equivalent of ActiveSupport in the JavaScript world ? 

Probably Lodash. 

## For a last question, promotional content is allowed :) Why do you release a course about ActiveSupport, and how will it look like for the student ? 

I believe ActiveSupport is a part of Rails that not many people know about and are missing on all its great features. This is why I want to show it to the Ruby community. Also, I plan on doing other courses on Rails components like ActiveModel, and ActiveSupport is used everywhere in Rails itself. So, knowing about ActiveSupport will help understand other parts of Rails. The way I structure my course is short, independent videos, each showing a specific feature of ActiveSupport. This way, you don't have to follow the whole course if you already know some parts of ActiveSupport. Also, it will help me update the videos when new versions of Rails come out. I will not have to rewrite the whole course.