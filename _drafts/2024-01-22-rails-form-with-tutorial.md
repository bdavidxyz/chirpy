---
title: Rails form_with tutorial
author: david
date: 2024-01-22 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:Rails%20form_with%20tutorial,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:Behind%20Ruby-on-Rails%20magic,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  alt: Rails form_with tutorial
---

# Rails form_with tutorial

"form_with" is known as a form helper, which means it's an abstraction to build well-known, standard HTML form.

## In the need of form_with

First, we should mention **why we need a helper anyway**. After all, a web form is just as old as the web itself, wrapping it around a Ruby or Rails helper wouldn't make things more complex? At first glance, you're absolutely right. 

> But remember the <a href="https://rubyonrails.org/doctrine#integrated-systems" class="fw-bold" target="_blank" noopener noreferrer>Rails philosophy</a>. Rails value integrated system, it means at one point we have to rely on strong collaboration between the browser and the server. And this collaboration is (partially) ensured by helpers
{: .prompt-info }

Without helpers, you would have to take care about :

 - Security token,
 - Classes and naming consistency,
 - Manually ensure that all pathes (URLs) exist and are always up-to-date.

   The **last point alone** justifies the absolute need for helpers - at least for web forms.

**Side note** : A lot of criticism against Rails is that the tool pushes abstractions too far, which I somehow agree. How much abstraction is "good enough" for you is entirely up to you (or your tech lead).


## A Rails tutorial from scratch

So let's start a tutorial from scratch. 

Tool I will use in this tutorial :

```shell
ruby -v  # 3.3.0
bundle -v  # 2.4.10
node -v # 20.9.0
```

Then let's go at the root of your usual workspace, and start to build a fresh new Rails app :

```shell
mkdir formwith && cd formwith  
echo "source 'https://rubygems.org'" > Gemfile  
echo "gem 'rails', '7.1.3'" >> Gemfile  
bundle install  
bundle exec rails new . --force
```

Notice here that I don't use the `--minimal` flag - see [options here](https://bootrails.com/blog/rails-new-options/). It would remove Hotwire, Stimulus, and so on - the collaboration between the browser and the server **would be then different**. I want to stick to plain old Rails in this tutorial.

## Create a data layer

Forms are made to send data to the server, so it will make more sense to add some model and data to our app.

Let's say we have some books with title, description, and isbn (isbn are business ID for books).


```shell
bin/rails generate model Book title:string body:text isbn:integer --no-test-framework
```


A migration file was created under `db/migrate/20240131201925_create_books.rb`  - the number is a timestamp, of course you will have another one.

```ruby
class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.text :body
      t.integer :isbn
    
      t.timestamps
    end
  end
end
```

## A default view where to put forms

Nothing but standard Rails here. In your terminal, go at the root of your app, and paste the following commands:

```bash  
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
echo '<h1>form_with tutorial</h1>' > app/views/welcome/index.html.erb
```

Then create database,

```shell
bin/rails db:create db:migrate
```

Then launch your local Rails server by typing :

```shell
bin/rails server
```

And check that "form_with tutorial" is displayed in your browser at localhost:3000

## An endpoint where to send data

Open the `routes.rb` file, and add a path where to send the data, like this :

```ruby
Rails.application.routes.draw do
  get "welcome/index"
  post "welcome/book_endpoint", as: "book_endpoint" # add this line
  root to: "welcome#index"
end
```

And add the corresponding method in the WelcomeController : 

```ruby
class WelcomeController < ApplicationController

  # Add this method
  def book_endpoint
  end

end
```

Now open your browser at localhost:3000/rails/info/routes, you should see the endpoint.

**Side note** :  It's better to follow REST conventions, and Rails helps to do so in the routes.rb file. For demo purpose, we stick to an explicit, simpler route where to send the data.

## Build a first form with... form_with 

Now it's time to see how `form_with` could help to build forms.

```erb
<%# inside app/views/welcome/index.html.erb %>
<h1>form_with tutorial</h1>

<%= form_with do |myform| %>
  Form contents
<% end %>
```

Which renders an empty form, like this one :

```html
<body>
    <h1>form_with tutorial</h1>

<form action="/welcome/index" accept-charset="UTF-8" method="post">
  <input type="hidden" name="authenticity_token" value="zOt30hNDyv2GLIUHeHmpUksAk8eujPFwbd6r7-pIpHigC6TLF9eAplosFKQxWF2N65NwKjDCurP5y3c1WYUwmw" autocomplete="off">
  Form contents
</form>
  

</body>
```

 - the default HTTP method is `post`
 - the security token is built by Rails 
 - the UTF-8 charset is automatically set
 - In the, we have a `myform` object that will help to build data that will be sent to the server

## form_with in the real world

Let's add the required fields:

