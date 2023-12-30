---
title: "Rails administrate , big tutorial, bits of philosophy"
author: david
date: 2022-02-28 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: "Rails administrate , big tutorial, bits of philosophy"
---

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
Now open your usual workspace, and type

```bash  
mkdir myadmin && cd myadmin 
echo "source 'https://rubygems.org'" > Gemfile  
echo "gem 'rails', '7.0.0'" >> Gemfile  
bundle install  
bundle exec rails new . --force  
```

You have now a fresh, new, default Rails 7 app installed in the "myapp" directory - this is also the name of the tiny app, perfect for a tutorial.

You can also open in your browser, the official repository [here](https://github.com/thoughtbot/administrate), and the docs  [here](https://administrate-demo.herokuapp.com/), it will be helpful.

## 2. Build a complex enough domain

In order to see how good the `administrate` gem is, we need some *complex enough* models, a single table with a single string-based attribute will not reflect real-world, production-ready web applications.

```bash  
bin/rails generate model Author name:string email:string bio:text favorite_number:integer awake:time birthday:date --no-test-framework
bin/rails generate model Micropost name:string content:text published:boolean author:references --no-test-framework
```

Our Author has :text, :string, :integer, :time and :date types, plus the :datetime type (Rails already brings it to us thanks to timestamps).  
  
Moreover, our Micropost has a boolean, and a reference to the Author.  
  
That makes many types and relationships. Not quite yet like real-world apps, but certainly more than a "hello world" tutorial.

Migrate the database :
```bash  
bin/rails db:migrate
```

Then modify models as follow :

```ruby  
# Inside app/models/Authors.rb
class Author < ApplicationRecord
  has_many :microposts  
end
```

```ruby  
# Inside app/models/Authors.rb
class Micropost < ApplicationRecord
  belongs_to :author, required:  true  
end
```

Now add some validations to these models.

```ruby  
# Inside app/models/Authors.rb
class Author < ApplicationRecord
  has_many :microposts  
  
  validates :name, presence: true
  validates :bio, length: { maximum: 50 }
  validates :email, presence: true, format: { with: /\A([^\}\{\]\[@\s\,]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
end
```

```ruby  
# Inside app/models/Authors.rb
class Micropost < ApplicationRecord
  belongs_to :author
  
  validates :name, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
end
```


## 3. Seed some data

```ruby  
# Inside db/seeds.rb
author_ada = Author.create!(name: 'Ada Lovelace', email: 'ada@example.com', bio: 'Wrote great code.')

micropost_1 = Micropost.create!(name: 'add', content: 'how to add numbers in Ruby', author: author_ada, published: true)
micropost_2 = Micropost.create!(name: 'multiply', content: 'how to multiply numbers in Ruby', author: author_ada, published: false)

author_grace = Author.create!(name: 'Grace Hopper', email: 'ada@example.com', bio: 'Coded in the navy.')

micropost_3 = Micropost.create!(name: 'rubyMap', content: 'map things in Ruby', author: author_grace, published: true)
micropost_4 = Micropost.create!(name: 'rubyHash', content: 'Ruby dictionaries', author: author_grace, published: false)
micropost_5 = Micropost.create!(name: 'rubyArray', content: 'How to handle arrays in Ruby', author: author_grace, published: true)
```

Seed the database :
```bash  
bin/rails db:seed
```

## 4. Install and scaffold administrate

Now we are going to inject `administrate` in your application. Open your terminal and type :

```bash  
echo "gem 'administrate'" >> Gemfile
bundle install
```

Once installed, I suggest to always commit changes before any new file generation, thus, it's far easier to see what and why (bad or good) surprises happen.

Now ask `administrate` to generate a skeleton.

```bash  
bin/rails generate administrate:install
```

That will produce the following output :
```
      route  namespace :admin do
              resources :authors
              resources :microposts
                root to: "authors#index"
              end
      create  app/controllers/admin/application_controller.rb
      create  app/dashboards/author_dashboard.rb
      create  app/controllers/admin/authors_controller.rb
      create  app/dashboards/micropost_dashboard.rb
      create  app/controllers/admin/microposts_controller.rb
```
Nice ! `administrate` is smart enough to tell us what actually changed. Take time to inspect generated files one by one.

## 5. Let's see what administrate look like in our Rails app

We haven't yet launched our own server. Maybe it's time to have a sneak peek :

```bash  
bin/rails s
```

And open your browser at localhost:3000/admin

<figure>  
<img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/v1641560022/rails/admin.png" loading="lazy" alt="Administrate">  
<figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">Administrate</figcaption>  
</figure>  

Try to navigate to the creation page, edit page, as well as the show page. See how data and relationship are already defined. Of course this could be customised and improved, but at least, "it works".

## 6. The easy winners : dashboard, and controller

That's the real power of `administrate` : many parts are really easy to customize. Moreover, everything is heavily documented.

```ruby
# inside app/controllers/admin/authors_controller.rb
module Admin
  class AuthorsController < Admin::ApplicationController
    # Overwrite any of the RESTful controller actions to implement custom behavior
    # For example, you may want to send an email after a foo is updated.
    #
    # def update
    #   super
    #   send_foo_updated_email(requested_resource)
    # end

    # Override this method to specify custom lookup behavior.
    # This will be used to set the resource for the `show`, `edit`, and `update`
    # actions.
    #
    # def find_resource(param)
    #   Foo.find_by!(slug: param)
    # end

    # The result of this lookup will be available as `requested_resource`

    # Override this if you have certain roles that require a subset
    # this will be used to set the records shown on the `index` action.
    #
    # def scoped_resource
    #   if current_user.super_admin?
    #     resource_class
    #   else
    #     resource_class.with_less_stuff
    #   end
    # end

    # Override `resource_params` if you want to transform the submitted
    # data before it's persisted. For example, the following would turn all
    # empty values into nil values. It uses other APIs such as `resource_class`
    # and `dashboard`:
    #
    # def resource_params
    #   params.require(resource_class.model_name.param_key).
    #     permit(dashboard.permitted_attributes).
    #     transform_values { |value| value == "" ? nil : value }
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
```

Pretty neat.

The dashboard allows us to see what kind of data is displayed on which screen. Code is pretty self-explanatory :

```ruby
# inside app/dashboards/author_dashboard.rb
require "administrate/base_dashboard"

class AuthorDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    microposts: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    email: Field::String,
    bio: Field::Text,
    favorite_number: Field::Number,
    awake: Field::Time,
    birthday: Field::Date,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    microposts
    id
    name
    email
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    microposts
    id
    name
    email
    bio
    favorite_number
    awake
    birthday
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    microposts
    name
    email
    bio
    favorite_number
    awake
    birthday
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how authors are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(author)
  #   "Author ##{author.id}"
  # end
end
```

One of the great strengthes of administrate is the ability to handle a wide variety of fields (so not only *classic input* like "text" or "number") 

## 7. Available fields

As the time of writing, here are the available types (the list is also [here](https://github.com/thoughtbot/administrate/tree/v0.16.0/lib/administrate/field) in the GitHub repo) :

 - associative
 - base
 - belongs_to
 - boolean
 - date
 - date_time
 - deferred
 - email
 - has_many
 - has_one
 - number
 - password
 - polymorphic
 - select
 - string
 - text
 - time
 - url

What if

## 8. More and more fields

The community has built numerous useful fields, that you can find here : https://rubygems.org/gems/administrate/reverse_dependencies

You can also write your own fields, as stated in [the official docs](https://administrate-demo.herokuapp.com/adding_custom_field_types).

## 9. Customize the views

Let's say you don't like the side navigation. Or maybe you want to display the currently connected `User` in this sidebar.

```ruby
bin/rails generate administrate:views:layout 
      create  app/views/layouts/admin/application.html.erb
      create  app/views/admin/application/_navigation.html.erb
      create  app/views/admin/application/_stylesheet.html.erb
      create  app/views/admin/application/_javascript.html.erb
      create  app/views/admin/application/_flashes.html.erb
      create  app/views/admin/application/_icons.html.erb
```

Good ! You can change anything in the sidebar, or even in the global layout application. But if you open `_stylesheet.html.erb`, you'll notice that it doesn't allow you to change the actual css.

## 10. Customize assets

Now to actually customize CSS and and change the bare design, just type :

```ruby
bin/rails g administrate:assets:stylesheets
```

And with no surprise for JS :
```ruby
bin/rails g administrate:assets:javascripts
```

## 11. Further customisation

We have already covered many use cases for customisation, everything else can be found in the [official documentation](https://administrate-demo.herokuapp.com/).

If anything is missing, you can still fork the repo, reference the fork in your Gemfile, and change the internal of `administrate`. From our experience this is unlikely to occur. Even the base controller of `administrate` can be overridden.

## 12. Should you use administrate ?

Pros : 
 - Plain old Rails : no Hotwire, no js-bundling,
 - It's easy to start with,
 - It seems easy to customise at first glance, tons of options available,
 - Somehow good-looking : bare design, but accessible and understandable from day 1,
 - Exists for a long time,
 - Backed by  Thoughtbot,
 - Regular updates.

Cons :
 - Uses abstraction ("resource") for every model,
 - Nested resources are barely supported,
 - Corner cases are not easy to reach.

Before any criticism, we'd like to remember that all this incredible work around this gem is given for free. That being said, from our own experience, administrate is really nice to use if you plan to quickly start an admin dashboard, but is not so nice to scale. The UI design is sufficiently clean, but the UX is clearly not good enough by default. If you plan to use an admin dashboard only for your teammates (and not anyone else), and you have to deliver a dashboard quickly, administrate is a reasonable choice.

But

> Every single time I've used one of these, I always end up getting tired of fighting against the gem in some way due to some custom process or workflow, and end up having to go back to classic Rails views.
> --  *a redditor*

If you want anything that is easy to extend over the long term, do not use administrate. Use plain Rails scaffolding, and customize/override it, according to the context of your app.