---
title: Authentication vs Authorization with Rails 7
author: david
date: 2024-02-12 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:Authentication%20vs%20Authorization%20with%20Rails%207,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:Feat.%20auth-zero%20and%20pundit%20gems,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  alt: Authentication vs Authorization with Rails 7
---


Authorization means give or refuse access to the current User to some URLs (or more generally, any kind of resource.)

It's closely bound to Authentication, but it's different.

Think about an international conference about climate change.

Authentication is the entrance ticket, you can not enter the conference without the ticket.

Authorization is about checking the ticket levels of access : does it allows you to access gate A or snack B?


## Authorization with Rails 7

Now that Rails seems to promote generator for authentication (it will be the case in Rails 8), let's use the closest possibility (right now) : the auth-zero generator. 

## Prerequisites

Tools I will use in this tutorial

```shell
ruby -v  # 3.3.0
rails -v  # 7.1.3
bundle -v  # 2.4.10
node -v # 20.9.0
git --version # 2.34.1
```

## Before authorization, authentication

Now that Rails seems to promote generator for authentication (it will be the case in Rails 8), let's use the closest possibility (right now) : the auth-zero generator.

So let's start by building an authentication system (no CSS)


```shell
rails new myapp
cd myapp 
bundle add authentication-zero
bin/rails generate authentication

```

Great! So now we have a default rails app, augmented with authentication feature.



## Seed and create the database

Inside db/seeds.rb

```ruby
User.create(email: "simple@user.com", password_digest: BCrypt::Password.create("Secret1*3*5*"), verified: true)
```

Now create the database

```bash  
  
  # Create database and schema.rb
  bin/rails db:create
  bin/rails db:migrate
  bin/rails db:seed

``` 

And launch the server :

```bash  
  # Launch the local web server
  bin/rails server
```  

Good! Now open localhost:3000 and try to authenticate with the user that is inside seed.rb

Now log out, and stop the local web server.

## Build 3 different pages

Now let's build 3 different pages : home page, profile page, and admin page.


Welcome page like this :

```bash  
  echo "class WelcomeController < ApplicationController" > app/controllers/welcome_controller.rb
  echo "end" >> app/controllers/welcome_controller.rb
  mkdir app/views/welcome
  echo '<h1>welcome page</h1>' > app/views/welcome/index.html.erb
  
``` 

Profile page like this :

```bash  
  echo "class ProfileController < ApplicationController" > app/controllers/profile_controller.rb
  echo "end" >> app/controllers/profile_controller.rb
  mkdir app/views/profile
  echo '<h1>Profile page</h1>' > app/views/profile/index.html.erb
  
``` 

And an admin page like this :

```bash  
  echo "class AdminController < ApplicationController" > app/controllers/admin_controller.rb
  echo "end" >> app/controllers/admin_controller.rb
  mkdir app/views/admin
  echo '<h1>Admin only area!</h1>' > app/views/admin/index.html.erb
  
``` 

Now apply routes to these new pages :

```ruby  
  # inside config/routes.rb
  Rails.application.routes.draw do

    # add these 3 lines
    get "welcome", to: "welcome#index"
    get "profile", to: "profile#index"
    get "admin", to: "admin#index"

    # all other routes remain unchanged
    # ...

  end
``` 

Relaunch your local web server, and try to access to the following URLs:

- "http://locahost:3000/welcome", welcome page
- "http://locahost:3000/profile", profile page
- "http://locahost:3000/admin", admin-only area ;)

Yikes! None of them is available, unless you've gone through the login screen.

> A good practice I can see in many Rails project is to make every routes "authenticated" by default, which mean you cannot access them, unless you are already authenticated
{: .prompt-tip }

## Make a page available to the public

Modify the HomeController as follow :

```ruby  
# Inside app/controllers/welcome_controller.rb
class WelcomeController < ApplicationController

  skip_before_action :authenticate  # add this

end
```

Ok sounds fair. You will barely see any welcome page that needs authentication.

So now open the welcome page again (http://locahost:3000/welcome), you should be able to access it without the need of authentication.


## Add role column

Remember, authorization is linked to authentication, but is not exactly the same thing.

 - A simple visitor can view the home page, but can not access the user profile page
 - A user can access home page and profile page, but can not access the admin dashboard
 - An admin may access every part of the application

So we need a "role" column now, in order to know _who_ has access to _what_

**Stop your local web server**

Back to your terminal, enter :

```bash  
  bin/rails generate migration add_role_to_users role:string
```

Modify the migration file as follow :

```ruby 
class AddRoleToUsers < ActiveRecord::Migration
   def change
      # modify as follow
      add_column :users, :role, :string, :default => "customer"
   end
end
```

And run

```bash  
  bin/rails db:migrate
```

Inside user.rb

```ruby  
class User < ApplicationRecord
  has_secure_password

  # add this line
  enum role: {customer: "customer", admin: "admin"}

  # ...rest of code
end
```

## Seed your database with various profiles

Inside db/seeds.rb

```ruby
User.create(email: "simple@user.com", role: 'customer', password_digest: BCrypt::Password.create("Secret1*3*5*"), verified: true)
User.create(email: "customer@user.com", role: 'customer', password_digest: BCrypt::Password.create("Secret1*3*5*"), verified: true)
User.create(email: "admin@user.com", role: 'admin', password_digest: BCrypt::Password.create("Secret1*3*5*"), verified: true)
```

Recreate your database (you won't usually do this once you have a production database, but for a small tutorial, that's ok)

```bash  
  bin/rails db:drop db:create db:migrate db:seed
```

Relaunch your local web server with

```bash  
  bin/rails server
```

And connect as customer@user.com, and try to access to localhost:3000/admin

> Yikes! Even if we connect as customer, we have access to the admin area. We should have raised an authorization error, so now it's time for authorization with Pundit.
{: .prompt-danger }

## Rails 7 authorization with Pundit (finally!)

It's time to add Pundit to clearly prevent unauthorized users to go everywhere inside our flashy webapp.

Add `gem 'pundit'` to Gemfile:

```ruby
gem 'pundit'
```

And run

```shell
bundle install
```

Include Pundit in your application controller:

```ruby
class ApplicationController < ActionController::Base
    include Pundit::Authorization # add this line

  # was here before, left as-is
  before_action :set_current_request_details
  before_action :authenticate

  # add this method, required by Pundit
  def current_user 
    Current.user # this belongs to the authentication mechanism, so not Pundit
  end

  # rest of code ...

end
```

*Also, you can run the generator to set up an application policy with some useful defaults:*

```shell
bin/rails g pundit:install
```

After that, you need to restart the Rails server. Now Rails can pick up any classes in the new `app/policies/` directory.

## Adding policies

```shell
touch app/policies/admin_policy.rb

```

Our `admin_policy.rb` only allows admin to go to the admin dashboard:

```ruby
class AdminPolicy < ApplicationPolicy
  attr_reader :user

  def index?
    return user.admin?
  end
end
```

## Injecting Pundit policies into controller

So now let's inject our policy into the controller.

```ruby
class AdminController < ApplicationController

  def index
    authorize Current.user, policy_class: AdminPolicy
  end  

end
```

Yay! Not too much Rails magic here. We explicitly authorize the current user for a given policy.

Now relaunch your web server, and try to connect as customer to the admin area. It should raise an error.

Try to connect as admin to the admin area. It should work properly :)

How good is that ?

## Summary

We covered 2 major concept of any web app, from scratch :

 - Authentication, with a generator : Rails 8 will work like this, so we relied on a similar gem to achieve it.
 - Authorization, with a well-known gem, in order to know which user has access to which resource.

Have a good day then :) 

David


