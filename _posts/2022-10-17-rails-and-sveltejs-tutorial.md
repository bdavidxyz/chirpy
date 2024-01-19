---
title: Ruby-on-Rails and SvelteJS tutorial
author: david
date: 2022-10-17 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:Ruby-on-Rails%20and%20SvelteJS%20tutorial,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:A%20Ruby-on-Rails%20tutorial,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Ruby-on-Rails and SvelteJS tutorial
---

## SvelteJS vs others

Svelte is the new paradigm of frameworks. Since it came to life in 2016, developers have argued a lot about it and compared it to its big brothers: React, Angular and Vue. In this article, we will deep dive into how this new framework works, its benefits and how to implement it with Ruby-on-Rails.

## What is SvelteJS ?

Svelte is a framework without being a framework. And... What does this mean? In short, it means that Svelte is a **compiler** itself. To understand this concept, we are going to try to put it as simply as possible.

Frameworks are responsible for taking the code of an application and executing a set of tasks so that users can interact with it in the browser. As you might already know, the code is built into components (HTML, CSS and JS), which are translated into a virtual DOM, compared with the previous DOM and then updated to the Browser DOM. All this, by using techniques such as the **<a href="https://www.geeksforgeeks.org/reactjs-reconciliation/" target="_blank" >Reconciliation and Diffing Algorithm</a>**.

We are not going to analyze these procedures, because what really matters for now is that Svelte takes away all these reconciliation tasks by being a compiler. It works with the same code components, and during the build process, converts them into **optimized vanilla JavaScript**, that updates the browser DOM directly. It simplifies the process for the browser and it is faster than any other framework.

<figure>  
  <img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="https://res.cloudinary.com/shinocloud/image/upload/v1663080276/rails/svelte_react_comparison_igum3a.png" loading="lazy" title="SvelteJS vs others" alt="svelte vs react" width="500" height="auto">  
  <figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">svelte vs react</figcaption>  
</figure>


To wrap up the characteristics of this technology and understand why you should consider it as a developer, let's take a look at its **main advantages and disadvantages**:

### Svelte : advantages
- It has the smallest and fastest bundles. The **Svelte bundle size is 1.6KB** while React is 42.2KB.
- It has proved a very **good performance** and reactivity.
- Svelte is easy to learn and implement.

### Svelte : disadvantages

- Technology is still evolving and it has a **smaller community**.
- It has a **young library ecosystem**.
- Implementation means learning a new language and syntax logic. And consequently, there are fewer developers using it for now.

## Why combine both Rails and Svelte ?

Combining Svelte with Rails can be a great choice. Svelte simplifies code and makes it more efficient. Svelte syntax can cut in half the lines of code that are normally written with other frameworks, which aligns perfectly with Ruby's vision of keeping code simple and intuitive.

Svelte's popularity is increasing day by day, as developers' satisfaction rate is exceeding that of other frameworks such as React.

Moreover, Svelte is easy to implement and integrate with Ruby-on-Rails. We will take a look at how to do it now.

## Ruby-on-Rails application from scratch

