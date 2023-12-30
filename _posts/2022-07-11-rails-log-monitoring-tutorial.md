---
title: Rails log monitoring - tutorial and home-made example
author: david
date: 2022-07-11 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Rails log monitoring - tutorial and home-made example
---

## What is log monitoring

"Log monitoring" means tracking warnings and bugs. And put a backtrace history in a file accessible to the team. Locally, you don't need this because each error will be printed in the console, and will blow in the current tab of your browser. It's okay because you're the developer, but you probably don't want the final user to see any backtrace - and, in a shiny, ideal world, not any bug.

So you have to handle exceptions for your user in the most comfortable way possible, and you should try to **monitor** what happened in order to correct the bug afterward.

Correcting bugs afterward is not something to be targeted, but, in the other way, we have to humbly admit that bugs will arise, even if we did everything to avoid them.

To catch bugs as soon as possible, developers often drop a monitoring solution right before the 1st day of live production of your app.

## No "Rails way" available

The "Rails way" is some kind of philosophy. Simplicity, convention over configuration, readability. It could be viewed as a "Zen" philosophy for coders (or _Hakuna matata_, pick your poison).

The use of ActiveRecord in Rails is often recognized as "the Rails way" to access data : intuitive, straightforward, readable, etc.

There's no such thing alas for monitoring.

Teams tend to use external apps for such features, but here we will rely on the incredible abilities of Rails to integrate 3rd party tools to save a few bucks.

## Enter logster

<a href="https://github.com/discourse/logster" target="_blank">logster</a> is a Rails gem that will track bugs and their stacktrace. Perfect for in-house monitoring. Take time to view their GitHub repository, the main screenshot should be clear enough

## Prerequisites for this tutorial

Check that you have at least the following versions. You need Redis to be installed and running.

```bash
$> ruby -v
ruby 3.1.2p20 // you need at least version 3 here
$> bundle -v
Bundler version 2.2.11
$> npm -v
8.3.0 // you need at least version 7.1 here
$> yarn -v
1.22.10
$> redis-cli -v
redis-cli 6.0.5
$> redis-cli PING
PONG
```

How fun is the last command ? It's just saying that Redis is running. Now let's go back to work ;)

## Install minimalistic Ruby-on-Rails app (no monitoring so far)

Type in your shell : 

```bash
mkdir logmonitor && cd logmonitor 
echo "source 'https://rubygems.org'" > Gemfile
echo "gem 'rails', '~> 7.0.0'" >> Gemfile
bundle install
bundle exec rails new . --force -d=postgresql --minimal
```

If you want to know more about the last command, you can read this [tutorial about the "rails new" options](https://www.bootrails.com/blog/rails-new-options/)

If you have git installed, maybe it's time here to do a first commit `git add . && git commit -m 'firstcommit'` so that you can track progress.

Continue in your shell by typing- or just copy/paste :

```bash  
  # Create a default controller
  echo "class HomeController < ApplicationController" > app/controllers/home_controller.rb
  echo "end" >> app/controllers/home_controller.rb

  # Create another controller
  echo "class OtherController < ApplicationController" > app/controllers/other_controller.rb
  echo "end" >> app/controllers/other_controller.rb

  # Create routes
  echo "Rails.application.routes.draw do" > config/routes.rb
  echo '  get "home/index"' >> config/routes.rb
  echo '  get "other/index"' >> config/routes.rb
  echo '  root to: "home#index"' >> config/routes.rb
  echo 'end' >> config/routes.rb

  # Create a default view
  mkdir app/views/home
  echo '<h1>This is home</h1>' > app/views/home/index.html.erb
  echo '<div><%= link_to "go to other page", other_index_path %></div>' >> app/views/home/index.html.erb
    
    # Create another view
  mkdir app/views/other
  echo '<h1>This is another page</h1>' > app/views/other/index.html.erb
  echo '<div><%= link_to "go to home page", root_path %></div>' >> app/views/other/index.html.erb

  
  # Create database and schema.rb
  bin/rails db:create
  bin/rails db:migrate
  
``` 

If git is installed locally, you can do some `git add . && git commit -m 'added default files'`. And add `gitk --all &` to view what changed since the last commit.

Good ! Run

```
bin/rails s
```

And open your browser to see your app locally. You should see something like this :

<figure>
<img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" width="1520" height="1012" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/v1645715064/blog/tutohotwire1.png" loading="lazy" alt="localhost">
<figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">localhost</figcaption>
</figure>



## Add redis to Rails

Add this to your gemfile :

```ruby
gem 'redis'
```

And run `bundle install`.

Good ! Your Rails app is now able to talk to two databases : Postgres and Redis.

## A Rails bug to be monitored later

We have here two pages : the home page, and the other page. We don't want our app to crash immediately, so let's say the other will.

Add a division by zero (ooh!) in the action of the controller of the other page

```ruby
class OtherController < ApplicationController  
  def index 
    42 / 0 # wow!
  end
end
```

## Add logster, and your Rails app can now monitor itself

Add this to your Gemfile

```ruby
gem 'logster'
```

And run

```
bundle install
```

Add a route in `config/routes.rb` in order to view logs :

```ruby
# inside config/routes.rb
mount Logster::Web => "/logs"
```

Great ! It's time to see where all this leads.

Stop your local web server, launch it again with 

```
bin/rails s
```

Go to the home page, click to the other page. Boom! you have a "division by zero" error.

Now what appears if you go to http://localhost:3000/logs ?

<figure>
<img style="display:block;float:none;margin-left:auto;margin-right:auto;" width="1520" height="1012" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/v1656683357/rails/divison_log_error.png" loading="lazy" alt="localhost">
<figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">error</figcaption>
</figure>

You won!