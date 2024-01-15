---
title: Rails 7 pagination with Kaminari tutorial
author: david
date: 2024-02-05 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:Rails%207%20pagination%20with%20Kaminari%20tutorial,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:A%20simple%20intro%20to%20pagination%20with%20Rails,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  alt: Rails 7 pagination with Kaminari tutorial
---

## Intro : bloated data

Displaying bulk of data in a single page is not a good practice because it slows down our rails application and will decrease the performance of the database server.

Displaying long lists has a significant performance impact on both front-end and back-end:

- First, the database reads a lot of data from disk.

- Second, the result of the query is converted to Ruby objects, which increases memory allocation.

- Third, large responses take longer to send to the user's browser.

- As a result, displaying long lists can cause the browser to freeze.

## Adding pagination

The simplest and most common way to solve this problem is to add pagination to our rails applications in order to limit the number of records we want to show in a single page. Going further, we can specify the required number of records per page and customise how the pagination will be displayed.

Pagination divides data into equal parts (pages). On the first visit, the user only gets a limited number of items (page size). The user can see more items as they page forward thus sending a new HTTP request and a new database query.

Offset-based pagination is the simplest and the most common way to paginate over records. It uses the SQL LIMIT and OFFSET clauses to extract a certain piece from a table.

Example database query:

```SQL
SELECT * FROM records LIMIT [Number to Limit By] OFFSET [Number of rows to skip];
```

```SQL
SELECT * FROM posts LIMIT 20 OFFSET 10;
```

## Rails answer

There are several popular pagination libraries used by the Rails community that you can use. In this post, we'll look at how to add pagination with <a href="https://github.com/kaminari/kaminari" target="_blank">Kaminari gem</a>. I suggest using this gem to paginate our blog posts so that we can manage each page.

What we want is an easy way to show only a certain number of posts per page and let the user view them page by page. The gem itself is well tested and its integration is quite easy, so there is no need to create any specs to test pagination. Also it provides handy helper methods to implement pagination on ActiveRecord queries and customisation helpers.

## Demo : create a new Rails app

So let's start a tutorial from scratch. 

Tool I will use in this tutorial :

```shell
ruby -v  # 3.3.0
bundle -v  # 2.4.10
node -v # 20.9.0
```

Then let's go at the root of your usual workspace, and start to build a fresh new Rails app :

```shell
mkdir pagination && cd pagination  
echo "source 'https://rubygems.org'" > Gemfile  
echo "gem 'rails', '7.1.2'" >> Gemfile  
bundle install  
bundle exec rails new . --force
```

Notice here that I don't use the `--minimal` flag - see [options here](https://bootrails.com/blog/rails-new-options/). It would remove Hotwire, Stimulus, and so on - the collaboration between the browser and the server **would be then different**. I want to stick to plain old Rails (which now includes Hotwire) in this tutorial.

## Create database

Let's create an "Article"

```shell
bin/rails g model Article title:string body:text --no-test-framework --no-timestamps
```

Then create the database :

```shell
bin/rails db:create db:migrate
```
 
## Seed data

Pagination means a lot of data to handle, so let's create it manually this time - we could also use the faker gem next time.

```ruby
# inside db/seed.rb file
articles = Article.create([
  { title: "Apple", body:"Lorem ipsum" },
  { title: "Watermelon", body:"Lorem ipsum" },
  { title: "Orange", body:"Lorem ipsum" },
  { title: "Pear", body:"Lorem ipsum" },
  { title: "Cherry", body:"Lorem ipsum" },
  { title: "Strawberry", body:"Lorem ipsum" },
  { title: "Nectarine", body:"Lorem ipsum" },
  { title: "Grape", body:"Lorem ipsum" },
  { title: "Mango", body:"Lorem ipsum" },
  { title: "Blueberry", body:"Lorem ipsum" },
  { title: "Pomegranate", body:"Lorem ipsum" },
  { title: "Plum", body:"Lorem ipsum" },
  { title: "Banana", body:"Lorem ipsum" },
  { title: "Raspberry", body:"Lorem ipsum" },
  { title: "Mandarin", body:"Lorem ipsum" },
  { title: "Jackfruit", body:"Lorem ipsum" },
  { title: "Papaya", body:"Lorem ipsum" },
  { title: "Kiwi", body:"Lorem ipsum" },
  { title: "Pineapple", body:"Lorem ipsum" },
  { title: "Lime", body:"Lorem ipsum" },
  { title: "Lemon", body:"Lorem ipsum" },
  { title: "Apricot", body:"Lorem ipsum" },
  { title: "Grapefruit", body:"Lorem ipsum" },
  { title: "Melon", body:"Lorem ipsum" },
  { title: "Coconut", body:"Lorem ipsum" },
  { title: "Avocado", body:"Lorem ipsum" },
  { title: "Peach", body:"Lorem ipsum" },
  { title: "Anise", body:"Lorem ipsum" },
  { title: "Basil", body:"Lorem ipsum" },
  { title: "Caraway", body:"Lorem ipsum" },
  { title: "Coriander", body:"Lorem ipsum" },
  { title: "Chamomile", body:"Lorem ipsum" },
  { title: "Daikon", body:"Lorem ipsum" },
  { title: "Dill", body:"Lorem ipsum" },
  { title: "Fennel", body:"Lorem ipsum" },
  { title: "Lavender", body:"Lorem ipsum" },
  { title: "Cymbopogon", body:"Lorem ipsum" },
  { title: "Lemongrass", body:"Lorem ipsum" },
  { title: "Marjoram", body:"Lorem ipsum" },
  { title: "Oregano", body:"Lorem ipsum" },
  { title: "Parsley", body:"Lorem ipsum" },
  { title: "Rosemary", body:"Lorem ipsum" },
  { title: "Thyme", body:"Lorem ipsum" },
  { title: "Alfalfa", body:"Lorem ipsum" },
  { title: "Azuki", body:"Lorem ipsum" },
  { title: "Sprouts", body:"Lorem ipsum" },
  { title: "Black beans", body:"Lorem ipsum" },
  { title: "Black-eyed", body:"Lorem ipsum" },
  { title: "Borlottibean", body:"Lorem ipsum" },
  { title: "Broadbeans", body:"Lorem ipsum" },
  { title: "Chickpeas", body:"Lorem ipsum" },
  { title: "Garbanzos", body:"Lorem ipsum" },
  { title: "Kidney", body:"Lorem ipsum" },
  { title: "Lentils", body:"Lorem ipsum" },
  { title: "Limabeans", body:"Lorem ipsum" },
  { title: "Butterbeans", body:"Lorem ipsum" },
  { title: "Mungbeans", body:"Lorem ipsum" },
  { title: "Navybeans", body:"Lorem ipsum" },
  { title: "Peanuts", body:"Lorem ipsum" },
  { title: "Pintobeans", body:"Lorem ipsum" },
  { title: "Runnerbeans", body:"Lorem ipsum" },
  { title: "Splitpeas", body:"Lorem ipsum" },
  { title: "Soybeans", body:"Lorem ipsum" },
  { title: "Peas", body:"Lorem ipsum" },
])
```

