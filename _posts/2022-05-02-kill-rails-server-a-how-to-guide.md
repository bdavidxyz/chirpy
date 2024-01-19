---
title: Kill Rails server, a how-to guide
author: david
date: 2022-05-02 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:Kill%20Rails%20server%20%20a%20how-to%20guide,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:A%20Ruby-on-Rails%20tutorial,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Kill Rails server, a how-to guide
---

## Short answer

If you local Rails server is running on port 3000, you have first to discover what PID is used :

```bash
$> lsof -wni tcp:3000
COMMAND   PID  USER   FD   TYPE            DEVICE SIZE/OFF NODE NAME
ruby    51195 shino   10u  IPv4 0x3cd31f222cb761f      0t0  TCP 127.0.0.1:hbci (LISTEN)
ruby    51195 shino   11u  IPv6 0x3cd31f215db234f      0t0  TCP [::1]:hbci (LISTEN)
```

The column that matters is "PID". The relevant number is 51195 here. On your computer it will probably be another number, but for our example, the solution will be


```shell
kill -9 51195
```

Replace 51195 by your own PID and that's it.

## Alternative : use the shutup gem

If this is a problem that happends too frequently, you can install a gem dedicated to this problem : `shutup`. Repository and documentation available [here](https://github.com/lorenzosinisi/shutup)

## Tutorial from scratch

If you want to test the problem "from scratch", here is a small tutorial. Ruby 3 and Rails 7 will be used.

### Prerequisites

```bash  
$> ruby -v  
ruby 3.0.0p0 // you need at least version 3 here  
$> bundle -v  
Bundler version 2.2.11  
$> npm -v  
8.3.0 // you need at least version 7.1 here  
$> yarn -v  
1.22.10
```

### Install fresh new Rails app

```bash  
$> mkdir kill_rails && cd kill_rails  
$/kill_rails> echo "source 'https://rubygems.org'" > Gemfile  
$/kill_rails> echo "gem 'rails', '7.0.0'" >> Gemfile  
$/kill_rails> bundle install  
$/kill_rails> bundle exec rails new . --force
$/kill_rails> bundle update  
$/kill_rails> bin/rails db:create  
$/kill_rails> bin/rails db:migrate  
```

Check everything is working by running 

```bash  
$/kill_rails> bin/rails server
=> Booting Puma
=> Rails 7.0.0 application starting in development 
=> Run `bin/rails server --help` for more startup options
Puma starting in single mode...
* Puma version: 5.5.2 (ruby 3.0.0-p0) ("Zawgyi")
*  Min threads: 5
*  Max threads: 5
*  Environment: development
*          PID: 88968
* Listening on http://127.0.0.1:3000
* Listening on http://[::1]:3000
Use Ctrl-C to stop
```

**Side note** The PID is actually displayed **once** in the verbose logging that appears right after you started the server. See above.

Server should run locally without error, and the default Rails page application should appear at [http://localhost:3000](http://localhost:3000)

Now stop your local server.

Open the Gemfile and add

```ruby
gem "shutup", group: :development
```  

Then
```bash  
$/kill_rails> bundle install
```

## Check that the Rails server runs properly

Then restart your local Rails app

Then
```bash  
$/kill_rails> bin/rails server
=> Booting Puma
=> Rails 7.0.0 application starting in development 
=> Run `bin/rails server --help` for more startup options
Puma starting in single mode...
* Puma version: 5.5.2 (ruby 3.0.0-p0) ("Zawgyi")
*  Min threads: 5
*  Max threads: 5
*  Environment: development
*          PID: 89102
* Listening on http://127.0.0.1:3000
* Listening on http://[::1]:3000
Use Ctrl-C to stop
```

Notice that PID has changed : now the value is 89102.

Leave your terminal window "as-is", with the local web server running. 

## Kill the local Rails web server

Open another terminal window.

Given the PID we just noticed, and the 1st paragraph of this tutorial, we can type :

```bash
$> lsof -wni tcp:3000
COMMAND   PID  USER   FD   TYPE            DEVICE SIZE/OFF NODE NAME
ruby    89102 shino   10u  IPv4 0x3cd31f229b0f9df      0t0  TCP 127.0.0.1:hbci (LISTEN)
ruby    89102 shino   11u  IPv6 0x3cd31f215db1d2f      0t0  TCP [::1]:hbci (LISTEN)
```

You can notice the PID is 89102, as expected

Type
```shell
kill -9 89102
```

And go back to the first terminal window. You should see something like this :

```shell
Killed: 9
$/kill_rails>
```

The last instruction shows that the local Rails server was actually killed.

## Kill the Rails server again, using the gem


```shell
$/kill_rails>  bin/rails server
=> Booting Puma
=> Rails 7.0.0 application starting in development 
=> Run `bin/rails server --help` for more startup options
Puma starting in single mode...
* Puma version: 5.5.2 (ruby 3.0.0-p0) ("Zawgyi")
*  Min threads: 5
*  Max threads: 5
*  Environment: development
*          PID: 90704
* Listening on http://127.0.0.1:3000
* Listening on http://[::1]:3000
Use Ctrl-C to stop
```

The PID value is now 90704.

Open another terminal window, and type
```shell
$kill_rails> shutup
Killed process id: 90704
$kill_rails>
```

Ok ! what just happened is clear enough :)

Go back to the terminal window where you server was running :
```shell
Killed: 9
$/kill_rails>
```

Same result as above, hopefully.

Enjoy !