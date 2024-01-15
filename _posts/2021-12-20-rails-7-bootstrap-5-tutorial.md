---
title: Rails 7, Bootstrap 5 tutorial, fear and relief
author: david
date: 2021-12-20 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Rails 7, Bootstrap 5 tutorial, fear and relief
---

## 0. A big warning  
  
At <strong>[BootrAils](https://bootrails.com)</strong>, we are very excited that Rails 7 is out since mid-december, 2021. The frontend assets management is once again completely different. Rails 6 almost dropped Sprockets in favor of Webpack  - see [this article](https://bootrails.com/blog/webpacker-vs-sprockets/), now Rails 7 almost dropped Webpack in favor of jsbundling-rails (with esbuild) + import maps + Sprockets.  
  
So we, as Rails developers, have choices. For this tutorial, we will use the default Rails 7 options - but we are not sure you should. That's the **fear**. Relief will be for the end of the article.
  
If you want a full setup of Bootstrap 5 with Webpacker, see [that other article](https://bootrails.com/blog/rails-bootstrap-tutorial/).
  
## 1. Prerequisites  
  
Check that you have ruby 3 already installed. Check you also have bundler installed, and npm above version 7  
  
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
  
Any upper versions should work.  
  
  
## 2. Create an isolated, new Rails 7 app  
  
```bash  
$> mkdir myapp && cd myapp  
$/myapp> echo "source 'https://rubygems.org'" > Gemfile  
$/myapp> echo "gem 'rails', '7.0.0'" >> Gemfile  
$/myapp> bundle install  
$/myapp> bundle exec rails new . --force --css=bootstrap -d=postgresql  
```  

Open Gemfile, and replace line

```ruby
gem "turbo-rails"
```  
by
```ruby
gem "turbo-rails", '~> 1.0.0'
```  
This step is a buggy behaviour, due to the fact that Rails 7 is quite new as the time of writing.

Continue inside bash :

```bash
$/myapp> bundle update  
$/myapp> bin/rails db:create  
$/myapp> bin/rails db:migrate  
```

## 3. Is Bootstrap v5 already installed ? a check  
  
In this paragraph, we will not write any code, instead, we will read what is already installed for us.  
  
Some good news : maybe you noticed the `--css=bootstrap` option above. This means the last Bootstrap version is already installed.  
  
Let's check where this happens :  
  
package.json  
```js  
// inside package.json  
{  
"name": "app",  
"private": "true",  
"dependencies": {  
    "@hotwired/stimulus": "^3.0.1",  
    "@hotwired/turbo-rails": "^7.1.0",  
    "@popperjs/core": "^2.11.0",  
    "bootstrap": "^5.1.3",  
    "esbuild": "^0.14.5",  
    "sass": "^1.45.0"  
  }  
}  
```  
  
Ok ! Bootstrap 5 and its dependencies is properly installed inside package.json  
  
```scss  
// inside app/assets/stylesheets/application.bootstrap.scss  
@import 'bootstrap/scss/bootstrap';  
```  
  
Great ! Standard import of bootstrap scss source, this will allow us fine tuning later.  
  
```js  
// inside app/javascript/application.js  
// Entry point for the build script in your package.json  
import "@hotwired/turbo-rails"  
import "./controllers"  
import * as bootstrap from "bootstrap"  
```  
  
Ok ! JavaScript for Bootstrap is now loaded - even if no initialisation happens so far.  
  
Open app/views/layouts/application.html.erb  
  
```erb  
<!DOCTYPE html>  
<html>  
  <head>  
      <title>Myapp</title>  
      <meta name="viewport" content="width=device-width,initial-scale=1">  
      <%= csrf_meta_tags %>  
      <%= csp_meta_tag %>  
      
      <%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>  
      <%= javascript_include_tag "application", "data-turbo-track": "reload", defer: true %>  
  </head>  
  
  <body>  
    <%= yield %>  
  </body>  
</html>  
```  
  
The interesting lines are `javascript_include_tag`and `stylesheet_link_tag`. They allow us to profit from initial SCSS and JS files in each template that inherits from the default layout.  
  
## Create bare minimal Bootstrap 5 HTML  
  
Create a controller :  
```ruby  
# inside app/controllers/home_controller.rb  
class HomeController < ApplicationController  
end  
```  
  
Configure a default route :  
  
```ruby  
# inside config/routes.rb  
Rails.application.routes.draw do  
  get "home/index"  
  root to: "home#index"  
end  
```  
  
Now create a view tailored for Bootstrap 5 : just copy/paste the code below into *app/views/home/index.html.erb*  
  
```html  
<!-- inside app/views/home/index.html.erb -->
<h1>Welcome, this is the home page</h1>  
  
<button type="button" 
        class="btn btn-lg btn-danger" 
        data-bs-toggle="popover" 
        title="Popover title" 
        data-bs-content="Amazing content, right ?">
        Click to toggle popover
</button>  
```  
  
This HTML should show a popover when clicking the red button, only if  
  
- Bootstrap CSS is properly configured,  
- Bootstrap JS is loaded and initialized.  
  
Great ! This bare minimalistic example will ensure everything works properly.  
  
## Bootstrap 5, Rails 7, locally : let's start !  
  
```bash  
$/myapp> ./bin/dev  
  
17:24:24 web.1 | started with pid 26889  
17:24:24 js.1 | started with pid 26890  
17:24:24 css.1 | started with pid 26891  
17:24:24 css.1 | yarn run v1.22.10  
17:24:24 js.1 | yarn run v1.22.10  
17:24:24 css.1 | $ sass ./app/assets/stylesheets/application.bootstrap.scss ./app/assets/builds/application.css --no-source-map --load-path=node_modules --watch  
17:24:24 js.1 | $ esbuild app/javascript/*.* --bundle --sourcemap --outdir=app/assets/builds --watch  
17:24:25 js.1 | [watch] build finished, watching for changes...  
17:24:25 css.1 | Sass is watching for changes. Press Ctrl-C to stop.  
17:24:25 css.1 |  
17:24:26 web.1 | => Booting Puma  
17:24:26 web.1 | => Rails 7.0.0 application starting in development  
17:24:26 web.1 | => Run `bin/rails server --help` for more startup options  
17:24:26 web.1 | Puma starting in single mode...  
17:24:26 web.1 | * Puma version: 5.5.2 (ruby 3.0.0-p0) ("Zawgyi")  
17:24:26 web.1 | * Min threads: 5  
17:24:26 web.1 | * Max threads: 5  
17:24:26 web.1 | * Environment: development  
17:24:26 web.1 | * PID: 26889  
17:24:26 web.1 | * Listening on http://127.0.0.1:3000  
17:24:26 web.1 | * Listening on http://[::1]:3000  
17:24:26 web.1 | Use Ctrl-C to stop  
```  
  
Great ! the console indicates that we should go to localhost:3000 to see what is happening. Let's go :  
  
<figure>  
<img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/v1639673014/rails/bs5r7_a.png" loading="lazy" alt="localhost">  
<figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">localhost</figcaption>  
</figure>  
  
Try to click the button. Nothing happens.  
  
## Adding custom Bootstrap-based JavaScript into Rails  
  
Let's follow the Bootstrap docs here :  
https://getbootstrap.com/docs/5.1/components/popovers/#example-enable-popovers-everywhere  
  
And inject it into Rails  
  
```js  
// Inside app/javascript/application.js  
import "@hotwired/turbo-rails"  
import "./controllers"  
import * as bootstrap from "bootstrap"  
  
let popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))  
let popoverList = popoverTriggerList.map(function (popoverTriggerEl) {  
  return new bootstrap.Popover(popoverTriggerEl)  
})  
```  
  
  
Now reload your browser, and click the big red button  
  
<figure>  
<img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/v1639673014/rails/bs5r7_b.png" loading="lazy" alt="localhost">  
<figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">localhost</figcaption>  
</figure>  
  
Great ! it works  
  
## Add custom SCSS  
  
```scss  
// inside app/assets/stylesheets/application.bootstrap.scss  
$h1-font-size: 1rem; // this line was added  
@import 'bootstrap/scss/bootstrap';  
```  
  
Reload your browser  
  
<figure>  
<img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/v1639755970/rails/bs5r7_c.png" loading="lazy" alt="A smaller h1 title">  
<figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">A smaller h1 title</figcaption>  
</figure>  
  
## Rails 7 and Bootstrap 5 are now going to production : deploy to Heroku  
  
```bash  
$/myapp> heroku login  
$/myapp> heroku create  
$/myapp> echo "web: bundle exec puma -C config/puma.rb" >> Procfile  
$/myapp> bundle lock --add-platform x86_64-linux  
$/myapp> heroku addons:create heroku-postgresql:hobby-dev  
$/myapp> heroku buildpacks:add heroku/ruby  
$/myapp> heroku buildpacks:add heroku/nodejs  
$/myapp> git add . && git commit -m 'ready for prod'  
$/myapp> git push heroku main  
```  
  
The buildpacks are adding an environment to your production machine. The flag --add-platform x86_64-linux is here for compatibility reasons with Heroku. Apart from these, each command above is pretty verbose, you won't be lost.  
  
Installation will last 1 or 2 minutes. You should see the URL where your production-ready app is deployed at the bottom of your terminal. But wait a minute before opening it.  
  
Enter :  
  
```bash  
$/myapp> heroku run rails db:migrate  
```  
  
Now open your browser (not localhost, but the production URL provided by Heroku). You should see the title and button, and if you click the button... What happened ;) ?  

## A relief, yet to be improved 

 The relief is that compared to the previous blog article with the [webpacker settings](https://bootrails.com/blog/rails-bootstrap-tutorial/), Bootstrap 5 almost works out-of-the-box with Rails 7. However, the number of tools to achieve the result is not entirely satisfying. We'll give explanations next week :)
  
Stay tuned !