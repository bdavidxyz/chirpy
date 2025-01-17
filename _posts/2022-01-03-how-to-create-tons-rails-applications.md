---
title: How to create tons of Rails applications
redirect_to: https://alsohelp.com/blog/how-to-create-tons-of-rails-apps
author: david
date: 2022-01-03 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:How%20to%20create%20tons%20of%20Rails%20applications,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:A%20Ruby-on-Rails%20tutorial,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: How to create tons of Rails applications
---

## 1. Motivation

At <strong>[BootrAils](https://bootrails.com)</strong>, we are using this script every (working !) day. It allows you to  :

 - grab any concept,
 - isolate a bug quickly,
 - play with new Rails features,
 
 **... without any side effect.**

**Side note for beginners** : It's also an excellent way to improve your Ruby-on-Rails skills. The more you create new apps from scratch, the more you understand the directory structure, the philosophy, and the internals of Rails.

## 2. The trick

Open `~.bash_profile` on your linux-based computer.

We will create a bash function, named **cnra** (an acronym that means "create new rails application"). Acronyms are very handy to avoid remembering every shortcut.

```bash
# inside ~.bash_profile

#
# Usage :
# $> cnra myapp 7.0.0 --minimal --database=postgresql
#
cnra ()
{  
  # create dir, dive into dir, require desired Rails version
  mkdir -p -- "$1" && cd -P -- "$1"
  echo "source 'https://rubygems.org'" > Gemfile
  echo "gem 'rails', '$2'" >> Gemfile
 
  # install rails, create new rails app
  bundle install
  bundle exec rails new . --force ${@:3:99}
  bundle update

  # Create a default controller
  echo "class HomeController < ApplicationController" > app/controllers/home_controller.rb
  echo "end" >> app/controllers/home_controller.rb

  # Create a default route
  echo "Rails.application.routes.draw do" > config/routes.rb
  echo '  get "home/index"' >> config/routes.rb
  echo '  root to: "home#index"' >> config/routes.rb
  echo 'end' >> config/routes.rb

  # Create a default view
  mkdir app/views/home
  echo '<h1>This is h1 title</h1>' > app/views/home/index.html.erb

  # Create database and schema.rb
  bin/rails db:create
  bin/rails db:migrate
}
```

Note the trick `${@:3:99}` that means "all remaining CLI args, from the 3rd one to the last one."

Otherwise, comments should be self-explanatory. If not, just [contact us](https://bootrails.com/contact) :)

Now type
```bash
$> source ~/.bash_profile
```

So that your terminal will be aware of what changed inside your `.bash_profile`.

## 3. Usage

Open your terminal

```bash
$> cnra myapp 7.0.0 --minimal -d=postgresql
```

1st CLI arg is "myapp"  : the name of the new app
2nd CLI arg is 7.0.0 : the version of Rails you want to try
3rd CLI arg is --minimal -d=postgresql : PostGre is a production-ready database you can easily use locally.

Note that `--minimal` and `-d=postgresql` are optionals.


## 4. Going further

We personally like the minimal flag (to avoid all the default gems we probably won't need), and the "postgresql" database - a production-ready, widely used database in the Ruby-on-Rails world. So we use another shortcut, based on the previous one.

```bash
cnra7mp() {
  cnra myapp 7.0.0 --minimal -d=postgresql
}
```

All we have to do now each time we want to try something with Rails is the following :

```bash
$/workspace> cnra7mp
$/workspace/myapp> bin/rails server
```

And **voilà** ! A new Rails application up and running, no need to create the database, or build a default welcome page : our app is ready for experimentations.

## 5. All available options

If you need to know all the options when creating a new Rails application, see [https://bootrails.com/blog/rails-new-options/](https://bootrails.com/blog/rails-new-options/)

Enjoy !