Then launch in the console :

```shell
bin/rails db:seed
```

## The bare minimum files

So we need a controller, a view, and a route to see what is happening.

The controller is generated as follow :

```shell
bin/rails g controller Articles index --no-test-framework
```

That fetches all required articles:

```ruby
class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

end
```


Then the route :

```ruby
Rails.application.routes.draw do
  get "articles/index"
  root "articles#index"
end
```

And the view

```erb
# inside views\articles\index.html.erb

<h1>Articles</h1>
<% @articles.each do |article| %>
  <p style="margin-top: 2rem;">
    <strong>Title:</strong>
    <%= article.title %>
  </p>

  <p>
    <strong>Content:</strong>
    <%= article.body %>
  </p>
<% end %>
```

## Result without pagination

As stated in the beginning of the article, there are too much data in the view layer - and for our dear user, too.

Launch your local web server :

```shell
bin/rails server
```

And open your browser at localhost:3000


<figure>
  <img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="https://res.cloudinary.com/shinocloud/image/upload/fl_lossy/v1671695155/rails/kaminari_initial_nfxlma.png" loading="lazy" alt="All articles on one page">
  <figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">All articles on one page</figcaption>
</figure>

## Add Kaminari

Open your Gemfile, and add :

```ruby
gem "kaminari"
```

And  open your command line.

```shell
$> bundle install
```

After running bundle we can generate a configuration file for Kaminari.

 ## Configure Kaminari

```ruby
bin/rails g kaminari:config
# => create  config/initializers/kaminari_config.rb
```

The path to find the file is `config/initializers`. Let's look inside:

```ruby
# inside config\initializers\kaminari_config.rb
Kaminari.configure do |config|
  # config.default_per_page = 25
  # config.max_per_page = nil
  # config.window = 4
  # config.outer_window = 0
  # config.left = 0
  # config.right = 0
  # config.page_method_name = :page
  # config.param_name = :page
end
```

## Add some pagination 

These are the defaults. For example, `default_per_page` sets up how many results will be in each page. We can change that to required number and uncomment to apply changes.

```ruby
# inside config\initializers\kaminari_config.rb
Kaminari.configure do |config|
  config.default_per_page = 5
# ...
```

Don't forget to restart your Rails server when you change this config.

Let's move into the controller:

```ruby
class ArticlesController < ApplicationController
  # ...
  def index
    @articles = Article.order(created_at: :desc).page(params[:page])
  end
end
```

And the view :

```erb
<div style="font-size: 2rem;">
  <%= paginate @articles %>
</div>

<h1>Articles</h1>

<% @articles.each do |article| %>
  <p style="margin-top: 2rem;">
    <strong>Title:</strong>
    <%= article.title %>
  </p>

  <p>
    <strong>Content:</strong>
    <%= article.body %>
  </p>
<% end %>

```

Notice I added some raw CSS styles to highlight concepts.

The result should be as follow :

<figure>
  <img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="https://res.cloudinary.com/shinocloud/image/upload/fl_lossy/v1671695731/rails/kaminari_pagination_g0av5t.png" loading="lazy" alt="Pagination">
  <figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">Pagination</figcaption>
</figure>


## Further possibilities

We only scratched the surface here, but at least you have all the skeleton needed to discover all possibilities of the kaminari gem. 

Don't try to build a pagination feature yourself before to read the whole documentation on <a target="_blank" href="https://github.com/kaminari/kaminari">Kaminari GitHub's repository</a>.

You may miss some nice helpers like `page_entries_info`, I let you search what it actually is :)


## Conclusion

Pagination is a very common problem of web application. I guess it has to be reconsidered since the raise of Hotwire, but I hope this tutorial helped you to gain confidence with large dataset.
