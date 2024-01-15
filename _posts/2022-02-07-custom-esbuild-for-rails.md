---
title: Custom esbuild for Rails
author: david
date: 2022-02-07 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Custom esbuild for Rails
---

## 0. Motivation

At <strong>[BootrAils](https://bootrails.com)</strong> we are currently considering dropping the entire default "Rails Way" to manage frontend assets (CSS, images, JS, etc), by replacing it with ViteJS. (See this article : [https://bootrails.com/blog/vitejs-rails-a-wonderful-combination/](https://bootrails.com/blog/vitejs-rails-a-wonderful-combination/)).  
  
However, for those interested in this "Rails Way", here is a trick to allow more esbuild configuration.  
  
In classical Rails 7 apps, instead of Webpacker, jsbundling does most of the job. Under the hood, esbuild is wrapped into jsbundling. But what if you want to customize this build ?

## 1. Prerequisites

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
  
Any upper versions should work.  

## Build a default Rails 7 application

```bash  
mkdir customesbuild && cd customesbuild  
echo "source 'https://rubygems.org'" > Gemfile  
echo "gem 'rails', '7.0.0'" >> Gemfile  
bundle install  
bundle exec rails new . --force --css=bootstrap

# Create a default controller
echo "class WelcomeController < ApplicationController" > app/controllers/welcome_controller.rb
echo "end" >> app/controllers/welcome_controller.rb

# Create a default route
echo "Rails.application.routes.draw do" > config/routes.rb
echo '  get "welcome/index"' >> config/routes.rb
echo '  root to: "welcome#index"' >> config/routes.rb
echo 'end' >> config/routes.rb

# Create a default view
mkdir app/views/welcome
echo '<h1>This is h1 title</h1>' > app/views/welcome/index.html.erb

# Create database and schema.rb
bin/rails db:create
bin/rails db:migrate

```

**Side note 1** For Rails 7.0.0, if you don't specify any css framework, Rails will **not** give you any jsbundling by default. You will have to rely on Sprockets (for CSS) and importmaps (for JS)

**Side note 2** If you want to create new Rails application more easily, we already wrote an article about this here : [https://bootrails.com/blog/how-to-create-tons-rails-applications/](https://bootrails.com/blog/how-to-create-tons-rails-applications/)

## Check everything is working properly

Modify application.js as follow 

```js
// inside app/javascript/application.js
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"

console.log("I am the default application.js")
```

And go to your terminal, and enter

```shell
./bin/dev
```

Now open your browser, the title displayed should be big enough, meaning CSS is loaded correctly (we relied on Bootstrap here), and if you open the Developer's Tool, in the "Console" Tab, you should be able to see "I am the default application.js". That means our JavaScript is also properly configured.


## Modify package.json

Default package.json should look like this

```js
{
  "name": "app",
  "private": "true",
  "dependencies": {
    "@hotwired/stimulus": "^3.0.1",
    "@hotwired/turbo-rails": "^7.1.0",
    "@popperjs/core": "^2.11.2",
    "bootstrap": "^5.1.3",
    "esbuild": "^0.14.11",
    "sass": "^1.48.0"
  },
  "scripts": {
    "build": "esbuild app/javascript/*.* --bundle --sourcemap --outdir=app/assets/builds",
    "build:css": "sass ./app/assets/stylesheets/application.bootstrap.scss ./app/assets/builds/application.css --no-source-map --load-path=node_modules"
  }
}
```

Now replace the property named "build" like this :

```js
{
  "name": "app",
  "private": "true",
  "dependencies": {
    "@hotwired/stimulus": "^3.0.1",
    "@hotwired/turbo-rails": "^7.1.0",
    "@popperjs/core": "^2.11.2",
    "bootstrap": "^5.1.3",
    "esbuild": "^0.14.11",
    "sass": "^1.48.0"
  },
  "scripts": {
    "build": "node esbuild.config.js",
    "build:css": "sass ./app/assets/stylesheets/application.bootstrap.scss ./app/assets/builds/application.css --no-source-map --load-path=node_modules"
  }
}
```

Great ! We don't have any file named esbuild.config.js, so let's build it at the root of our project.


## Create esbuild.config.js

Now create esbuild.config.js at the root of your project, as follow :

```js
const path = require('path');

require("esbuild").build({
  entryPoints: ["application.js"],
  bundle: true,
  outdir: path.join(process.cwd(), "app/assets/builds"),
  absWorkingDir: path.join(process.cwd(), "app/javascript"),
  watch: true,
  // custom plugins will be inserted is this array
  plugins: [],
}).catch(() => process.exit(1));

```

As you may have noticed, the "plugins" property allows you to add any esbuild plugin available in the npm ecosystem. All other properties can be added/modified as wanted of course. But at least you have the bare minimum that doesn't hurt the default Rails frontend assets management.

## Restart your local development server

Stop the local server. Restart it : in your terminal, type

```shell
./bin/dev
```

You should see `node esbuild.config.js --watch` somewhere in the middle of the logs :)

```shell
./bin/dev
14:25:45 web.1  | started with pid 69446
14:25:45 js.1   | started with pid 69447
14:25:45 css.1  | started with pid 69448
14:25:45 js.1   | yarn run v1.22.10
14:25:45 css.1  | yarn run v1.22.10
14:25:45 css.1  | $ sass ./app/assets/stylesheets/application.bootstrap.scss ./app/assets/builds/application.css --no-source-map --load-path=node_modules --watch
14:25:45 js.1   | $ node esbuild.config.js --watch
14:25:46 web.1  | => Booting Puma
14:25:46 web.1  | => Rails 7.0.0 application starting in development 
14:25:46 web.1  | => Run `bin/rails server --help` for more startup options
14:25:46 css.1  | Sass is watching for changes. Press Ctrl-C to stop.
```

That means our own esbuild config was properly read by Rails.

Check in your browser that CSS and JS work properly, as above.

Done !