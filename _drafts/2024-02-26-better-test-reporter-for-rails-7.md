---
title: Better test reporter for Rails 7
author: david
date: 2024-02-26 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:Better%20test%20reporter%20for%20Rails%207,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:A%20quick%20win,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  alt: Better test reporter with Rails 7
---


## Default CLI test reporters with Rails

Maybe this is matter of personal taste here, but I find the default test reporter in Ruby to be a little bit rough :

```shell
bin/rails test:all
Running 34 tests in a single process (parallelization threshold is 50)
Run options: --seed 27591

# Running:

............Rack::Handler is deprecated and replaced by Rackup::Handler
Capybara starting Puma...
* Version 6.4.2 , codename: The Eagle of Durango
* Min threads: 0, max threads: 4
* Listening on http://127.0.0.1:32903
......................

Finished in 12.990000s, 2.6174 runs/s, 4.6959 assertions/s.
34 runs, 61 assertions, 0 failures, 0 errors, 0 skips

```

Ok, I have one warning, some logs from a webserver, some random green points, and a few stats.

Not bad, but could be better.

## Prerequisites for this tutorial

```shell
ruby -v  # 3.3.0
rails -v  # 7.1.3
bundle -v  # 2.4.10
node -v # 20.9.0
git --version # 2.34.1
```

## Build a simple Rails app

Ok we take the most simple use case, so let's use _Boring Rails_™ here

```shell
rails new myapp
cd myapp 
bin/rails db:create db:migrate

```

## Build a default test suite


There's no surprise, I'm big fond of <a href="https://twitter.com/lazaronixon" target="_blank">@lazaronixon</a> work about <a href="https://github.com/lazaronixon/authentication-zero" target="_blank">authentication-zero gem</a>, where you have an excellent laying ground to build a custom authentication system by yourself.

And guess what, there's a full test suite (with system, integration, and unit tests) offered 🎁.

Perfect for our case!

```shell
bundle add authentication-zero
bin/rails generate authentication
bin/rails db:create db:migrate

```

So we just run the full test suite, as per the docs

```shell
bin/rails test:all -v

```

> Notice the -v option to see a more verbose version.
{: .prompt-info }


Here is an excerpt of the output :

```shell
SessionsControllerTest#test_should_get_new = 0.00 s = .
SessionsControllerTest#test_should_sign_out = 0.27 s = .
SessionsControllerTest#test_should_sign_in = 0.26 s = .
SessionsControllerTest#test_should_not_sign_in_with_wrong_credentials = 0.26 s = .
Identity::PasswordResetsTest#test_updating_password = 0.26 s = .
Identity::PasswordResetsTest#test_sending_a_password_reset_email = 0.32 s = .

Finished in 11.980820s, 2.8379 runs/s, 5.0915 assertions/s.
34 runs, 61 assertions, 0 failures, 0 errors, 0 skips
```

It's more readable than first version, but it's still far away from what Jest has to offer in the JS world.

## Add a better reporter for Minitest

Add this to your Gemfile :

```ruby
gem 'minitest-reporters', group: [:test]
```

And run

```shell
bundle install

```


And add this to test-helper.rb, just above `class ActiveSupport::TestCase` :

```ruby
require "minitest/reporters"
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
```

Now run again

```shell
bin/rails test:all

```

(without the verbose option)

Which gives the following output (excerpt) :

```shell
UserMailerTest
  test_password_reset                                             PASS (0.00s)
  test_email_verification                                         PASS (0.00s)

SessionsControllerTest
  test_should_get_index                                           PASS (0.26s)
  test_should_get_new                                             PASS (0.00s)
  test_should_sign_in                                             PASS (0.26s)
  test_should_sign_out                                            PASS (0.26s)
  test_should_not_sign_in_with_wrong_credentials                  PASS (0.25s)

Finished in 11.94632s
34 tests, 61 assertions, 0 failures, 0 errors, 0 skips

```

Far better! Now we know how is the test suite organized. 

I personnally feel much better this way 😊 Your tastes may vary of course.


## Summary

Now we know how to install a full set of test examples with Rails, and how change the way the report is displayed in the CLI.

That was a quick and easy tutorial. We now run any kind of test locally with a more readable report, with only 3 lines of code.

Enjoy!

David.