```erb
<%# inside app/views/welcome/index.html.erb %>
<h1>form_with tutorial</h1>

<%= form_with scope: "book", url: book_endpoint_path, method: :post do |myform| %>

  <div>
    <%= myform .label :title, "Title is:" %>
    <%= myform.text_field :title %>    
  </div>

  <div>
    <%= myform.label :text, "Text is:" %>
    <%= myform.text_area :text %>
  </div>

  <div>
    <%= myform.label :isbn, "Isbn is:" %>
    <%= myform.number_field :isbn %>    
  </div>

  <%= myform.submit "Search" %>

<% end %>
```

Which renders the following HTML :

```html
<body>
    <h1>form_with tutorial</h1>


<form action="/welcome/book_endpoint" accept-charset="UTF-8" method="post">
  <input type="hidden" name="authenticity_token" value="AsfAGgNmd52Y6AUjbhtulwVtc6Q8r9r6U0wkKRAqnwbzlpeIK0x29NOzUDpcJrxAEht6njABQ_WoCdOB0Haq_Q" autocomplete="off">

  <div>
    <label for="book_title">Title is:</label>
    <input type="text" name="book[title]" id="book_title">    
  </div>

  <div>
    <label for="book_text">Text is:</label>
    <textarea name="book[text]" id="book_text"></textarea>
  </div>

  <div>
    <label for="book_isbn">Isbn is:</label>
    <input type="number" name="book[isbn]" id="book_isbn">    
  </div>

  <input type="submit" name="commit" value="Search" data-disable-with="Search">

</form>
  

</body>
```

 - Note that "url" and "method" are explicitly set in the block declaration
 - Note you can mix HTML and Rails helpers inside the form block
 - Note that "name" and "id" are explicitly set for each field
 - Note that for the submit field, "commit" is the default name. If there are multiple submit fields, we explicitly could set different names for each submit.


## form_with using a model

Now let's cheat for a second by using rails scaffolding.

Instead of a book, let's say we want to create, read, update or delete a *fruit*.

```shell
bin/rails generate scaffold fruits name:string
```

It will generate migration, model, controller, and a view (yes, just for fruits).

now stop your local server and run 

```shell
bin/rails db:migrate 
bin/rails server
```

And go to localhost:3000/fruits/new

Open `app/views/fruits/_form.html.erb`

You should see something like this

```erb
<%= form_with(model: fruit) do |form| %>

  <!-- Skipped the error messages here -->

  <div>
    <%= form.label :name, style: "display: block" %>
    <%= form.text_field :name %>
  </div>

  <div>
    <%= form.submit %>
  </div>
<% end %><form action="/fruits" accept-charset="UTF-8" method="post"><input type="hidden" name="authenticity_token" value="ZoY6D8B5iEd5Pp2PEWt-QHEYUgmVTQwz4omUz_e42g2DSFl-N5cZvmj54aVZVh8ZkXgmF7vs2FBjxXOsuCnctg" autocomplete="off">

  <div>
    <label style="display: block" for="fruit_name">Name</label>
    <input type="text" name="fruit[name]" id="fruit_name">
  </div>

  <div>
    <input type="submit" name="commit" value="Create Fruit" data-disable-with="Create Fruit">
  </div>
</form>
```

Which is rendered like this :


```html
<form action="/fruits" accept-charset="UTF-8" method="post">
  <input type="hidden" name="authenticity_token" value="ZoY6D8B5iEd5Pp2PEWt-QHEYUgmVTQwz4omUz_e42g2DSFl-N5cZvmj54aVZVh8ZkXgmF7vs2FBjxXOsuCnctg" autocomplete="off">

  <div>
    <label style="display: block" for="fruit_name">Name</label>
    <input type="text" name="fruit[name]" id="fruit_name">
  </div>

  <div>
    <input type="submit" name="commit" value="Create Fruit" data-disable-with="Create Fruit">
  </div>
</form>
```

Just from `model: fruit`, Rails is able to guess :

 - the endpoint URL
 - the method
 - the name and id of each field
 - everything else is no surprise given what we saw earlier

It's probably too much for many people, but you can see how Rails is focused on model and conventions.

Notice that you don't "have to" always follow the Rails way, just code the way that seems more comfortable to you.

And one day maybe, you will find that following convention is easier than repeating the same boring boilerplate. But my advice is "don't try this too early", and maybe not at all if it doesn't suit your mindset.

## Conclusion

Trying to read at least once what happens between Rails abstraction and actual browser rendering, as we did in this article, helps to understand deeply how things works.

I didn't try to submit a form as I did my [Rails and form article](https://bootrails.com/blog/rails-form-tutorial/), so you can try to see what happens in the Rails console as an exercise.

I hope you learned something new today!

Best,

David.