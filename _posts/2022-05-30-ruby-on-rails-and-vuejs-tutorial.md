---
title: "Ruby-on-Rails and VueJS tutorial"
author: david
date: 2022-05-30 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: "Ruby-on-Rails and VueJS tutorial"
---

## 1. Why VueJS and Rails

Ruby-on-Rails minimalistic, default app starts without VueJS. Even JavaScript is optional. But only submitting forms and display inputs is no more a web standard. Dynamic, intuitive interfaces are.  
  
This is where VueJS could enter the Ruby-on-Rails world. But nowadays there's Hotwire, in order to limit the need for a JS framework.  
  
We even have a [tutorial about Hotwire](https://www.bootrails.com/blog/rails-7-hotwire-a-tutorial/) if you're interested.  
  
However if you feel more comfortable with VueJS, there's a ton of places for such tooling, even without SPA.  
  
At <strong>[BootrAils](https://bootrails.com)</strong>, we don't use Hotwire, nor any JS framework. Only a small amount of VanillaJS. That being said, we like to explore all ways to tackle the complexity of the UX. VueJS is a well-known one.  
  


## 2. Create a minimalistic, empty Rails app 
  
Open your terminal, and check that you have the following tools installed :  
  
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
  
Then enter :  
  
```bash  
mkdir vuerails && cd vuerails  
echo "source 'https://rubygems.org'" > Gemfile  
echo "gem 'rails', '~> 7.0.0'" >> Gemfile  
bundle install  
bundle exec rails new . --force -d=postgresql --minimal  
  
# Create a default controller  
echo "class WelcomeController < ApplicationController" > app/controllers/welcome_controller.rb  
echo "end" >> app/controllers/welcome_controller.rb  
  
# Create a default route  
echo "Rails.application.routes.draw do" > config/routes.rb  
echo ' get "welcome/index"' >> config/routes.rb  
echo ' root to: "welcome#index"' >> config/routes.rb  
echo 'end' >> config/routes.rb  
  
# Create a default view  
mkdir app/views/welcome  
echo '<h1>This is h1 title</h1>' > app/views/welcome/index.html.erb  
  
  
# Create database and schema.rb  
bin/rails db:create  
bin/rails db:migrate  
  
```  
  
## 3. Install vite_rails  
  
Rails frontend assets management is a long story. It often changes, so if you want to use both VueJS and Rails 7+, the best option is to rely on ViteJS.  
  
- You are now independent of Rails choices about JS,  
- ViteJS is actually the build tool of VueJS, so chances that everything works properly is high  
- From our experience, VueJS 3 doesn't work well with the default esbuild of Rails 7.  
  
Open the Gemfile, and add  
  
```ruby  
gem 'vite_rails'  
```  
  
Then in your terminal  
  
```bash  
bundle install  
bundle exec vite install  
  
```  
  
If you want to see what's going on under the hood : we wrote a [tutorial about Rails and Vite](https://www.bootrails.com/blog/vitejs-rails-a-wonderful-combination/).  
  
## 4. Launch Rails app without VueJS  
  
These 3 files are enough to trigger a default view. Let's try.  
  
```bash  
$/myapp> foreman start -f Procfile.dev  
```  
  
And open your browser  
  
<figure>  
<img style="display:block;float:none;margin-left:auto;margin-right:auto;width:60%" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/v1652362644/rails/vuetitle.png" loading="lazy" alt="Title" title="Title">  
<figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:60%">Title</figcaption>  
</figure>  
  
Great !  
  
## 5. Install VueJS 
  
Add VueJS to your project  
  
```  
yarn add vue@3.2.33  
```  
  
Now we need to tell ViteJS that we are going to use vue :  
```  
yarn add @vitejs/plugin-vue  
```  
  
And modify the corresponding configuration, like this :  
  
```javascript  
// inside vite.config.ts  
import { defineConfig } from 'vite'  
import RubyPlugin from 'vite-plugin-ruby'  
import vue from '@vitejs/plugin-vue'  
  
export default defineConfig({  
  plugins: [  
    RubyPlugin(),  
    vue()  
  ],  
})  
  
```  
  
Good !  
  
Now make your whole application.js look like this :  
  
```javascript  
import { createApp } from 'vue/dist/vue.esm-bundler';  
  
const app = createApp({  
  data() {  
    return {  
      course: 'Intro to Vue 3 and Rails'  
    }  
  }  
})  
  
app.mount('#app');  
console.log("app", app);  
```  
  
And add the following HTML to your `app/views/welcome/index.html.erb`:  
  
```html  
<h1>This is h1 title</h1>  
  
<div id="app">  
<p>{{ course }}</p>  
</div>  
```  
  
Now stop your local server, and relaunch it :  
  
```bash  
$/myapp> foreman start -f Procfile.dev  
```  
  
Open your browser :  
  
<figure>  
<img style="display:block;float:none;margin-left:auto;margin-right:auto;width:60%" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/v1652453404/rails/vuecompleted.png" loading="lazy" alt="Vue works" title="Vue works">  
<figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:60%">Vue works</figcaption>  
</figure>  
  
So far, so good ! VueJS is now inside our Rails app, we are able to mount a new VueJS into a Rails template, and hydrate the View with data from JavaScript.  
  
What else ?  
  
## 6. VueJS components into Rails  
  
We could stop the tutorial here, but there is still one thing we need to cover : components. Small chunk of view with its own responsibility. Think about React components, Web components, and so on.  
  
Create a new file `app/frontend/components/ButtonCounter.vue`  
  
And complete it like this :  
  
```html  
<script>  
export default {  
  data() {  
   return {  
    count: 0  
   }  
  }  
}  
</script>  
  
<template>  
  <button @click="count++">You clicked me {{ count }} times.</button>  
</template>  
```  
  
Just by reading code, and without knowing about VueJS, you should be able to understand what we are trying to achieve : a simple counter.  
  
Let's try to import it into our main view.  
  
First, let's register our new component, so that our root app is aware of it :  
  
```javascript  
import { createApp } from 'vue/dist/vue.esm-bundler';  
  
import ButtonCounter from '../components/ButtonCounter.vue'  
  
const app = Vue.createApp({  
  data() {  
    return {  
      course: 'Intro to Vue 3 and Rails'  
    }  
  }  
})  
  
app.component('ButtonCounter', ButtonCounter)  
  
app.mount('#app');  
// (optional) for debug purpose  
console.log("app", app);  
```  
  
Then use this component into the welcome page :  
  
```html  
<h1>This is h1 title</h1>  
  
<div id="app">  
<p>{{ course }}</p>  
  
<button-counter></button-counter>  
  
</div>  
```  
  
Once restarted, you should have the counter that works :  
  
<figure>  
<img style="display:block;float:none;margin-left:auto;margin-right:auto;width:60%" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/v1652878055/rails/vuecounter.png" loading="lazy" alt="Vue and Rails... finally" title="Vue and Rails... finally">  
<figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:60%">Vue and Rails... finally</figcaption>  
</figure>  
  
  
## 8. Combine both
  
You can either choose to :  
  
- Use VueJS as a completely separate application, and use Rails only for the backend. This is known as "SPA", a single page application. You can see a <a href="https://pragmaticstudio.com/unpacked-single-page-app-with-vue-rails" target="_blank">complete course about VueJS and Rails here</a> .  
- Or you can choose to keep Ruby-on-Rails for the views, and sprinkle some VueJS only where it is necessary.  
  
There is no "good choice" or "bad choice" here. If you are under a heavy budget and time constraint however, we strongly advise you to choose option 2.  
  
In this case, try to guess how to :  
  
- Send data (from the server) to the VueJS components, maybe thanks to the Gon gem.  
- Send data to the server from VueJS components  
- Extract purely frontend data : which tab was last opened for example  
  
This is the main three difficulties, IHMO. Once mastered, you don't have to worry each time the UX designer enters the web dev's room.  
  
## Conclusion  
  
Rails and VueJS combined together is a breeze. ViteJS is part of the VueJS project, and is really easy to integrate with Rails. Whereas there are tons of options for the frontend part with Rails, VueJS is probably amongst the best ones - despite being not the default choice of the maintainers.