In other articles we have seen [how to create a fresh new Rails application](https://bootrails.com/blog/rails-new-options/). However, we are going to review the process in order to get a clear idea of how to integrate Svelte into the application.

Remember that you should have an updated version of Rails and Ruby, as well as the **npm package**. Also, it is important to install/upgrade the **yarn package manager** by running:

**Prerequisites set up**

```ruby
$> ruby -v  
ruby 3.1.2p20 # Please use Ruby 3! 
$> rails -v  
Rails 7.0.2.4 # And Rails 7 to keep things fresh
$> bundle -v  
Bundler version 2.3.14 # Bundler 2.xx
$> npm install --global yarn 
# npm and yarn package managers
```

Once we have this, we are ready to start our new project.

**Create a new app with rails**

```ruby
bin/rails new svelte-app
```

**Go to the new directory to access the application**

```ruby
cd svelte-app
```

**Open the project in your source-code editor** (i.e. Visual Studio)

```ruby
code .
```

**Add svelte to the Gem File**

```ruby
# Gemfile ADD:
gem 'svelte-rails'
```

**Execute the commands below on the console**

```
bundle
bin/rails svelte:install
```

**Run the app on localhost**

```ruby
bin/rails s
```

## Rendering the Svelte app

Good job! We have created our new Rails app with Svelte. Before rendering the app we need to make one manual adjustment so that our Svelte code is executed in all the views of the application. Open the file `app/views/layouts/application.html.erb` and add a javascript_pack_tag 'hello_svelte' (line 10), so that it looks as below:

```ruby
# app/views/layouts/application.html.erb
<!DOCTYPE html>
<html>
  <head>
    <title>Demo</title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>
    <%= stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>
    <%= javascript_pack_tag 'hello_svelte' %>
  </head>

  <body>
    <%= yield %>
  </body>
</html>
```

Once this is done, we can start shaping our app by defining its [MVC Architecture](https://bootrails.com/blog/ruby-on-rails-mvc/). Let's create a controller by running:

```
rails generate controller demo index
```

And define the routes in the `config/routes.rb` file:

```ruby
Rails.application.routes.draw do
  get 'demo/index'
  root 'demo#index'
end
```

Run the rails server on localhost and see how magic happens!

<figure>  
  <img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="https://res.cloudinary.com/shinocloud/image/upload/v1663080276/rails/localhost_screenshot_svelte_1_qqofrv.png" loading="lazy" alt="localhost" width="200" height="auto">  
  <figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">localhost</figcaption>  
</figure>


You should go to the view file that has been automatically generated (in this case `app/views/demo/index.html.erb`), and delete the two lines to clean the view:

```html
# DELETE:
<h1>Demo#index</h1>
<p>Find me in app/views/demo/index.html.erb</p>
```

Now we are rendering the Svelte code according to the following files:

`hello_svelte.js` This file executes JavaScript and imports the Svelte component (in this case, the component below).

`app.svelte` This file is the Svelte component that contains 3 sections:
- The script
- The style (CSS)
- The Template (HTML output)

If we play a bit with both files, we can easily render this:

<figure>  
  <img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="https://res.cloudinary.com/shinocloud/image/upload/v1663080276/rails/localhost_screenshot_svelte_2_duhbni.png" loading="lazy" alt="localhost" width="200" height="auto">  
  <figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">localhost</figcaption>  
</figure>


Here you can see how we have modified the mentioned files:

```js
# app/javascript/packs/hello_svelte.js
import App from '../app.svelte'

document.addEventListener('DOMContentLoaded', () => {
  const app = new App({
    target: document.body,
    props: {
      name: 'Ruby',
      number: 1,
      frame: 'Svelte'
    }
  });

  window.app = app;
})
```

```html
# app/javascript/app.svelte
<script>
  export let name;
  export let number;
  export let frame;
</script>

<style>
  h1 {
    color: #4F345A;
  }

  .name-variable {
    color: #F4BFDB;
  }

  h3 {
    color: #EC0B43;

  }

  .frame-style {
    font-size: 40px;
    color: #4F345A;
  }
</style>

<h1>Hello! <span class="name-variable">My name is {name}!</span></h1>
<h3>This is my #{number} time using <span class="frame-style">{frame}</span> 🚀</h3>
```

## Summary

After seeing how Svelte works and how to implement it together with Ruby-on-Rails, we can highlight some important takeouts:

- Svelte's Community is growing, and <a href="https://svelte.dev/docs" target="_blank" >the Documentation</a> and examples that you can already find are of great value.
- Pace of development is fast. Lately, we have seen the releases of **SvelteKit** (web applications) and **Svelte Native** (mobile apps), which are the frameworks to make development experience more efficient.
- Big companies are using Svelte already (i.e. Philips and Rakuten)
- When talking about frameworks, early adoption can be a risk but also a huge win!

When choosing frameworks, it is important to study and assess alternatives (i.e. [take a look at this guide about Vue](https://bootrails.com/blog/ruby-on-rails-and-vuejs-tutorial/) and compare): how does the implementation work? What is more efficient? What pays off in the short/long term?