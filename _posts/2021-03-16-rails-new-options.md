---
title: Rails new app, options, and minimalistic approach
author: david
date: 2021-03-16 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Rails new app, options, and minimalistic approach
---

## How to create a new Rails app

Let's see the default way to create a new Rails app.

It will create a default new app with 21 gems included. The installation process will last a few minutes. Amongst other things, it will create files, directories, and run a first webpack-based compilation.

Prerequisite : ruby, bundler, rails, node, and yarn must be installed.

Just run :
 
```shell
$> rails new myapp
```

And go for a coffee break ☕

## List of all available options

To list all available options, simply run rails new --help. As the time of writing (Rails 6.1.3) it will output :

```shell
$> rails new --help
Usage:
  rails new APP_PATH [options]

Options:
      [--skip-namespace], [--no-skip-namespace]              # Skip namespace (affects only isolated engines)
      [--skip-collision-check], [--no-skip-collision-check]  # Skip collision check
  -r, [--ruby=PATH]                                          # Path to the Ruby binary of your choice
                                                             # Default: /Users/david/.rbenv/versions/3.0.0/bin/ruby
  -m, [--template=TEMPLATE]                                  # Path to some application template (can be a filesystem path or URL)
  -d, [--database=DATABASE]                                  # Preconfigure for selected database (options: mysql/postgresql/sqlite3/oracle/sqlserver/jdbcmysql/jdbcsqlite3/jdbcpostgresql/jdbc)
                                                             # Default: sqlite3
      [--skip-gemfile], [--no-skip-gemfile]                  # Don't create a Gemfile
  -G, [--skip-git], [--no-skip-git]                          # Skip .gitignore file
      [--skip-keeps], [--no-skip-keeps]                      # Skip source control .keep files
  -M, [--skip-action-mailer], [--no-skip-action-mailer]      # Skip Action Mailer files
      [--skip-action-mailbox], [--no-skip-action-mailbox]    # Skip Action Mailbox gem
      [--skip-action-text], [--no-skip-action-text]          # Skip Action Text gem
  -O, [--skip-active-record], [--no-skip-active-record]      # Skip Active Record files
      [--skip-active-job], [--no-skip-active-job]            # Skip Active Job
      [--skip-active-storage], [--no-skip-active-storage]    # Skip Active Storage files
  -P, [--skip-puma], [--no-skip-puma]                        # Skip Puma related files
  -C, [--skip-action-cable], [--no-skip-action-cable]        # Skip Action Cable files
  -S, [--skip-sprockets], [--no-skip-sprockets]              # Skip Sprockets files
      [--skip-spring], [--no-skip-spring]                    # Don't install Spring application preloader
      [--skip-listen], [--no-skip-listen]                    # Don't generate configuration that depends on the listen gem
  -J, [--skip-javascript], [--no-skip-javascript]            # Skip JavaScript files
      [--skip-turbolinks], [--no-skip-turbolinks]            # Skip turbolinks gem
      [--skip-jbuilder], [--no-skip-jbuilder]                # Skip jbuilder gem
  -T, [--skip-test], [--no-skip-test]                        # Skip test files
      [--skip-system-test], [--no-skip-system-test]          # Skip system test files
      [--skip-bootsnap], [--no-skip-bootsnap]                # Skip bootsnap gem
      [--dev], [--no-dev]                                    # Set up the application with Gemfile pointing to your Rails checkout
      [--edge], [--no-edge]                                  # Set up the application with Gemfile pointing to Rails repository
      [--master], [--no-master]                              # Set up the application with Gemfile pointing to Rails repository main branch
      [--rc=RC]                                              # Path to file containing extra configuration options for rails command
      [--no-rc], [--no-no-rc]                                # Skip loading of extra configuration options from .railsrc file
      [--api], [--no-api]                                    # Preconfigure smaller stack for API only apps
      [--minimal], [--no-minimal]                            # Preconfigure a minimal rails app
  -B, [--skip-bundle], [--no-skip-bundle]                    # Don't run bundle install
  --webpacker, [--webpack=WEBPACK]                           # Preconfigure Webpack with a particular framework (options: react, vue, angular, elm, stimulus)
      [--skip-webpack-install], [--no-skip-webpack-install]  # Don't run Webpack install

Runtime options:
  -f, [--force]                    # Overwrite files that already exist
  -p, [--pretend], [--no-pretend]  # Run but do not make any changes
  -q, [--quiet], [--no-quiet]      # Suppress status output
  -s, [--skip], [--no-skip]        # Skip files that already exist

Rails options:
  -h, [--help], [--no-help]        # Show this help message and quit
  -v, [--version], [--no-version]  # Show Rails version number and quit

Description:
    The 'rails new' command creates a new Rails application with a default
    directory structure and configuration at the path you specify.

    You can specify extra command-line arguments to be used every time
    'rails new' runs in the .railsrc configuration file in your home directory,
    or in $XDG_CONFIG_HOME/rails/railsrc if XDG_CONFIG_HOME is set.

    Note that the arguments specified in the .railsrc file don't affect the
    defaults values shown above in this help message.

Example:
    rails new ~/Code/Ruby/weblog

    This generates a skeletal Rails installation in ~/Code/Ruby/weblog.
```

## Skip one or more features

If you want to skip one or more feature, for example, if you don't want turbolinks nor system tests, run

```shell
$> rails new myapp --skip-turbolink --skip-system-test
```

If there are too many options you want to skip, below command will create an app according to options. 

```shell
$> rails new myapp --rc=options
```

"options" here is a file that contains any flag you need.

## Skip (almost) all features

There's now a new way (since Rails 6.1) to create a minimalist Rails app. It build a new app in a few seconds, with only 7 gems (at the time of writing).
```shell
$> rails new myapp --minimal
```

Here is the Gemfile created :
```ruby
source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'rails', '~> 6.1.3'
gem 'sqlite3', '~> 1.4'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '~> 3.3'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

```

Here is the list of what will **NOT** be included 

 - action_cable : integration of websockets into Rails.
 - action_mailbox : integration of e-mail inbox behaviour into Rails controllers.
 - action_mailer : send email with Rails. 
 - action_text : add the ability to put a HTML into Rails.
 - active_job : add the ability to create background jobs
 - active_storage : ability to upload files through 3rd party tools like AWS
 - bootsnap : boot a Rails app faster
 - jbuilder : build JSON response
 - spring : boot a Rails app faster (like bootsnap, but differently...)
 - system_tests : functional testing abilities
 - turbolinks : now deprecated and replaced by Turbo. Allow a SPA-mode navigation once app is loaded in browser.
 - webpack : the famous JavaScript bundler.

## Why you should rely on fresh, new, minimalist Rails application

Using the flag --minimal has the following advantages :

 - **You may reach a deep understanding of the default gems of your stack**. Take time to understand the few gems already included, then you will (very more likely) take time to understand the one you added. To the contrary, if you create a new Rails app without the "--minimal" flag, the risk is to end up with some fear of not understanding what's going on, plus some dead code, and annoying bugs - not caused by your code, but because of the frictions created by conflicting gems.
 
 - **It's very easy then to isolate a problem** that arise in your daily production app. Just recreate another minimalist app, outside your repository, and put inside (maybe by copy/pasting) all files to recreate the bug you're working on.

-  **Take time to see if you need any of the feature listed above**. Not all apps need to have the "e-mail inbox" features. Many developers skip the "spring" option. Maybe you will do some functional testing thanks to Cypress. Actually, **chances that you Rails app looks like the default one is next to zero**.