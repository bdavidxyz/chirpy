---
title: Rails authentication with Rodauth, an elegant Ruby gem
author: david
date: 2022-01-10 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails, authentication]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:Rails%20authentication%20with%20Rodauth%20%20an%20elegant%20Ruby%20gem,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:A%20Ruby-on-Rails%20tutorial,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Rails authentication with Rodauth, an elegant Ruby gem
---

## 0. Motivation

At <strong>[BootrAils](https://bootrails.com)</strong>, until recently, we were uncomfortable about what could be a decent default authentication in any new Rails app  - until Rodauth appeared under the radar.

There are no "Active Auth" in the Ruby-on-Rails world, which means if you want to add authentication in your app, you have to rely on a gem - or build it yourself.

For those who already know this field, this is an endless debate over the wild Internet. Devise is the most used gem. However, it always comes with "so-so" appreciations by long-term users : Devise is not so great for corner cases (handling JWT authentication is one of the complaints, amongst many others). Clearance, Sorcery are well-known alternatives, but they are also tightly coupled with Rails itself, and are not-so-easy to tweak when necessary.


## 1. Enters Rodauth

Rodauth removes most of the pains described above. Rodauth is initially not bound to Rails (it's a Ruby library). It comes with the following [features](https://github.com/jeremyevans/rodauth#features-) :

- Login
- Logout
- Change Password
- Change Login
- Reset Password
- Create Account
- Close Account
- Verify Account
- Confirm Password
- Remember (Autologin via token)
- Lockout (Bruteforce protection)
- Audit Logging
- Email Authentication (Passwordless login via email link)
- WebAuthn (Multifactor authentication via WebAuthn)
- WebAuthn Login (Passwordless login via WebAuthn)
- WebAuthn Verify Account (Passwordless WebAuthn Setup)
- OTP (Multifactor authentication via TOTP)
- Recovery Codes (Multifactor authentication via backup codes)
- SMS Codes (Multifactor authentication via SMS)
- Verify Login Change (Verify new login before changing login)
- Verify Account Grace Period (Don't require verification before login)
- Password Grace Period (Don't require password entry if recently entered)
- Password Complexity (More sophisticated checks)
- Password Pepper
- Disallow Password Reuse
- Disallow Common Passwords
- Password Expiration
- Account Expiration
- Session Expiration
- Active Sessions (Prevent session reuse after logout, allow logout of all sessions)
- Single Session (Only one active session per account)
- JSON (JSON API support for all other features)
- JWT (JSON Web Token support for all other features)
- JWT Refresh (Access & Refresh Token)
- JWT CORS (Cross-Origin Resource Sharing)
- Update Password Hash (when hash cost changes)
- Argon2
- HTTP Basic Auth
- Change Password Notify
- Internal Request
- Path Class Methods

Not bad for a start ! Chances you need anything else for a standard business are close to zero percent.

No need to say we won't cover each of the features, but knowing we won't miss anything is always great !


## 2. Try it, from scratch

First ensure you have all the classic already installed on your computer :

```bash  
$> ruby -v  
ruby 3.0.0p0 // you need at least version 3 here  
$> bundle -v  
Bundler version 2.2.11  
$> npm -v  
8.3.0 // you need at least version 7.1 here  
$> yarn -v  
1.22.10
$> psql --version  
psql (PostgreSQL) 13.1 // let's use a production-ready database locally  
```
Any upper version should work

And install a fresh new rails application from the start :

```bash  
  mkdir myapp && cd myapp  
  echo "source 'https://rubygems.org'" > Gemfile  
  echo "gem 'rails', '7.0.0'" >> Gemfile  
  bundle install  
  bundle exec rails new . --force --css=bootstrap -d=postgresql  
  bundle update
```  

Bootstrap will allow us a more beautiful demo. Or at least more readable :) 

Inside myapp folder, continue with the following terminal commands :

```bash  
  # Create a default controller
  echo "class HomeController < ApplicationController" > app/controllers/home_controller.rb
  echo "end" >> app/controllers/home_controller.rb

  # Create another controller (the one that should not be reached without proper authentication)
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
  echo '<div class="lead my-3"><%= link_to "go to other page", other_index_path %></div>' >> app/views/home/index.html.erb

  # Create another view (will be also protected by authentication)
  mkdir app/views/other
  echo '<h1>This is another page</h1>' > app/views/other/index.html.erb
  echo '<div class="lead my-3"><%= link_to "go to home page", root_path %></div>' >> app/views/other/index.html.erb
  
  
  # Create database and schema.rb
  bin/rails db:create
  bin/rails db:migrate
  
``` 

Good ! We now have a good default Rails 7 application, with a home page, and the "other" page that should be protected from unauthenticated access.

Have a sneak peek of the current app by running

```shell
./bin/dev
```

And open http://localhost:3000

<figure>  
<img style="display:block;float:none;margin-left:auto;margin-right:auto;width:60%" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/v1640434309/rails/simpleapp.png" loading="lazy" alt="localhost">  
<figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:60%">localhost</figcaption>  
</figure>  

Navigate from one page to another. So far nothing incredible, but at least we are ready to try a good authentication gem !

## 3. Install rodauth-rails

Now open your Gemfile and add 

```ruby
gem "rodauth-rails"
```

and then 

```bash
$/myapp> bundle install
```

Let's see what it is about :

```bash
$/myapp> bundle info rodauth-rails
  * rodauth-rails (0.18.1)
    Summary: Provides Rails integration for Rodauth.
    Homepage: https://github.com/janko/rodauth-rails
    Path: /Users/shino/.rbenv/versions/3.0.0/lib/ruby/gems/3.0.0/gems/rodauth-rails-0.18.1
```

Great ! Be prepared for next level :)

## 4. Install rodauth in your app

The gem is now  available, but not the necessary files and folders to run rodauth in your Rails app. 

Let's do it :
```bash
$/myapp> bin/rails generate rodauth:install
      create  db/migrate/20211224143551_create_rodauth.rb
      create  config/initializers/rodauth.rb
      create  config/initializers/sequel.rb
      create  app/lib/rodauth_app.rb
      create  app/controllers/rodauth_controller.rb
      create  app/models/account.rb
      create  app/mailers/rodauth_mailer.rb
      create  app/views/rodauth_mailer/email_auth.text.erb
      create  app/views/rodauth_mailer/password_changed.text.erb
      create  app/views/rodauth_mailer/reset_password.text.erb
      create  app/views/rodauth_mailer/unlock_account.text.erb
      create  app/views/rodauth_mailer/verify_account.text.erb
      create  app/views/rodauth_mailer/verify_login_change.text.erb
```

Take a sneak peek of each file in your favorite IDE.

Then type :

```bash
$/myapp> bin/rails db:migrate
== 20211224143551 CreateRodauth: migrating ====================================
-- enable_extension("citext")
   -> 0.1350s
-- create_table(:accounts)
   -> 0.0084s
-- create_table(:account_password_hashes)
   -> 0.0066s
-- create_table(:account_password_reset_keys)
   -> 0.0081s
-- create_table(:account_verification_keys)
   -> 0.0217s
-- create_table(:account_login_change_keys)
   -> 0.0080s
-- create_table(:account_remember_keys)
   -> 0.0050s
== 20211224143551 CreateRodauth: migrated (0.1933s) ===========================
```

Now the schema.rb looks like this :

```ruby
ActiveRecord::Schema.define(version: 2021_12_24_143551) do

  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "account_login_change_keys", force: :cascade do |t|
    t.string "key", null: false
    t.string "login", null: false
    t.datetime "deadline", precision: 6, null: false
  end

  create_table "account_password_hashes", force: :cascade do |t|
    t.string "password_hash", null: false
  end

  create_table "account_password_reset_keys", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "deadline", precision: 6, null: false
    t.datetime "email_last_sent", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "account_remember_keys", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "deadline", precision: 6, null: false
  end

  create_table "account_verification_keys", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "requested_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "email_last_sent", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "accounts", force: :cascade do |t|
    t.citext "email", null: false
    t.string "status", default: "unverified", null: false
    t.index ["email"], name: "index_accounts_on_email", unique: true, where: "((status)::text = ANY ((ARRAY['unverified'::character varying, 'verified'::character varying])::text[]))"
  end

  add_foreign_key "account_login_change_keys", "accounts", column: "id"
  add_foreign_key "account_password_hashes", "accounts", column: "id"
  add_foreign_key "account_password_reset_keys", "accounts", column: "id"
  add_foreign_key "account_remember_keys", "accounts", column: "id"
  add_foreign_key "account_verification_keys", "accounts", column: "id"
end
```

## 4. See available routes

The Rodauth middleware will handle requests (and not the Rails app), thus, routes won't be shown at /rails/info/routes.

From the docs, here are the available endpoints :

```bash
Routes handled by RodauthApp:

  /login                   rodauth.login_path
  /create-account          rodauth.create_account_path
  /verify-account-resend   rodauth.verify_account_resend_path
  /verify-account          rodauth.verify_account_path
  /change-password         rodauth.change_password_path
  /change-login            rodauth.change_login_path
  /logout                  rodauth.logout_path
  /remember                rodauth.remember_path
  /reset-password-request  rodauth.reset_password_request_path
  /reset-password          rodauth.reset_password_path
  /verify-login-change     rodauth.verify_login_change_path
  /close-account           rodauth.close_account_path
```
## 5. Creating views and UX

You have some templates already available for free, if you want to see how things work. For a tutorial, this is a perfect starting point, so let's type :

```bash
$/myapp> bin/rails generate rodauth:views
      create  app/views/rodauth/_login_form.html.erb
      create  app/views/rodauth/_login_form_footer.html.erb
      create  app/views/rodauth/_login_form_header.html.erb
      create  app/views/rodauth/login.html.erb
      create  app/views/rodauth/multi_phase_login.html.erb
      create  app/views/rodauth/create_account.html.erb
      create  app/views/rodauth/verify_account_resend.html.erb
      create  app/views/rodauth/verify_account.html.erb
      create  app/views/rodauth/logout.html.erb
      create  app/views/rodauth/remember.html.erb
      create  app/views/rodauth/reset_password_request.html.erb
      create  app/views/rodauth/reset_password.html.erb
      create  app/views/rodauth/change_password.html.erb
      create  app/views/rodauth/change_login.html.erb
      create  app/views/rodauth/verify_login_change.html.erb
      create  app/views/rodauth/close_account.html.erb
```



## 6. Modifying home page

Now modify the home page, you'll be then able to play with your app :

```html
<h1>This is home</h1>

<div class="lead my-3"><%= link_to "go to other page", other_index_path %></div>

<% if rodauth.logged_in? %>
  <%= link_to "Sign out", rodauth.logout_path, method: :post %>
<% else %>
  <%= link_to "Sign in", rodauth.login_path %>
  <%= link_to "Sign up", rodauth.create_account_path %>
<% end %>
```

Now launch your local server, and try to create a new account, log out, then log in, the above markup should work properly.

If you want to try the "reset password" feature locally, don't forget to add the following line to `config/environments/development.rb`

```ruby
config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
```



## 7. Protecting the other page

Remember we have 2 pages in our app : "home" and "other" (you can reach the other page at http://localhost:3000/other/index)

Modify config/routes.rb as follow :

```ruby
# inside config/routes.rb
Rails.application.routes.draw do
  get "home/index"
  constraints Rodauth::Rails.authenticated do
    get "other/index"
  end
  root to: "home#index"
end
```

Relaunch your local web server. What happen if once on home, you try to access to the other page by clicking the link ?

## 8. Docs, credits

Official repository of rodauth-rails is [here](https://github.com/janko/rodauth-rails)
Official repository of rodauth is [here](https://github.com/jeremyevans/rodauth)
Documentation is [here](https://rodauth.jeremyevans.net/documentation.html)

Thanks a lot to @janko and @jeremyevans for their incredible work, and kind answers to issues and PR on GitHub.

Enjoy !