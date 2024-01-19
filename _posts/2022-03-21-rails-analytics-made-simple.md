---
title: Rails analytics made simple
author: david
date: 2022-03-21 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:Rails%20analytics%20made%20simple,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:A%20Ruby-on-Rails%20tutorial,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Rails analytics made simple
---

## 0. Motivation

Google analytics is not anymore an option, at least in the EU. It's barely legal regarding GDPR, and we start to see companies being blamed for using it. Alternatives to Google Analytics are not free, and not cheap. Even open-source solutions are not *that* easy to implement.

## 1. Advantages of a Rails-based analytics solution

The first advantage is that you don't need a consent banner. No cookies are sent to track the user, and the user can't say "no" to tracking. As long as it remains completely anonymous, this is not a problem. Application logs may also somehow "track" access to the app, but this is not usable for non-techies.  
  
The second advantage is that it is completely free - apart from the hosting *you are already paying anyway*.  
  
The third advantage is that you will use your Rails skills - apart from installing a gem, no additional skills are required.


## 2. Active Analytics for Rails

Rails official plugins (known as "gems") often start with "Active-". You will encounter sometimes some gems outside the Rails world whose name also starts with "Active". That's the case today with [Active Analytics](https://github.com/BaseSecrete/active_analytics), a gem from [BaseSecrete](https://www.basesecrete.com/).

Their GitHub repo mention that you can know about :

-   **Sources**: What are the pages and domains that bring some traffic.
-   **Page views**: What are the pages that are the most viewed in your application ?
-   **Next/previous page**: What are the entry and exit pages for a given page of your application.

## 3. Tutorial to add analytics to a fresh new Rails application


### Prerequisites

First ensure you have all the classic already installed on your computer :

```bash  
$> ruby -v  
ruby 3.1.0p0 // you need at least version 3 here  
$> bundle -v  
Bundler version 2.2.11  
$> npm -v  
8.3.0 // you need at least version 7.1 here  
$> yarn -v  
1.22.10
$> psql --version  
psql (PostgreSQL) 13.1 // let's use a production-ready database locally  
```

### Minimal Rails application

```bash  
  mkdir railsanalytics && cd railsanalytics  
  echo "source 'https://rubygems.org'" > Gemfile  
  echo "gem 'rails', '~> 7.0.0'" >> Gemfile  
  bundle install  
  bundle exec rails new . --force --minimal -d=postgresql  
  bundle update
  
```  

### Minimal controllers and views

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
  echo '<div><%= link_to "go to analytics", "/analytics" %></div>' >> app/views/home/index.html.erb
  echo '<div><%= link_to "go to other page", other_index_path %></div>' >> app/views/home/index.html.erb
    
    # Create another view
  mkdir app/views/other
  echo '<h1>This is another page</h1>' > app/views/other/index.html.erb
  echo '<div><%= link_to "go to home page", root_path %></div>' >> app/views/other/index.html.erb

  
  # Create database and schema.rb
  bin/rails db:create
  bin/rails db:migrate
  
``` 

Good ! Run

```
bin/rails s
```

And open your browser to see your app locally. You should see something like this :

<figure>  
<img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/v1644942232/rails/analyticshomepage.png" loading="lazy" alt="localhost">  
<figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">localhost</figcaption>  
</figure>  

### Activate ActiveJob and ActionMailer

Open application.rb and uncomment line 6 and 10 as follow, this will be needed for active_analytics :

```ruby
# inside config/application.rb
require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie" # <== !! Uncomment
require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"  # <==  !! Uncomment
# ... everything else remains the same
```


### Add active_analytics

Open your Gemfile and add 

```ruby
gem 'active_analytics'
```

Then stop your local web server, and run

```ruby
bundle install
```

### Install active_analytics

Now run :

```ruby
bin/rails active_analytics:install:migrations
bin/rails db:migrate

```

**Side note** :  We often use `bin/rails` instead of just `rails`, to ensure that the version used is the one of our project, not the globally-installed version of Rails.

Now inside `app/controllers/application_controller.rb`, copy/paste the following code : 

```ruby
# inside app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :record_page_view

  def record_page_view
    ActiveAnalytics.record_request(request)
  end
end
```

Open `config/routes.rb`

```ruby
# inside config/routes.rb
Rails.application.routes.draw do

  # Add this line
  mount ActiveAnalytics::Engine, at: "analytics"

  get "home/index"
  get "other/index"
  root to: "home#index"
end

```

### Check that analytics for Rails is working, locally

Run 

```
bin/rails s
```

And open your browser at [http://localhost:3000/analytics](http://localhost:3000/analytics)

You should see this :

<figure>  
<img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/v1644942363/rails/analyticsempty.png" loading="lazy" alt="localhost">  
<figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">localhost</figcaption>  
</figure>  

Ok, no data (so far).

Now go to the homepage of your Rails app, and click on "go to other page". Then visit  [http://localhost:3000/analytics](http://localhost:3000/analytics) once again.

Now some stats should appear.

<figure>  
<img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/v1644942687/rails/analyticsnotempty.png" loading="lazy" alt="stats">  
<figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">stats</figcaption>  
</figure>  

Great ! You are able to see stats for a period range. Moreover, you can click on any url to see where the user was coming from.

## 4. View analytics in production

### First steps, fast checking

Now it's time to push your code into production, let's say heroku.

```
heroku login  
heroku create  
bundle lock --add-platform x86_64-linux  
heroku addons:create heroku-postgresql:hobby-dev  
heroku buildpacks:set heroku/ruby
git add . && git commit -m 'ready for prod'  
git push heroku main  
heroku run rails db:migrate
```

Heroku gives you a weird URL, like "https://sleepy-sands-87676.herokuapp.com/" (yours will be different). Go to this weird URL and make the same steps as before, on your local browser : go to the home page, then click on "go to the other page", then check analytics again. Everything works so far... but what if a bot visits the application ?

### Is analytics for Rails able to tackle bots ?

Now go to [https://www.webpagetest.org/](https://www.webpagetest.org/), and enter the heroku URL of your webapp. Click on "Start test!" (or equivalent). Wait for the test to finish, then visit the /analytics URL of your Heroku website.

You should see that the number of visits has increased, as if "WebPageTest" has just sent a bot, not a real visitor.

Add this to your Gemfile :

```ruby
gem 'crawler_detect'
```

Then run

```ruby
bundle install
```

Then change your main controller like this :

```ruby
# inside app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :record_page_view

  def record_page_view
    # This condition should skip bots.
    unless request.is_crawler?
      ActiveAnalytics.record_request(request)
    end
  end
end
```

Change your `config/application.rb` like this :

```ruby
# ...
module Railsanalytics
  class Application < Rails::Application

  # Add this line
    config.middleware.use Rack::CrawlerDetect
# ...
```

Then run in your console

```
git add . && git commit -m 'detect crawlers'
git push heroku main
```
Now make the WebPageTest check again.

Analytics numbers didn't change ?

You won ! 🎉

### Not covered in this tutorial

Of course the `/analytics`  URL is very likely to be a protected route - unless you build things in public. How to protect a route is not covered here, but maybe you want to give [Rodauth](https://bootrails.com/blog/rails-authentication-with-rodauth-an-elegant-gem/) a try.