---
title: Rails 7 Hotwire, a tutorial
author: david
date: 2022-03-07 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:Rails%207%20Hotwire%20%20a%20tutorial,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:A%20Ruby-on-Rails%20tutorial,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Rails 7 Hotwire, a tutorial
---

## Motivation  
  
At <strong>[BootrAils](https://bootrails.com)</strong>, we don't use Hotwire at all. We consider it more simple to launch an MVP without it. That being said, Hotwire looks promising, and deserves special attention, since it's shipped by default with Rails.  
  
## Why Hotwire  
  
Hotwire is an attempt to limit the use of JavaScript when coding a full-stack web application. It's not a lib or a gem, but a set of features to achieve this goal. Interestingly enough, there's also Hotwire for other server-side frameworks like Django. In this tutorial, we will see how to use it with Rails.

  
## What is Hotwire  
  
So Hotwire is a set of techniques :  
  
- Turbo, itself composed of :  
  - Turbo Drive : each link will not trigger a full page reload on click. Instead, only the HTML inside the `<body>` tag will be replaced.  
  - Turbo Frames : will decompose a page into pieces of content that can be updated individually. Before Turbo Frames, one page = one URL.  
  - Turbo Streams : same idea as Turbo Frame, but broader scope, we'll see how.  
  - Turbo Native : targets mobile devices - not covered in this tutorial.  

<br/>

- Stimulus :  
  - Stimulus is a tiny JS tool that does not render any HTML (contrary to most JS frontend frameworks), instead it adds some responsiveness on top of existing HTML.

## Prerequisites for a Rails + Hotwire tutorial

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

## Create Fresh new Rails project, from scratch

Type in your shell : 

```bash  
mkdir railshotwire && cd railshotwire 
echo "source 'https://rubygems.org'" > Gemfile  
echo "gem 'rails', '~> 7.0.0'" >> Gemfile  
bundle install  
bundle exec rails new . --force -d=postgresql  
```

## Create simple files (no Hotwire so far:)

Continue in your shell by typing :

```bash  
  # Create a default controller
  echo "class HomeController < ApplicationController" > app/controllers/home_controller.rb
  echo "end" >> app/controllers/home_controller.rb

  # Create another controller
  echo "class OtherController < ApplicationController" > app/controllers/other_controller.rb
  echo "end" >> app/controllers/other_controller.rb

  # Create routes
  echo "Rails.application.routes.draw do" > config/routes.rb
  echo '  get "home/index"' >> config/routes.rb
  echo '  get "other/index"' >> config/routes.rb
  echo '  root to: "home#index"' >> config/routes.rb
  echo 'end' >> config/routes.rb

  # Create a default view
  mkdir app/views/home
  echo '<h1>This is home</h1>' > app/views/home/index.html.erb
  echo '<div><%= link_to "go to other page", other_index_path %></div>' >> app/views/home/index.html.erb
    
    # Create another view
  mkdir app/views/other
  echo '<h1>This is another page</h1>' > app/views/other/index.html.erb
  echo '<div><%= link_to "go to home page", root_path %></div>' >> app/views/other/index.html.erb

  
  # Create database and schema.rb
  bin/rails db:create
  bin/rails db:migrate
  
``` 

Good ! Run

```
bin/rails s
```

And open your browser to see your app locally. You should see something like this :

<figure>  
<img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/v1645715064/blog/tutohotwire1.png" loading="lazy" alt="localhost">  
<figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">localhost</figcaption>  
</figure>  

## Hotwire : Turbo Drive

Open the "Network" tab of the DevTools of your browser.

Now navigate from homepage to the other page by clicking links. What can you notice ? Navigation is achieved via XHR. The CSS is not reloaded on each navigation, the JavaScript is also not reloaded. Actually the only things reloaded are the DOM differences inside the HTML `body` tag.

<figure>  
<img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/v1645715064/blog/tutohotwire2.png" loading="lazy" alt="turbo drive">  
<figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">Turbo  Drive</figcaption>  
</figure>  

What for ?

  - From our experience, the perceived performance gap is absolutely huge, each click responds immediately, even for deployed, production-ready apps. Which means not only on localhost, on your computer, where the improvements may not be noticed.  
- However this comes with some issues like DOM flickering, fewer accessibility, and a few more weird behaviours.

Turbo Drive is extremely powerful, but it takes time and patience to master it.

## Hotwire : Turbo Frame

Turbo Frames allow developers to split the current page into chunks that can be updated in isolation, when new data comes from the server.

Classic use cases for Turbo Frames could be :

 - Inline edition
 - Tabbed content
 - Searching, sorting, and filtering data

Let's see an example.

Change the `app/controllers/home_controller.rb` like this :

```ruby
class HomeController < ApplicationController

  # @route GET /turbo_frame_form 
  def turbo_frame_form
  end

  # @route POST /turbo_frame_submit 
  def turbo_frame_submit
    extracted_anynumber = params[:any][:anynumber]
    render :turbo_frame_form, status: :ok, locals: {anynumber: extracted_anynumber, comment: 'turbo_frame_submit ok' }
  end
  
end
```

Add `app/views/home/turbo_frame_form.html.erb` with this content : 

```erb
<section>

    <%= turbo_frame_tag 'anyframe' do %>
            
      <div>
          <h2>Frame view</h2>
          <%= form_with scope: :any, url: turbo_frame_submit_path, local: true do |form| %>
              <%= form.label :anynumber, 'Type an integer (odd or even)', 'class' => 'my-0  d-inline'  %>
              <%= form.text_field :anynumber, type: 'number', 'required' => 'true', 'value' => "#{local_assigns[:anynumber] || 0}",  'aria-describedby' => 'anynumber' %>
              <%= form.submit 'Submit this number', 'id' => 'submit-number' %>
          <% end %>
      </div>
      <div>
        <h2>Data of the view</h2>
        <pre style="font-size: .7rem;"><%= JSON.pretty_generate(local_assigns) %></pre> 
      </div>
      
    <% end %>

</section>
```

And change your `routes.rb` like this :

```ruby
Rails.application.routes.draw do
  get 'home/index'
  get 'other/index'

  get '/home/turbo_frame_form' => 'home#turbo_frame_form', as: 'turbo_frame_form'
  post '/home/turbo_frame_submit' => 'home#turbo_frame_submit', as: 'turbo_frame_submit'


  root to: "home#index"
end
```

Finally change the home view like this, in `app/views/home/index.html.erb`

```erb
<h1>This is home</h1>
<div><%= link_to "go to other page", other_index_path %></div>

<%= turbo_frame_tag 'anyframe' do %>        
  <div>
      <h2>Home view</h2>
      <%= form_with scope: :any, url: turbo_frame_submit_path, local: true do |form| %>
          <%= form.label :anynumber, 'Type an integer (odd or even)', 'class' => 'my-0  d-inline'  %>
          <%= form.text_field :anynumber, type: 'number', 'required' => 'true', 'value' => "#{local_assigns[:anynumber] || 0}",  'aria-describedby' => 'anynumber' %>
          <%= form.submit 'Submit this number', 'id' => 'submit-number' %>
      <% end %>
  <div>
<% end %>

```

Restart your local web server, refresh your local browser, you should be able to see this at first glance  :

<figure>  
<img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/v1645779893/blog/tutohotwire3.png" loading="lazy" alt="default view">  
<figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">Default view</figcaption>  
</figure>  

Now type any number in the field, and submit the form. Something like this should appear :

<figure>  
<img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/v1645779893/blog/tutohotwire4.png" loading="lazy" alt="Turbo Frame in action">  
<figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">Turbo Frame in action</figcaption>  
</figure>  

Only the frame part changed, the first title and first link didn't move.

## Hotwire : Turbo streams

### Theory

According to the [docs](https://turbo.hotwired.dev/), 

> Turbo Streams deliver page changes over WebSocket, SSE or in response to form submissions using just HTML and a set of CRUD-like actions.

In other words, you can either :

 - Update a block of HTML when responding to a POST/PUT/PATCH/DELETE action (GET will not work)
 - Broadcast a change to all users, without the need for any browser refresh.

### The most simple example

Change the `app/controllers/other_controller.rb` like this :

```ruby
class OtherController < ApplicationController

  def post_something
    respond_to do |format|
      format.turbo_stream {  }
    end
  end

end
```

And change your `routes.rb` like this :

```ruby
Rails.application.routes.draw do
  get 'home/index'
  get 'other/index'

  get '/home/turbo_frame_form' => 'home#turbo_frame_form', as: 'turbo_frame_form'
  post '/home/turbo_frame_submit' => 'home#turbo_frame_submit', as: 'turbo_frame_submit'

  # Add this line below
  post '/other/post_something' => 'other#post_something', as: 'post_something'

  root to: "home#index"
end
```

Good ! Now each time the '/other/post_something' endpoint is reached, rails will automagically try to find the app/views/other/post_something.turbo_stream.erb template.

Add `app/views/other/post_something.turbo_stream.erb` with the following content :

```erb
<turbo-stream action="append" target="messages">
  <template>
    <div id="message_1">This changes the existing message!</div>
  </template>
</turbo-stream>
```

Good ! It means that the response will try to append (see the "action" attribute)  the template of turbo-frame with id "messages".

Finally change `app/views/other/index.html.erb` with the following content :

```erb
<h1>This is another page</h1>
<div><%= link_to "go to home page", root_path %></div>

<div style="margin-top: 3rem;">
  <%= form_with scope: :any, url: post_something_path do |form| %>
      <%= form.submit 'Post something' %>
  <% end %>
  <turbo-frame id="messages">
    <div>An empty message</div>
  </turbo-frame>
</div>

```

Now launch  your local web server

```
bin/rails s
```

Open your web browser, and go to the "other" page.

<figure>  
<img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/v1645809681/blog/tutohotwire5.png" loading="lazy" alt="Other page">  
<figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">Other page</figcaption>  
</figure>  

Click on the "Post something" button :

<figure>  
<img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/v1645809681/blog/tutohotwire6.png" loading="lazy" alt="Line added">  
<figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">Line added</figcaption>  
</figure>  


Good ! Turbo Streams allows developers to append a message after a submission, without any page reload. It happens rather seamlessly.

What if we want to "replace" the message, instead of "append" a new message ? 


Change `app/views/other/post_something.turbo_stream.erb` with the following content :

```erb
<turbo-stream action="replace" target="messages">
  <template>
    <div id="message_1">This changes the existing message!</div>
  </template>
</turbo-stream>
```

Only the attribute "action" changed on line 1 : action is now replaced.

You can check that everything is working properly in your local browser.

## Hotwire : Turbo native

Turbo native helps to build applications on mobile devices, this will not be covered here. However we won't remove this paragraph, so that you'll be fully aware that _Turbo Native_ is part of Hotwire :)

## Stimulus

Hotwire actually _has_ a JS tool, as if the goal of Hotwire is to avoid it. The reason is that Turbo-* tools are not enough to cover all scenarios. There are some cases where JS is still needed. In order to limit the need for it, Stimulus considers the HTML as the _single source of truth_ (for those who know Redux).

Change `app/views/other/index.html.erb` like this :

```erb
<h1>This is another page</h1>
<div><%= link_to "go to home page", root_path %></div>

<div style="margin-top: 2rem;">
  <%= form_with scope: :any, url: post_something_path do |form| %>
      <%= form.submit 'Post something' %>
  <% end %>
  <turbo-frame id="messages">
    <div>An empty message</div>
  </turbo-frame>
</div>

<div style="margin-top: 2rem;">
  <h2>Stimulus</h2>  
  <div data-controller="hello">
    <input data-hello-target="name" type="text">
    <button data-action="click->hello#greet">
      Greet
    </button>
    <span data-hello-target="output">
    </span>
  </div>
</div>

```

Change `app/javascript/controllers/hello_controller.js` like this :

```js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "name", "output" ]

  greet() {
    this.outputTarget.textContent =
      `Hello, ${this.nameTarget.value}!`
  }
}
```

Open your browser at localhost, go to the "other" page, and play with the example.

This example is directly picked from the docs. It's enough to understand Stimulus' goal : add interactivity on the front-end side.

## Concluding thoughts

Hotwire is great. The best news is that UX - which means your end user, drives the hype and innovation nowadays. 

Less JavaScript, more responsiveness, they said.

That's partially true. In practice, it takes some time to really handle it correctly. We've hit some problems about accessibility and some complicated use-cases that Stimulus wasn't able to tackle. Outside of this, it will probably save you some jQuery/vanillaJS headaches. For a MVP, Hotwire could be seen as optional, since it adds a layer of complexity - this is why we skipped it for <strong>[bootrails](https://bootrails.com)</strong>.

However if you like it you can get a good training here : [https://hotrails.dev](https://hotrails.dev)

No free lunch. But choices.

Enjoy !