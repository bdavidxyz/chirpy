---
title: Generate authentication like Rails 8 will
author: david
date: 2024-01-29 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails, authentication]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600%2Ch_836%2Cq_100/l_text:Karla_72_bold:Generate%20authentication%20like%20Rails%208%20will%2Cco_rgb:ffe4e6%2Cc_fit%2Cw_1400%2Ch_240/fl_layer_apply%2Cg_south_west%2Cx_100%2Cy_180/l_text:Karla_48:A%20tutorial%20and%20preview%2Cco_rgb:ffe4e680%2Cc_fit%2Cw_1400/fl_layer_apply%2Cg_south_west%2Cx_100%2Cy_100/newblog/globals/bg_me.jpg
  alt: Generate authentication like Rails 8 will
---

## In the need for authenticator

Rails comes with no default way to authenticate the user, like Laravel does in the PHP world.

For a long time, the Devise gem was the good-enough-way-to-go for Rails, but didn't reach 100% of adoption, for longly reddit-debated reasons.

From DHH :

> We can teach Rails developers how to use the basic blocks [of authentication] by adding a basic authentication generator that essentially works as a scaffold, but for authentication.
{: .prompt-info }

## The closest authentication generator for Rails 7

The <a href="https://github.com/lazaronixon/authentication-zero" target="_blank">authentication-zero</a> gem is the closest solution so far.

I used it. I found it very enjoyable, very few lines of code, very easy to customize, full test suite to ensure that all my customisations don't generate any kind of regression. Finally, I added some custom turbo_stream on top of validation to ensure a top-notch user experience.

The tutorial here is a simplified version of my current use.

## Prerequisites

For this tutorial you will need :

```shell
ruby -v  # 3.3.0
rails -v  # 7.1.3
bundle -v  # 2.4.10
node -v # 20.9.0
git --version # 2.34.1
```


## Build a default Rails app

Create a new Rails app like this :

```shell
rails new myapp
cd myapp

```

So nothing fancy here, no [--minimal option](/blog/rails-new-options/) or whatsoever. Stick with default is sometimes the best way to ensure more integration and less bugs.


## Add authentication-zero


So we follow now the official docs of the gem and add :

```shell
bundle add authentication-zero
bin/rails generate authentication

```

You now have routes, controllers, models, migrations, tests, etc.

## Ensure the whole test suite pass

```shell
bin/rails test:all

```

If everything is green, you can go to the next step :)


## Add letter_opener gem

You need to add a way to view the sent email on your local machine, in order to play with the confirmation email (for example).

In order to do so, add in the Gemfile :

```ruby
# inside Gemfile
gem "letter_opener", group: :development
```

and run

```shell
bundle install
```

Then inside `config/environments/development.rb` add

```ruby
config.action_mailer.delivery_method = :letter_opener
config.action_mailer.perform_deliveries = true
```

## Play with the application

By default, there are no users in the development database.

A first option is to add this inside the seed.rb file,

```ruby
User.create(email: "simple@user.com", password_digest: BCrypt::Password.create("Secret1*3*5*"), verified: true)

```

And run

```shell
bin/rails db:seed
```

And relaunch your local web server with

```shell
bin/rails server
```

Now you can connect with the user described inside the seed file.

**But that was cheating, right ?**

A second option is to play with the application, first go to the home page, then click on "sign up", then fill with one easy-to-remember email and password combination.

Then go to localhost:3000/letter_opener, and click the validation link.

Great! You now have a new verified user (who said "customer"? Not yet ;) )


## Take time to read code

Don't be too shy here to investigate the source code. The beauty of this gem is that there are no tons of complicated functions to read. Trying to understand [Devise](/blog/ruby-on-rails-authentication-tutorial-with-devise/) or [Rodauth](/blog/rails-authentication-with-rodauth-an-elegant-gem/) is another story.

Start with routes.rb, then try to play with the application, and try to understand what each unit test does and why.

Now you have a full authentication system that you fully understand!



## Conclusion

I guess this article will be deprecated, as soon as the Rails 8 authenticator will be on scene.

Waiting for this, we have a clean, elegant and customisable solution : the authentication-zero gem.