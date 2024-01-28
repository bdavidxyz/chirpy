---
title: Live reload a Rails 7 application, a first unsatisfaying attempt
author: david
date: 2024-02-19 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:Live%20reload%20a%20Rails%207%20application,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:A%20first%20unsatisfaying%20attempt,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  alt: Live reload a Rails 7 application, a first unsatisfaying attempt
---

## What is live reloading?

Live-reloading is a well-known concept for JavaScripters : you change your code, save the file, and the browser automagically reflect the change, without the need to press the "F5" key.

Actually I [already tried with ViteJS](/blog/vitejs-rails-a-wonderful-combination/) 2 years ago.

Surprisingly, it has (not yet) been included by default in most backend frameworks, including Rails.

## Prerequisites

```shell
ruby -v  # 3.3.0
rails -v  # 7.1.3
bundle -v  # 2.4.10
node -v # 20.11.0
git --version # 2.34.1
```

## Create a new Rails 7 app with eslint and cssbundling

I'm not sure this method will work with importmaps (which are new Rails default), so let's try with good old JS and CSS build :

```shell
echo "Y" | rails new theapp -j=esbuild -c=tailwind
```

`echo "Y"` is here to avoid interruption while building the app. 

See <a href="https://github.com/rails/cssbundling-rails/issues/146" target="_blank">the issue I opened on Github.</a>

now

```shell
cd theapp
bin/rails db:create db:migrate

```

## Install a default welcome page

```bash  
  echo "class WelcomeController < ApplicationController" > app/controllers/welcome_controller.rb
  echo "end" >> app/controllers/welcome_controller.rb
  mkdir app/views/welcome
  echo '<h1 class="mb-4 text-4xl font-extrabold">welcome page</h1>' > app/views/welcome/index.html.erb
  
```

Now apply routes to these new pages :

```ruby  
  # inside config/routes.rb
  Rails.application.routes.draw do

    # add this line
    root "welcome#index"

    # all other routes remain unchanged
    # ...

  end
``` 

## Install a gem for that

I remember that I had to use a chokidar + custom JS and config to get it work in previous Rails version, but now the Rails API seems much more stable in the front, we can quite safely try a gem that does the job

```ruby
# inside Gemfile

# Add this
group :development do
  gem "hotwire-livereload"
end
```

Then run

```ruby
bundle install
bin/rails livereload:install
```


## Modified files

- Note that this line was inserted inside `app/views/layouts/application.html.erb`:

```erb
<%= hotwire_livereload_tags if Rails.env.development? %>
```

- Gemfile was modified - redis gem was uncommented to include it, then bundle install has been launched. So check that redis is running on your local machine.

- Finally, config/cable.yml was modified to use redis.


> Ensure redis is running on your machine by typing `redis-cli ping` in the terminal
{: .prompt-info }

## Go! See changes live

Then launch your local web server with

```ruby
bin/dev
```

And try to add tailwind classes, or modify HTML tag or content inside `app/views/welcome/index.html.erb`. Then notice how things change in your terminal.

```shell
16:00:17 web.1  | Hotwire::Livereload::ReloadChannel is transmitting the subscription confirmation
```

**And more interestingly in your browser!** Make some change in your HTML file (remove or add CSS classes, change text). Can you see them in the browser without hitting the F5 key ? Yay!

## Problems

On my local machine, it's working so-so. Refreshing is not working all the time. So this method is not reliable enough on my side to use on it on wild, real Rails project.

That being said, a be thank you to the commiters of this gem, because it's free work, and a step in the right direction.

Next time I'll try to livereload, I need something more robust, and maybe also less invasive (whenever possible!).

## Summary

Live (or hot-) reloading is not always possible in an easy way.

I appreciate how the community tries to circumvent this problem, there will probably a "part 2" for this tutorial, since everything didn't worked as expected 😬.

Sorry mates for this incomplete answer, see you soon!

David.
