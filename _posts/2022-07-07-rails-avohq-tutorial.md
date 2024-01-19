---
title: Ruby-on-Rails and Avo Tutorial
author: david
date: 2022-07-07 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:Ruby-on-Rails%20and%20Avo%20Tutorial,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:A%20Ruby-on-Rails%20tutorial,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Ruby-on-Rails and Avo Tutorial
---

<span> 2023 disclaimer : Bootrails is now a partner of AvoHQ. <a href="/pricing"><strong>Learn more</strong></a></span>
## Avo Overview

<a href="https://avohq.io/" target="_blank">AvoHQ</a> main promise is to remove boilerplate. It's an alternative to the [Rails administrate gem](https://bootrails.com/blog/rails-administrate-tutorial-and-philosophy/).

Avo's primary purpose is to manage database records for Rails applications. To do this, it uses the concept of a **resource** that corresponds to a model. Once a resource is defined, the user can map the database fields so Avo knows what data to display and how to do so. In Rails, index is for showing all instances of a resource, show is for showing a single specific instance, and edit/create are to edit and create a single instance specifically. So each field declaration in Avo adds a column of data to the Index view and a row to the Show, Edit, and Create views. Amazingly, Avo doesn't support just basic fields; they handle complex ones like trix, markdown, gravatar, boolean_group, file, etc. Once these resources have been setup with the desired fields, they can be filtered based on conditions through the use of Avo **filters**. it's as simple as generating the filter, setting up options, then adding it to one or more resources. Avo also has something called **actions** that can do things like apply transformations to resources. All in all, it's a pretty powerful and convenient tool. Please note that it's not free for advanced features.

## Creating a Rails application utilizing Avo

Now that you have an idea of what Avo is, it's time to put that knowledge to action!

## Create a fresh new Rails app and install Avo
```bash
$> ruby -v  
ruby 3.0.1p64 # Ruby >= 2.7 
$> rails -v  
Rails 7.0.2.4 # Ruby-on-Rails >= 6.0
$> bundle -v  
Bundler version 2.3.14 # Bundler 2.xx
```

Now enter your workspace and type

```bash
bin/rails new avo_test
cd avo_test
```

Now in the gemfile, add

```bash
gem "avo"
```

Then run this command to complete the setup!

```bash
bundle install
bin/rails generate avo:install # Generate initializer and add Avo to routes.rb
```

## Seed the database so we have information to play with!
Run these commands to create migrations for books and authors
```bash
bin/rails generate migration createBooks
bin/rails generate migration createAuthors
```

```ruby
# Inside of db/migrate/..._create_authors.rb
class CreateAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :authors do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.timestamps
    end
    add_index :authors, :email, unique: true
  end
end
```

```ruby
# Inside of db/migrate/..._create_books.rb
class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.integer :author_id, null: false
      t.timestamps
    end
    add_index :books, :author_id
  end
end
```

Now run the command

```bash
bin/rails db:migrate
```
Now create the corresponding models for the tables!

```ruby
# Inside of app/models/author.rb
class Author < ApplicationRecord
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  has_many :books
end
```

```ruby
# Inside of app/models/book.rb
class Book < ApplicationRecord
  validates :title, :author_id, presence: true
  
  belongs_to :author
end
```

Now we can finally seed the database!

```ruby
# Inside of db/seeds.rb
author1 = Author.create(first_name: "Tom", last_name: "Pratt", email: "tp@gmail.com")
author2 = Author.create(first_name: "John", last_name: "Smith", email: "js@gmail.com")
author3 = Author.create(first_name: "Jane", last_name: "Doe", email: "jd@gmail.com")
book1 = Book.create(title: "The Great Gatsby", author_id: author1.id)
book2 = Book.create(title: "The Catcher in the Rye", author_id: author1.id)
book3 = Book.create(title: "The Grapes of Wrath", author_id: author2.id)
```

Then run 

```bash
bin/rails db:seed
```

## Setup home page to look at the admin dashboard

```bash
bin/rails g controller home # Creates a home controller 
echo '<h1>Hello world!</h1>' > app/views/home/index.html.erb 
```
And make the default route the home page that you just created!

```ruby
# Inside of config/routes.rb
Rails.application.routes.draw do
  mount Avo::Engine, at: Avo.configuration.root_path
  
  root "home#index"
end
```

## Generating your first Avo Resource

Start out by defining resources! This command will generate a resource file in the app/avo/resources directory. 

```bash
bin/rails generate avo:resource Author # Creates author_resource.rb
bin/rails generate avo:resource Book # Creates book_resource.rb
```

Now let's define some fields to display since only id is shown by default. 

```ruby
# Inside of author_resource.rb
class AuthorResource < Avo::BaseResource
  self.title = :id
  self.includes = []
  field :id, as: :id
  field :first_name, as: :text
  field :last_name, as: :text
  field :email, as: :text
end
```

```ruby
# Inside of book_resource.rb
class BookResource < Avo::BaseResource
  self.title = :id
  self.includes = []
  field :id, as: :id
  field :title, as: :text
  field :author, as: :belongs_to
end
```

Now that everything is setup, use the command

```bash
bin/rails server
```

And navigate to http://localhost:3000/avo in your browser to check out the admin panel!

Click on the hamburger icon in the top left corner of the page and you can see the defined resources; authors and books. 

<figure>
  <img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="/images/avo/avo_1.png" loading="lazy" alt="avo menu"  width="994" height="288">
  <figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">Avo menu</figcaption>  
</figure>


## Managing database records using Avo Resources

From the sidebar, click on the desired resource to manage and you reach this clean UI. 

For example, clicking on the Books resource.

<figure>
  <img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="/images/avo/avo_2.png" loading="lazy" alt="avo books" width="994" height="288">
  <figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">Avo books</figcaption>  
</figure>

Notice how it's already filled with our seeded data!

From here, you can easily: create a new book, delete the record, edit it, and 
view it alone. You can also select multiple or all books to edit/delete them all 
at once. It's truly an admin panel that makes managing database records for Rails 
applications simple and easy. This simple demonstration doesn't really show the 
power of: complex types, filtering, actions, grid view, etc. Please go through 
the <a href="https://docs.avohq.io/2.0/" target="_blank"> Avo documentation</a>
and experiment with its more advanced features! I suggest looking at <a href="https://avodemo.herokuapp.com/avo/dashboards/dashy" target="_blank"> Avo's demo app</a> demo app to see what the framework is capable of doing.

## Conclusion

So far our choice at [Bootrails](https://bootrails.com) is to stick with plain old Rails (along with a CSS framework and pre-made design) to build the admin part.
However it's always interesting to see how other tools handle this. 
Avo creates beautiful admin panels for managing database records in Rails applications quickly.