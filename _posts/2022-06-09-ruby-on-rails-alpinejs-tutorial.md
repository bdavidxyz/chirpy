---
title: Ruby-on-Rails and AlpineJS tutorial
author: david
date: 2022-06-09 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Ruby-on-Rails and AlpineJS tutorial
---

## Rails and AlpineJS : wedding time

Have a sneak peak to the official <a href="https://alpinejs.dev/" target="_blank">AlpineJS documentation</a> . AlpineJS is here to augment _in the browser_ behaviours of HTML that is already rendered by the server. Like jQuery did. Like [Hotwire for Rails](https://bootrails.com/blog/rails-7-hotwire-a-tutorial/) does nowadays. So you can consider AlpineJS as a viable alternative to jQuery or Hotwire. Some Rails developers loves Alpine, they sometime call it "the Tailwind-like JS framework", since it has a very readable, declarative approach.

## Create a fresh new Rails app 

```bash  
$> ruby -v  
ruby 3.1.0p0 // you need at least version 3 here  
$> bundle -v  
Bundler version 2.2.11  
$> npm -v  
8.3.0 // you need at least version 7.1 here  
$> yarn -v  
1.22.10
```  
Now open your usual workspace, and type

```bash  
mkdir alpinerails && cd alpinerails 
echo "source 'https://rubygems.org'" > Gemfile  
echo "gem 'rails', '7.0.2.3'" >> Gemfile  
bundle install  
bundle exec rails new . --force  
```

You have now a fresh, new, default Rails 7 app installed in the "alpinerails" directory - this is also the name of the tiny app, perfect for a tutorial.  

## First Ruby-on-Rails files

AlpineJS lays in the View part, but unfortunately every new Rails apps comes without any View, Model or Controller.
  
Create a controller :  
```ruby  
# inside app/controllers/home_controller.rb  
class HomeController < ApplicationController  
end  
```  
  
Configure a default route :  
  
```ruby  
# inside config/routes.rb  
Rails.application.routes.draw do  
  get "home/index"  
  root to: "home#index"  
end  
```  
  
Now just copy/paste the code below into *app/views/home/index.html.erb*  
  
```html  
<!-- inside app/views/home/index.html.erb -->
<h1>Welcome, this is the home page</h1>  
```  

Create an empty database, and run the web server :
```
~/workspace/alpinerails$>  bin/rails db:create
~/workspace/alpinerails$>  bin/rails db:migrate
~/workspace/alpinerails$>  bin/rails s
```

If you open your web browser at http://localhost:3000, you should see the h1 title "Welcome, this is the home page".

## Now add AlpineJS

Run 

```
~/workspace/alpinerails$> ./bin/importmap pin alpinejs@3.10.2
```

Now look for occurences of the word "alpinejs" in your workspace. `config/importmap.rb` should have changed.

**Side note** : At [BootrAils](https://bootrails.com) we prefer to use [ViteJS with Rails](https://bootrails.com/blog/vitejs-rails-a-wonderful-combination/), which works better than Rails defaults regarding front-end assets management, from development to production. However, for a small tutorial, we stick to the Rails "importmap" feature.

Now it's time to give our Rails app the ability to manipulate the Alpine global object

```js  
// inside app/javascript/application.js
// add these two lines
import Alpine from "alpinejs"
window.Alpine = Alpine  
```  

## Displaying results

Relaunch your Rails server. Display the home page in your browser.

<figure>  
<img style="display:block;float:none;margin-left:auto;margin-right:auto;width:60%" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/v1651829503/rails/alpine.png" loading="lazy" alt="localhost">  
<figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:60%">localhost</figcaption>  
</figure>  

## Inject some AlpineJS code into Rails view

Change `app/views/home/index.html.erb` like this :

```html
<h1>Welcome, this is the home page</h1>  

<div x-data="{ count: 0 }">
    <button x-on:click="count++">Increment</button>
    <span x-text="count"></span>
</div>
```

Change your `application.js` like this :

```javascript
// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import Alpine from "alpinejs"
window.Alpine = Alpine  

document.addEventListener("DOMContentLoaded", function(event) {
  window.Alpine.start();
});
```

Now you should see the counter on the home page, that increments automagically each time you press the corresponding button.

This was our "Hello world!" tutorial for Rails and AlpineJS. 

If you already played in the past with KnockoutJS or AngularJS or any equivalent library, there are not much surprises so far. But some good news : there are still place for more declarative, more simpler JS library.

If you are not comfortable with any JS UI library, you can go to the getting started part of the AlpineJS docs, it will help you to grab concepts like templating, events, etc.

## AlpineJS vs Hotwire : centralized state

As we said earlier, AlpineJS could be seen as a replacement of Hotwire, more precisely as a replacement of the [StimulusJS part](https://bootrails.com/blog/rails-7-hotwire-a-tutorial/#stimulus).

A noticeable difference is the use of the centralized state. In Redux, the centralized state is the "single source of source", which is actually the model that each view (or each small components of the view) should refer to display something.

In Hotwire, there is no such concept : your HTML **is** the single source of truth, which completely remove the need for any additional object to represent the data of the view.

There are tons of Rails developers that happy and comfortable with this. Your mileage may vary of course, but as far as we tried, we found that StimulusJS wasn't able to tackle some corner cases. And having one centralized state is extremely useful to debug and maintain the most complicated use cases.

## Conclusion

There are probably many things to cover from here. Inject data from the server, data that only belongs to the view (like which accordion is opened), how to send data from AlpineJS, and probably some more scenarios. However we have covered the basics : how to inject a modern, simple, declarative JS library into your Rails views. Be aware that the "Hello world!" tutorial is never close to real-life problem though. Good luck!