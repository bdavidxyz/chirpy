---
title: Ruby-on-Rails bullet gem tutorial
author: david
date: 2023-01-02 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:Ruby-on-Rails%20bullet%20gem%20tutorial,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:A%20Ruby-on-Rails%20tutorial,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Ruby-on-Rails bullet gem tutorial
---

## Prequisites

Tool I will use in this tutorial :

```
$> ruby -v  
ruby 3.1.2p0 // you need at least version 3 here  
$> bundle -v  
Bundler version 2.2.11  
$> npm -v  
8.3.0 // you need at least version 7.1 here  
$> yarn -v  
1.22.10
```

## Fresh Rails app - no bullet gem yet

Then let's go at the root of your usual workspace, and start to build a fresh new Rails app :

```
mkdir bookapp && cd bookapp  
echo "source 'https://rubygems.org'" > Gemfile  
echo "gem 'rails', '7.0.4'" >> Gemfile  
bundle install  
bundle exec rails new . --force --minimal
```

**Side note** Notice I  use here the `--minimal` flag - see [options here](https://bootrails.com/blog/rails-new-options/). We don't need advanced options of Ruby-on-Rails to show and solve the problem, so let's take the simplest way.

## Create models

Let's say we have an "Author" table.

```bash
$/bookapp> bin/rails generate model Author name:string  --no-test-framework --no-timestamps
```

A migration file was created under `db/migrate/20221219180435_create_authors.rb`  - the number is a timestamp, of course you will have another one.

```ruby
# Under db/migrate/20221219180435_create_authors.rb
class CreateAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :authors do |t|
      t.string :name
    end
  end
end
```

Let's say we have some books with a title. Books are written by Author(s).

```bash
$/bookapp> bin/rails generate model Book title:string author:references --no-test-framework --no-timestamps
```

A migration file was created under `db/migrate/20221219180441_create_books.rb`  :

```ruby
# db/migrate/20221219180441_create_books.rb
class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.references :author, null: false, foreign_key: true
    end
  end
end
```

Ensure each model has a correct relationship, and add missing lines if required. You should end up with this :

```ruby
# app/models/book.rb
class Book < ApplicationRecord
  belongs_to :author
end
```

```ruby
# app/models/author.rb
class Author < ApplicationRecord
  has_many :books # add this line
end
```

## Create the database

```ruby
$> bin/rails db:create db:migrate
```

## Seed data

The `seed.rb` file allows us to put some initial data in our database, so let's rely on it...

```ruby
# inside db/seed.rb file
Book.destroy_all
Author.destroy_all

deaubonne = Author.create({ name: "Francoise Deaubonne" })

Book.create({title: "Birth of ecofeminism", author: deaubonne})
Book.create({title: "Feminism or death", author: deaubonne})
Book.create({title: "Verlaine and Rimbaud", author: deaubonne})
```

And launch :

```ruby
$> bin/rails db:seed
```

## Show me the N+1 queries problem, please

Launch the rails console (`bin/rails console`)

```ruby
Book.all.each { |book| puts "#{book.title} was written by #{book.author.name}" }
  Book Load (0.1ms)  SELECT "books".* FROM "books"
  Author Load (0.1ms)  SELECT "authors".* FROM "authors" WHERE "authors"."id" = ? LIMIT ?  [["id", 1], ["LIMIT", 1]]
Birth of ecofeminism was written by Francoise Deaubonne
  Author Load (0.1ms)  SELECT "authors".* FROM "authors" WHERE "authors"."id" = ? LIMIT ?  [["id", 1], ["LIMIT", 1]]
Feminism or death was written by Francoise Deaubonne
  Author Load (0.1ms)  SELECT "authors".* FROM "authors" WHERE "authors"."id" = ? LIMIT ?  [["id", 1], ["LIMIT", 1]]
Verlaine and Rimbaud was written by Francoise Deaubonne
=> 
[#<Book:0x0000000107037a20 id: 1, title: "Birth of ecofeminism", author_id: 1>,
 #<Book:0x000000010705f278 id: 2, title: "Feminism or death", author_id: 1>,
 #<Book:0x000000010705f1b0 id: 3, title: "Verlaine and Rimbaud", author_id: 1>]
```

You have 4 times the "SELECT" instruction in database.

But you wanted only 3 objects (the 3 books).

This is known as **the N+1 queries problem**.

## Add the bullet gem

The bullet gem has <a target="_blank" href="https://github.com/flyerhzm/bullet">an official repository on GitHub</a>.

Open the Gemfile and add

```ruby
gem "bullet", group: "development"
```

And  open your command line.

```shell
$> bundle install
$> bundle exec rails generate bullet:install
```

in your `config/environments/development.rb`, notice that the following lines were added:

```ruby
Rails.application.configure do
  config.after_initialize do
    Bullet.enable        = true
    Bullet.alert         = true
    Bullet.bullet_logger = true
    Bullet.console       = true
    Bullet.rails_logger  = true
    Bullet.add_footer    = true
  end

#...
end

```

## Add a controller, a route, a view

Modify routes.rb as follow :

```ruby
Rails.application.routes.draw do
  get "welcome/index"
end
```

Add a controller 

```ruby
class WelcomeController < ApplicationController

  # Add this method
  def index
    @books = Book.all
  end

end
```

Add `app/views/welcome/index.html.erb`

```erb
<h1>Hello</h1>

<% @books.each do |book| %>
  <div>
    <div><%= book.title %></div>
    <div><%= book.author.name %></div>  
    <div>&nbsp;</div>
  </div>
<% end %>
```

## Launch and view the N+1 detection

Open your browser at localhost:3000/welcome/index

<figure>  
<img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="https://res.cloudinary.com/shinocloud/image/upload/fl_lossy/v1671480198/rails/nplusone_acomjn.png" loading="lazy" alt="detection of N+1 problem by the bullet gem">  
<figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">detection of N+1 problem by the bullet gem</figcaption>  
</figure>  

You will also find some logs under `log/bullet.log` with:

```ruby
2022-12-19 19:38:43[WARN] user: david
GET /welcome/index
USE eager loading detected
  Book => [:author]
  Add to your query: .includes([:author])
Call stack
```

## Solution to the problem

Notice that the bullet gem is not here to solve the problem, it only  shows you where it happens, and how it could be solved.

In our case, <a target="_blank" href="https://guides.rubyonrails.org/active_record_querying.html#includes">the .includes method</a> of the Rails API was the solution. 

We should have written in the controller :

```erb
class WelcomeController < ApplicationController

  # Modify this method
  def index
    @books = Book.includes(:author)
  end

end
```

Which gives the desired output in the browser :

<figure>  
<img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="https://res.cloudinary.com/shinocloud/image/upload/fl_lossy/v1671480651/rails/resultbulletgem_hsmwt7.png" loading="lazy" alt="Bullet gem shows no error">  
<figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">Bullet gem shows no error</figcaption>  
</figure>  

## Conclusion

The bullet gem is very helpful to detect potentially long and slow SQL queries. It is elegant and non-invasive, being triggered in the development (and eventually test-) environment only.