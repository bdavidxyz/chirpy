---
title: Ruby-on-Rails authentication tutorial with Devise
author: david
date: 2022-10-03 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:Ruby-on-Rails%20authentication%20tutorial%20with%20Devise,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:A%20Ruby-on-Rails%20tutorial,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Ruby-on-Rails authentication tutorial with Devise
---

## Rails authentication

Ruby-on-Rails lack of internal, built-in authentication mechanism is something often claimed by developer for the [next Rails version](/blog/rails-8-unreleased-features).

Devise seems the go-to, default gem for authentication, despite being heavily discussed on forums (like <a href="https://www.reddit.com/r/ruby/comments/syqreu/devise_love_it_or_hate_it/" target="_blank">this Reddit discussion</a>).

For bootrails we have chosen [Rodauth](/blog/rails-authentication-with-rodauth-an-elegant-gem/), which is really brilliant. 

But this article, I will try to present you the functionality of the Devise gem via a common test case: **a quick authentication with username and password**


## Setup an empty Rails app

We assume you are using an Ubuntu Linux distribution with the following installed:

* ruby
* rails
* bundler

So let's create an empty Rails application.

## Prerequisites

To follow this article you will need to check if you have installed the prerequisites, if something is missing you need to install it first to proceed.

```bash
$/workspace> ruby -v  
ruby 3.1.2p20  // you must have at least version 3

$/workspace> rails -v  
Rails 7.0.3.1 

$/workspace> bundle -v  
Bundler version 2.3.7  // you must have at least version 2

```

## How do I get set up with Rails?

Since this is a hands-on tutorial we should start by creating an empty Rails application and we can build upon it.

Let's assume that we will have one controller in our application, the PagesController, which will handle all requests coming for our two-page website:

* Home
* Exclusive content

As you can imagine we need to control the access to the "Exclusive content" to only the registered users while the home page will be accessible by anyone.

```bash
// Create a new Rails app
$/workspace> rails new my-app

// Enter the newly created folder
$/workspace> cd my-app

// Create our 'PagesController' controller with the 'exclusive' view
$/workspace/my-app> bin/rails generate controller PagesController exclusive
```

## How do I get set up with Devise?

Firstly open up with your editor your Gemfile and add this:

```yaml
gem 'devise'
```


then run these:

```bash
// add the gem to the dependencies
$/workspace/my-app> bundle install

// install the gem
$/workspace/my-app> bin/rails g devise:install

// create the User model
$/workspace/my-app> bin/rails g devise user

// Run the DB Migration
$/workspace/my-app> bin/rails db:migrate
  
```

## Check the work so far

Run the development server

```bash
// start the Puma built-in  web server for testing
$/workspace/my-app> bin/rails server
```

and point your browser to the following URL: <a href="http://localhost:3000" target="_blank">http://localhost:3000</a>. You should see something like this:

<figure>  
  <img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="https://res.cloudinary.com/shinocloud/image/upload/v1662660459/rails/empty_rails_lsbqcs.jpg" loading="lazy" alt="Screenshot 1 - Empty Rails app" width="500" height="340">  
  <figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">Screenshot 1 - Empty Rails app</figcaption>  
</figure>

Try to visit also the Exclusive content page <a href="http://localhost:3000/pages/exclusive" target="_blank">http://localhost:3000/pages/exclusive</a>, you can see it without any problem, right?

<figure>  
  <img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="https://res.cloudinary.com/shinocloud/image/upload/v1662657719/rails/page_exclusive_yvtkvc.jpg" loading="lazy" alt="Screenshot 2 - Exclusive Content Available" width="443" height="172">  
  <figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">Screenshot 2 - Exclusive Content Available</figcaption>  
</figure>

```bash
// close the web server
$/workspace/my-app> Ctr-C
```

## Welcome to the Devise world!

The Devise gem will create all the required code (Model, DB migrations) and routes to create user accounts, sign in, sign out, reset passwords, etc.

## What options do I have with Devise

The following main routes have already been created:

* Register a new user <a href="http://localhost:3000/users/sign_up" target="_blank">http://localhost:3000/users/sign_up</a>
* Authenticate a user <a href="http://localhost:3000/users/sign_in" target="_blank">http://localhost:3000/users/sign_in</a>

You also have a User model ready to support the handling of the users of your application.

```ruby
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
```

Devise will provide also the option:

* to verify if a user is signed in by using the following helper: **user_signed_in?**
* to access the current signed-in user by using: **current_user**
* or to access the session via: **user_session**

## Create a user for our testing

Point your browser at: <a href="http://localhost:3000/users/sign_up" target="_blank">http://localhost:3000/users/sign_up</a>

and create a new user. A simple form like this will be presented:

<figure>  
  <img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="https://res.cloudinary.com/shinocloud/image/upload/v1662657719/rails/user_register_ys76ls.jpg" loading="lazy" alt="Screenshot 3 - User Registration Form" width="405" height="287">  
  <figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">Screenshot 3 - User Registration Form</figcaption>  
</figure>

just set a demo email and a password for authentication. For example:

user: test@test.com

pass: password


## Let's add also the main links of SignUp, SignIn, and Logout

With your editor open the layout file: `my-app/app/views/layouts/application.html.rb`

and add this:

```erb
<div>
<% if user_signed_in? %>
  Logged in as <strong><%= current_user.email %></strong>.
  <%= link_to "Logout", destroy_user_session_path, method: :delete, :class => 'navbar-link'  %>
<% else %>
  <%= link_to "Sign up", new_user_registration_path, :class => 'navbar-link'  %> |
  <%= link_to "Sign in", new_user_session_path, :class => 'navbar-link'  %>
<% end %>
</div>
```

Like this:

```erb
<!DOCTYPE html>
<html>
  <head>
    <title>MyApp</title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>
  </head>

  <body>
<div>
<% if user_signed_in? %>
  Logged in as <strong><%= current_user.email %></strong>.
  <%= link_to "Logout", destroy_user_session_path, method: :delete, :class => 'navbar-link'  %>
<% else %>
  <%= link_to "Sign up", new_user_registration_path, :class => 'navbar-link'  %> |
  <%= link_to "Sign in", new_user_session_path, :class => 'navbar-link'  %>
<% end %>
</div>	
    <%= yield %>
  </body>
</html>
```

## A simple user authentication

As we wrote earlier the page with the "Exclusive content" contains some content that must be accessible only to registered users. A simple Register and Login/Logout functionality is sufficient. So Where do we begin? 

You guessed correctly! No need to write any extra code for the common functionality above.

Open with your editor the `my-app/app/controllers/pages_controller.rb` and add this line:

**before_action :authenticate_user!**

```ruby
class PagesController < ApplicationController
  before_action :authenticate_user!

  def exclusive
  end
end
```

Try to visit now the Exclusive content page <a href="http://localhost:3000/pages/exclusive" target="_blank">http://localhost:3000/pages/exclusive</a>, you can not see it now, right? It redirects you to the login page.

<figure>  
  <img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="https://res.cloudinary.com/shinocloud/image/upload/v1662657719/rails/user_signin_zjctpa.jpg" loading="lazy" alt="Screenshot 4 - User Login Form" width="378" height="302">  
  <figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">Screenshot 4 - User Login Form</figcaption>  
</figure>

Use the user credentials you just created and you will be redirected to the exclusive content. You can see now at the top the Logout option.

<figure>  
  <img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="https://res.cloudinary.com/shinocloud/image/upload/v1662657719/rails/page_exclusive_authenticated_gzyqyq.jpg" loading="lazy" alt="Screenshot 5 - User Logout" width="396" height="179">  
  <figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">Screenshot 5 - User Logout</figcaption>  
</figure>

## Where you can go from here

You can always improve and expand on existing code, here are some ideas:

* change the User model and add your code to enhance it.
* add Roles and Permissions and connect them with the user Model.
* change the styling and the structure of the scaffolded forms to fill your requirements.

The above test case is a simple one but surely you will face more complex situations in real-life web applications. Nowadays the requirements are higher and web applications are getting more complex. Consider that:

* you can implement a 2FA Authentication
* or implement authentication as well for API's specific endpoints.

These can be supported by the Devise gem ( you can learn more about the Devise gem by reading their <a href="https://github.com/heartcombo/devise" target="_blank">documentation</a> ) but we will write about them in future articles! **;-)**

## Conclusion

Congratulations! You have just created a web application with user authentication in a few minutes. Remember that you have just tasted a small piece of the capabilities of the devise gem. Keep learning!

As you can see with a few commands you can build a very powerful authentication system. The Devise ecosystem provides the flexibility to a developer to forget about trivial things like user authentication and concentrate more on the core functionalities of the web application.

Enjoy!!