---
title: "Rails 6, Bootstrap 5 , a tutorial"
author: david
date: 2021-03-02 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: "Rails 6, Bootstrap 5 , a tutorial"
---

## December 2021 update : Rails 7 and Bootstrap 5

There is a new article about Rails 7 and Bootstrap 5 : [https://www.bootrails.com/blog/rails-7-bootstrap-5-tutorial/](https://www.bootrails.com/blog/rails-7-bootstrap-5-tutorial/)

The article below is about Rails 6, Webpacker, and Bootstrap 5.
  
## Prerequisites  
  
Here are the tools I used for this tutorial. Older versions may work, but I didn't try.  
  
```shell  
$> ruby --version  
=> 3.0.0  
$> rails --version  
=> 6.1.3  
$> node --version  
=> 14.15.1  
$> yarn --version  
=> 1.22.10  
```  
  
## 1. Create new Rails app  
  
```shell  
$> rails new myapp && cd myapp  
```  
Now wait for a minute... okay ! you have now a fresh new default Rails app.  
  
## 2. Build a welcome page  
  
Create a controller as follow in app/controllers/welcome_controller.rb  
  
```ruby  
# inside app/controllers/welcome_controller.rb  
class WelcomeController < ApplicationController  
end  
```  
  
Configure a default route in config/routes.rb as follow  
  
```ruby  
# inside config/routes.rb  
Rails.application.routes.draw do  
  get "welcome/index"  
  root to: "welcome#index"  
end  
```  
  
Now we have to make this simple example **complex enough** 😬 to ensure all CSS, JavaScript component works. 

Don't worry, just copy/paste the code below into *app/views/welcome/index.html.erb*  
  
```html  
<!-- inside app/views/welcome/index.html.erb -->  
<div class="collapse" id="navbarToggleExternalContent">
  <div class="bg-dark p-4">
    <h5 class="text-white h4">Collapsed content</h5>
    <span class="text-muted">Toggleable via the navbar brand.</span>
  </div>
</div>
<nav class="navbar navbar-dark bg-dark">
  <div class="container-fluid">
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarToggleExternalContent" aria-controls="navbarToggleExternalContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
  </div>
</nav>

<main>
  <section class="py-5 text-center container">
    <div class="row py-lg-5">
      <div class="col-lg-6 col-md-8 mx-auto">
        <h1 class="fw-light">Album example</h1>
        <p class="lead text-muted">Something short and leading about the collection below—its contents, the creator, etc. Make it short and sweet, but not too short so folks don’t simply skip over it entirely.</p>
        <p>
          <a href="#" class="btn btn-primary my-2">Main call to action</a>
          <a href="#" class="btn btn-secondary my-2">Secondary action</a>
        </p>
      </div>
    </div>
  </section>
</main>
```  
  
Ensure the application works by running  
  
```shell  
$/myapp> bin/rails server  
```  
  
And open localhost:3000 to your browser  
  
<figure>
  <img style="display:block;float:none;margin-left:auto;margin-right:auto;width:90%" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/v1614073025/blog/raw_data.png" loading="lazy" alt="Raw image, Bootstrap v5 is not yet installed">
  <figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:90%">Raw image, Bootstrap v5 is not yet installed</figcaption>
</figure>   
    
Ok, no style so far.  
  
## 3. Choose a front-end manager  
  
For historical reasons, Rails 6 has two different tools to manage frontend assets (CSS, JavaScript, images, etc). The old one is named "Sprockets", and is not much used outside the Rails scope. The new one is named "Webpacker", and relies on mature, widely used Webpack. Therefore, I don't recommend using Sprockets anymore for new projects, especially since version 5 of webpacker. It is a lot more stable, and can handle multiple packs.  
  
Ensure your Gemfile include at least version 5 of webpacker :  
  
```ruby  
gem 'webpacker', '~> 5.0'  
```  
If not, include version 5 as above and run "bundle install"  
  
Now we want webpacker to handle **all our assets**, not just JavaScript. Rename `app/javascript` to `app/frontend`, like this :  
  
```shell  
$/myapp> mv app/javascript app/frontend  
```  
In webpacker.yml, warn webpack that we changed the name of the assets folder :  
  
```yml  
# Inside webpacker.yml, first lines  
default: &default  
source_path: app/frontend # Change here  
```  
  
## 4. Install Bootstrap v5  
  
Add latest Bootstrap version, and PopperJs (a mandatory dependency) as follow :  
  
```shell  
$/myapp> yarn add bootstrap@5.0.0-beta2  
$/myapp> yarn add @popperjs/core@2.0.0-alpha.1  
```  
  
## 5. Inject Bootstrap into your application  
  
### 5a) Inject Boostrap's JS files  
  
Create JS file : app/frontend/js/bootstrap_js_files.js, and import Bootstrap-related JS files, as follow :  
  
```shell  
$/myapp> mkdir app/frontend/js && touch app/frontend/js/bootstrap_js_files.js  
```  
  
```js  
// inside app/frontend/js/bootstrap_js_files.js  
  
// import 'bootstrap/js/src/alert'  
// import 'bootstrap/js/src/button'  
// import 'bootstrap/js/src/carousel'  
import 'bootstrap/js/src/collapse'  
import 'bootstrap/js/src/dropdown'  
// import 'bootstrap/js/src/modal'  
// import 'bootstrap/js/src/popover'  
import 'bootstrap/js/src/scrollspy'  
// import 'bootstrap/js/src/tab'  
// import 'bootstrap/js/src/toast'  
// import 'bootstrap/js/src/tooltip'  
```  
  
Note we don't import all Bootstrap JS files, we only import the ones needed by the project (for the navbar).  
  
Now import this file into the main JS file app/frontend/packs/application.js :  
  
```js  
// inside app/frontend/packs/application.js  
  
// Add this line  
import '../js/bootstrap_js_files.js'  
```  
  
### 5b) inject Bootstrap's styles  
  
Create the main CSS file  
  
```shell  
$/myapp> touch app/frontend/packs/application.scss  
```  
  
Inside, import Bootstrap  
  
```scss  
// inside app/frontend/packs/application.scss  
  
// Just a quick ugly style to see if our CSS works  
h1 {  
  text-decoration: underline;  
}  
  
// Import Bootstrap v5  
@import "~bootstrap/scss/bootstrap";  
```  
  
Now tell Rails where is your main CSS file, inside app/views/layouts/application.html.erb  
  
```html  
<!DOCTYPE html>
<html>
  <head>
    <title>Myapp</title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <!-- Warning !! ensure that "stylesheet_pack_tag" is used, line below -->
    <%= stylesheet_pack_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>
  </head>

  <body>
    <%= yield %>
  </body>
</html>
```  
  
### 5c) Check everything works  
  
Stop your Rails server. We've changed a lot of frontend assets, so we do a little cleanup/recompile before to restart our rails server.  
  
```shell  
$/myapp> bin/rails assets:clobber  
$/myapp> bin/rails webpacker:compile  
$/myapp> bin/rails server  
```  
And open browser at localhost:3000.  
- If the style looks like Bootstrap, yay ! Our import of Bootstrap's CSS file has worked.  
- If clicking on the hamburger menu means toggling navbar, yay ! Our import of Bootstrap's JS file has worked.  
  
<figure>
  <img style="display:block;float:none;margin-left:auto;margin-right:auto;width:90%" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/v1614076337/blog/good_result.png" loading="lazy" alt="it works!">
  <figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:90%">it works!</figcaption>
</figure>   
    

## 6 More to come  
  
Final code can be found [here](https://github.com/bdavidxyz/bootstraprails). That's all for today, given the number of steps involved to get this result. However, I'd like to add :  
- How to copy/paste SCSS file to get a deep Bootstrap customisation,  
- How to manage images  
- How to manage fonts  
- How to optimize assets  
- Probably other things I'm not thinking about right now. Stay tuned !