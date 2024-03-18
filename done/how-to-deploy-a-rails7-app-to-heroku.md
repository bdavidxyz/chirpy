---
title: How to deploy a Rails 7 app to Heroku
author: david
date: 2024-02-22 11:33:00 +0800
categories: [ruby]
tags: [ruby]
pin: false
math: false
mermaid: false
image:
  path: path
  alt: How to deploy a Rails 7 app to Heroku
---


## What is Heroku?

Heroku is the most well-known deployment platform, i.e. a place where to make your web application available to the public, on the wild Internet - so not just on your local machine.

Despite the raise of multiple competitors, for many years now, it is still unbeaten in terms of simplicity and ubiquity.

Heroku is so good, that they are able to increase prices despite the lack of roadmap - a miracle in the IT field.

I wrote about [HatchboxIO](/blog/ruby/my-honest-opinion-about-hatchbox) recently, which was a decent alternative for Rails users.

## The bare minimal Rails 7 application

We are going to ensure that the deployed app is able to handle JS, CSS, and relational database. I see too many tutorials where a "Hello world" page is considered good enough. I personaly advise to try a little more than that, in order to compare deployment platforms from a broader perspective : assets compilation, database, seeding, and so on.

## Prerequisites for this tutorial

```shell
ruby -v  # 3.3.0
rails -v  # 7.1.3
bundle -v  # 2.4.10
node -v # 20.11.0
yarn --version # 1.22.21
git --version # 2.34.1
psql --version # 14.11
```

## Build a simple Rails app

Ok we take the most simple use case, so let's use _Boring Rails_™ here

```shell
mkdir myapp && cd myapp 
echo "source 'https://rubygems.org'" > Gemfile
echo "gem 'rails', '7.1.3.2'" >> Gemfile
bundle install

bundle exec rails new . --force --database=postgresql -j=esbuild -c=tailwind
```

So now we have a production-ready database (postgre), a JS builder (esbuild), a real-world framework (tailwind)

## Add an authentication workflow

In order to have some logic, as well as a populated database, let's add an authentication gem.

```shell
bundle add authentication-zero
bin/rails generate authentication
bin/rails db:create db:migrate
```

## The bare minimal CSS and JS

Just add a little bit of Tailwind classes on one element to see if CSS will work properly

Inside `app/views/sessions/new.html.erb`, change the form submit as follow :

```erb
  <div data-controller="hello">
    <%= form.submit "Sign in", class: "text-white bg-blue-700 hover:bg-blue-800 focus:outline-none focus:ring-4 focus:ring-blue-300 font-medium rounded-full text-sm px-5 py-2.5 text-center me-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800" %>
  </div>
```

And change `app/javascript/controllers/hello_controller.js` as follow :

```js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Stimulus is working!")
  }
}
```

## The Procfile

The Procfile is an easy-to-understand text file, where you describe what will be run on each release

Good news : you already have a Procfile.dev file for local developments.

```shell
web: env RUBY_DEBUG_OPEN=true bin/rails server
js: yarn build --watch
css: yarn build:css --watch
```

This is the local Procfile.dev - even if you don't know about it, you can guess it launches a server, and watch changes about js and css.

Now add `Procfile` file like this, at the root of your project :

```shell
web: bundle exec puma -C config/puma.rb
release: bin/rails db:migrate
```

## Before Heroku - check that everything is working locally

Launch your app locally with

```shell
bin/dev
```

And open your browser at localhost:3000

You should see the blue button for "sign in", meaning that Tailwind is working locally.

You should see "Stimulus is working!" in the web dev console of the browser.

Try to login with credentials - it should show an error.

Good! So now we have something that is closer of an actual production webapp.

## Deploy to Heroku


First, install the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli) on your local machine.

Then, stay at the root of "myapp" in your terminal, and type :

```shell
heroku --version # Should print current Heroku CLI version
heroku login  
```

Now credit card is required (alas) at [Heroku billing page](https://dashboard.heroku.com/account/billing)

Then

```shell
heroku create 
heroku addons 
# Should print : No add-ons for app MyApp
heroku addons:create heroku-postgresql:mini
heroku buildpacks:add --index 1 heroku/ruby
heroku buildpacks:add --index 2 heroku/nodejs
```

And finally

```shell
git add . && git commit -m 'initial commit'
git push heroku main
```

Wait for one minute or two, you should see the build logs in your terminal...

and...

## Done!

Now you should see your app under the heroku dashboard, which is pretty intuitive.

Open the app, check again that the CSS and JS are working properly.

## Summary

Setting up a real-world application was actually longer than deploying an app to Heroku, which is still nowadays the best cross-deployment app for junior developer. I wouldn't advise to stick to Heroku for a long time. Once you get your first users, it may be time to consider another platform, since it's really not cheap once you meet success. 

Good luck to all, health first!

David.