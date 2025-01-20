---
title: Rails, Sidekiq, full tutorial
redirect_to: https://alsohelp.com/blog/rails-sidekiq-tutorial
author: david
date: 2022-01-31 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:Rails%20%20Sidekiq%20%20full%20tutorial,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:A%20Ruby-on-Rails%20tutorial,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Rails, Sidekiq, full tutorial
---

## Motivation

At <strong>[BootrAils](https://bootrails.com)</strong>, we are trying to keep the stack as simple as possible.

However, the need for the existence of background jobs arises very quickly when you create a new Rails application for business purposes. Think about the "forgot password ?" feature. An email needs to be sent. `deliver_later` is very recommended, and this method needs "background jobs" to work properly.

And you can't do that easily, neither in Ruby nor Ruby-on-Rails.

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Rails Q: handling a request, is there a good utility or idiom to run a block of code asynchronously so it doesn&#39;t block the response but also doesn&#39;t incur the overhead of a job/queue system?<br><br>do_later { fire_and_forget() }<br><br>Just have a one-off call &amp; don&#39;t want the user to wait.</p>&mdash; Justin Searls (@searls) <a href="https://twitter.com/searls/status/1483572597686259714?ref_src=twsrc%5Etfw">January 18, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

In theory, ActiveJob (in charge of background jobs, as the name implies) is already included in every default Rails app.

But... the set up, dependencies, as well as production, test and development settings are entirely left to the developer.

There are two giants in this space : `delayed_jobs` (sometimes known as "DJ"), and `Sidekiq`. Sidekiq is more well-known, maintained, and documented, I would advise here to choose Sidekiq for any new Rails application - YMMV.

This tutorial is here to remove fear about installing background jobs into an application whose primary purpose is meant to be "just MCV".

## Prerequisites

Here are the tools we will use in this tutorial :

```
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
$> redis-cli ping // redis is a dependency of Sidekiq
PONG
$> foreman -v
0.87.2
```

## Create  a fresh new Rails app - without Sidekiq first

```bash  
mkdir sidekiqrails && cd sidekiqrails  
echo "source 'https://rubygems.org'" > Gemfile  
echo "gem 'rails', '7.0.1'" >> Gemfile  
bundle install  
bundle exec rails new . --force -d=postgresql --minimal

# Create a default controller
echo "class WelcomeController < ApplicationController" > app/controllers/welcome_controller.rb
echo "end" >> app/controllers/welcome_controller.rb

# Create a default route
echo "Rails.application.routes.draw do" > config/routes.rb
echo '  get "welcome/index"' >> config/routes.rb
echo '  root to: "welcome#index"' >> config/routes.rb
echo 'end' >> config/routes.rb

# Create a default view
mkdir app/views/welcome
echo '<h1>This is h1 title</h1>' > app/views/welcome/index.html.erb


# Create database and schema.rb
bin/rails db:create
bin/rails db:migrate

```

Then open application.rb and uncomment line 6 as follow :

```ruby
# inside config/application.rb
require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie" # <== Uncomment
# ... everything else remains the same
```

Then create the parent Class of all jobs :

```ruby
# inside app/jobs/application_job.rb
  class ApplicationJob < ActiveJob::Base
  end
```

**Side note** We created the Rails app with the `--minimal` flag, so that you can discover clearly what is needed to run a job. With the default install, `active_job/railtie` is already uncommented, and the parent Class of all jobs already exists.

## Add redis and sidekiq gems to your Rails app

Open your Gemfile, and add at the very bottom

```ruby
gem 'redis'
gem 'sidekiq'
```

And in your terminal, run

```ruby
bundle install
```

Then add the following line inside application.rb

```ruby
# inside config/application.rb
# ...
class Application < Rails::Application
    config.active_job.queue_adapter = :sidekiq
# ...
```
## Create a hello world job

Create a new file under app/jobs/hello_world_job.rb

```ruby
# inside app/jobs/hello_world_job.rb
class HelloWorldJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Simulates a long, time-consuming task
    sleep 5
    # Will display current time, milliseconds included
    p "hello from HelloWorldJob #{Time.now().strftime('%F - %H:%M:%S.%L')}"
  end

end
```

Nothing fancy. The purpose of this job is to be run asynchronously when called. Whereas the classic HTTP requests/responses will be handled inside the only available Thread. However any to HelloWorldJob can be initially triggered inside an HTTP request. Let's see how.

## Call the hello world job from the view

Modify routes.rb as follow :

```ruby
# inside config/routes.rb
Rails.application.routes.draw do
  get "welcome/index"

  # route where any visitor require the helloWorldJob to be triggered
  post "welcome/trigger_job"

  # where visitor are redirected once job has been called
  get "other/job_done"

  root to: "welcome#index"
end
```

Create app/controllers/other_controller.rb
```ruby
# inside app/controllers/other_controller.rb
class OtherController < ApplicationController

  def job_done
  end

end
```

Create app/views/other/job_done.html.erb
```html
<!-- inside app/views/other/job_done.html.erb -->
<h1>Job was called</h1>
```

Now our job is ready to be called from the initial view :
```ruby
<%# inside app/views/welcome/index.html.erb %>
<h1>This is h1 title</h1>

<%= form_with url: welcome_trigger_job_path do |f| %>
 <%= f.submit 'Launch job' %>
<% end %>
```

And the call will happen inside the controller, like this :

```ruby
# inside app/controllers/welcome_controller.rb
class WelcomeController < ApplicationController

  def trigger_job
    HelloWorldJob.perform_later
    redirect_to other_job_done_path
  end

end
```

## Add a Procfile.dev

You probably want to try everything right now, but wait a minute : our jobs must be sent from *another thread*. This is done locally by adding a `Procfile.dev` file at the root of our project :

```shell
web: bin/rails s
worker: bundle exec sidekiq -C config/sidekiq.yml
```

Add config/sidekiq.yml

```yml
# inside config/sidekiq.yml
development:
  :concurrency: 5

production:
  :concurrency: 10

:max_retries: 1

:queues:
  - default
```

And finally add the sidekiq initializer here : config/initializers/sidekiq.rb
```ruby
# inside config/initializers/sidekiq.rb

Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/1') }
end
Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/1') }
end
```

`redis://localhost:6379/1` is the default URL of a locally installed redis database. If it's not available here, REDIS_URL is the environment variable that will come to the rescue.

## Launch local app

Now it's time to see if everything is going well.

Launch your local server like this :

```shell
foreman start -f Procfile.dev
```

Let's see what is displayed locally :

<figure>  
<img style="display:block;float:none;margin-left:auto;margin-right:auto;width:60%" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/v1642850174/blog/launch.png" loading="lazy" alt="localhost">  
<figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:60%">localhost</figcaption>  
</figure>  

Click on the "Launch job" button, and immediately display logs in your terminal :

```shell
18:43:31 web.1    | Started POST "/welcome/trigger_job" for ::1 at 2022-01-22 18:43:31 +0100
18:43:31 web.1    | Processing by WelcomeController#trigger_job as HTML
18:43:31 web.1    | [ActiveJob] Enqueued HelloWorldJob (Job ID: 9b9aa325-d118-45ff-a74b-99cad73ecda8) to Sidekiq(default)
18:43:31 web.1    | Redirected to http://localhost:5000/other/job_done
18:43:31 web.1    | 
18:43:31 web.1    | Started GET "/other/job_done" for ::1 at 2022-01-22 18:43:31 +0100
18:43:31 web.1    | Completed 200 OK in 4ms (Views: 3.3ms | ActiveRecord: 0.0ms | Allocations: 2644)
18:43:31 web.1    | 
18:43:31 worker.1 | 2022-01-22T17:43:31.776Z pid=3002 tid=3ze class=HelloWorldJob jid=166d945e2b7cd15e37addc7c INFO: Performing HelloWorldJob (Job ID: 9b9aa325-d118-45ff-a74b-99cad73ecda8) from Sidekiq(default) enqueued at 2022-01-22T17:43:31Z
18:43:36 worker.1 | "hello from HelloWorldJob 2022-01-22 - 18:43:36.784"
18:43:36 worker.1 | 2022-01-22T17:43:36.785Z pid=3002 tid=3ze class=HelloWorldJob jid=166d945e2b7cd15e37addc7c INFO: Performed HelloWorldJob (Job ID: 9b9aa325-d118-45ff-a74b-99cad73ecda8) from Sidekiq(default) in 5008.15ms
18:43:36 worker.1 | 2022-01-22T17:43:36.786Z pid=3002 tid=3ze class=HelloWorldJob jid=166d945e2b7cd15e37addc7c elapsed=5.47 INFO: done
```

We copy/pasted here a simplified version of the logs, so that you can see what is actually happening. The `GET "/other/job_done"` is triggered immediately, at `18:43:31`; whereas the job is actually called 5 seconds later, at `18:43:36`. This is what is called "background jobs".

## Push Rails and Sidekiq to production 

Follow step below :

```bash  
# heroku is connected
heroku login  
heroku create  

# This will modify local files
echo "web: bundle exec puma -C config/puma.rb" > Procfile  
echo "worker: bundle exec sidekiq -e production -C config/sidekiq.yml" >> Procfile  
bundle lock --add-platform x86_64-linux  

# This will modify you heroku app
heroku addons:create heroku-postgresql:hobby-dev  
heroku addons:create heroku-redis:hobby-dev
heroku buildpacks:add heroku/ruby  

git add . && git commit -m 'ready for prod'  
git push heroku main  

# app works, but worker (for background jobs) is missing
heroku ps:scale worker=1

```

So far everything should work properly.

Wait 1 minute (maximum 2), so that every Heroku dependency is properly set up.

Open the application in your browser (the URL should contain heroku.com, so we're not trying localhost this time).

Click on the "launch" button again, and check your logs by typing

```shell
heroku logs
```

Can you see the worker that correctly prints "Hello world" ? Sidekiq works !

## A last word (of caution)

Background jobs tend to swallow exceptions without any complaint. Failed to connect to the Redis database ? It won't tell you. Bug appeared ? May not be shown. So our advice would be to make sure that everything is working properly by keeping the HelloWorldJob available (to quickly manually check if Sidekiq is working), and to install the Sidekiq web UI right from the start (not covered in this tutorial).