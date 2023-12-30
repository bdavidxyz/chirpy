---
title: Rails faker gem overview
author: david
date: 2022-09-08 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Rails faker gem overview
---

## What is Faker?

During the development process, it is often necessary to test the application to work with real data. Moreover, the data should be as close as possible to the real ones, both qualitatively and quantitatively, especially if we want to add hundreds of records to our database. Luckily, there is a gem called [Faker](https://github.com/faker-ruby/faker), that greatly simplifies the work of filling the database with such data (phone numbers, email, usernames, etc.) that you can use in your tests. As it mentioned in the repository description, Faker generates data at random, so returned values are not guaranteed to be unique by default. But you can explicitly specify when you require unique values following the instructions.

## Create an empty Rails app

Let's create our brand new Rails application.

There’s a lot of ways [to create Rails apps](/blog/how-to-create-tons-rails-applications/), but the easiest and cleanest way probably is to create a file named Gemfile in your working directory, and fill it like this:

```ruby
source 'https://rubygems.org'

ruby '3.0.2'

gem 'rails', '~> 7.0.3.1'
```

And then run

```ruby
bundle install
```

Check this inside of the directory where you want your Rails 7 app to live:

```ruby
rails -v
```

output

```ruby
Rails 7.0.3.1
```

If that works, then you’re done with the prerequisites.

So we can now create our application.

```ruby
rails new APP_NAME --database=postgresql
```

+ **rails** is the Rails CLI (command line interface) tool
+ **new** tells the Rails CLI that we want to generate a new application
+ **APP_NAME** is, well, your app name
+ **--database=postgresql** is an optional parameter that tells Rails we want to use the PostgreSQL to persist our data (by default Rails has SQLite database)

After generating your new Rails app, you’ll need to cd into your new app and create your database.

Run at terminal

```ruby
rails db:create
```

and

```ruby
rails db:migrate
```

Good! Now run up your development server

```ruby
rails s
```

Make sure you can navigate to your browser at localhost:3000, and if everything has gone well, you should see the Rails default index page.

Now let's add a couple of models so we have something to work with:

```ruby
rails g model User name:string
```

```ruby
rails g model Post title:string body:text user:belongs_to
```

and then

```ruby
rails db:migrate
```

Nothing unusual happens here: a message with a header, a body, an association for the user.

Make sure the correct associations are created, as well as some simple validations:

```ruby
# inside models/user.rb
has_many :posts
 
validates :name, presence: true
```

```ruby
# inside models/post.rb
belongs_to :user
 
validates :title, presence: true
validates :body, presence: true
```

The next step is to load multiple instances of the records into the newly created tables.

## Add the faker gem

The easiest way to load some data is to use the `seeds.rb` file inside the `db` directory. However, like many programmers, I don't want to think about any content during development. So why don't we take advantage of the **Faker** gem, which can generate random data of various types: names, emails, texts, even movie quotes and more.

First add Faker gem to Gemfile

```ruby
source "https://rubygems.org"

gem "rails", "~> 7.0.3", ">= 7.0.3.1"

gem 'faker'
```

Run

```ruby
bundle install
```

Or just by inserting the following into the command line of your terminal

```ruby
gem install faker
```

Faker will then be globally available to use within your project.

## Add a seed file

Next, we'll add a Rake task to populate the database with sample data, for which Rails has a default location of `db/seeds.rb`.

```ruby
User.create!(name:  "Lone User",
             email: "test@fakertutorial.org")

99.times do |n|
  name  = Faker::Name.name
  email = Faker::Internet.email
  User.create!(name:  name,
               email: email)
# and another sort of syntax for adding posts for our users
  User.posts.create({title: Faker::Hipster.sentence, body: Faker::Lorem.sentence})
end
```

In the case of the first user (Lone User), there is an example of how we can create users from seeds.rb without Faker, when we don't need more data.
Another 99 users were populated with the gem. And also 99 posts with the title and text by the authorship of these users. For each loop you are creating a new user and a new post.

As you can see we use `create!` here, the bang version of create. So what's this for? Our `create!` will raise an exception if it encounters an error while seeding and the database will stop seeding but records seeded before the exception will remain in the database. What if we were to use `create`? The seeds.rb code will run to completion but creation of some records may silently fail.

There could be a number of causes when using `create!` throw an [exception](/blog/how-to-handle-ruby-exceptions/). The most common reason is usually that the record failed to validate. Because validations apply to all records, regardless of whether they're created in the application, in the Rails console, or in a seed file.

So `create!` will throw the specific validation error if a record fails to seed because it isn't validated. To fix this issue, you should update your seeds.rb code so that all records can be properly validated and created in the database. And using `create` instead of `create!` is not the right way. The main goal if we ask our seeds.rb file to create any amount of records in the database, to know that we'll get exactly that same number of records.

## Load demo data

Finally, load the data:

```ruby
rails db:seed
```

Note, that `Faker::Name.name`, `Faker::Hipster.sentence` and `Faker::Lorem.sentence` are standard **Generators** from <a href="https://github.com/faker-ruby/faker#installing" target="_blank">Faker README</a> where you can find all of the existing generators and description of their usage. How you utilize the gem depends on the type of data you will be looking for.

If you have a model attribute which has a uniqueness validation Faker has a unique method you can make use of:

`Faker::Name.unique.name`

This will return a unique name every time it is called. This is useful if you are creating numerous objects with unique attributes with tests i.e. if you’re using a create_list with <a href="https://github.com/thoughtbot/factory_bot?ref=hackernoon.com)" target="_blank">FactoryBot</a>:

```ruby
create_list(:article, 5, title: Faker::Lorem.unique.sentence)
# this will create 5 articles with unique titles
```

Sometimes Faker creates data that is bigger than you need. In this case you can cut it by editing Generators like this:

```ruby
User.post.title = Faker::Book.title[0..30]
# it will get only the first 30 characters
```

Or

```ruby
User.post.title = Faker::Hipster.sentence(word_count: 3)
# it will get only the first 3 words
```

All of these and more you will find at the <a href="https://github.com/faker-ruby/faker#installing" target="_blank">Faker README</a>.

## Conclusion

We have come to the end of the article. Hopefully, by now, you will feel more confident in using **the Faker gem**.

The Faker gem is really easy to integrate into your Rails application and generates huge amounts of data for testing during development. Also, Faker is great to use within RSpec to fake out data and keep your tests looking more streamlined.