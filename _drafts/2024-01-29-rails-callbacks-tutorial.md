---
title: Rails callbacks tutorial
author: david
date: 2024-01-29 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:Rails%20callbacks%20tutorial,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:Insights%20and%20tutorial%20from%20scratch,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  alt: Rails callbacks tutorial
---


## Definition of a callback

To begin with, let's remember that methods in Ruby are a collection of statements that returns the result, and in general they are similar to functions with a set of expressions. Within a method, you can perform a specific task that can be invoked from other areas of the application.

So, **callbacks** are, first and foremost, **methods**.

They can also be described as hooks into an object’s life cycle provided by Active Record. Callbacks are called at various stages of an object's life cycle, whenever an Active Record object is created, updated,  saved, deleted, or even validated or loaded (from the database).

## Active Record operations

[Ruby-on-Rails](https://bootrails.com/blog/ruby-on-rails-mvc/) come with many built-in callbacks. The main types are:

- Method references (symbol) – recommended
- Callback objects – recommended
- Inline methods (using a [proc](https://bootrails.com/blog/ruby-block-procs-and-lambda/)) – when appropriate

Rails guides contain <a href="https://guides.rubyonrails.org/active_record_callbacks.html" target="_blank">all the available Active Record callbacks</a>. As you can read from the guides, there are also *Running Callbacks*, *Skipping Callbacks*, *Relational Callbacks*, *Conditional Callbacks*, and *Transaction Callbacks*.

## A first example with "create"

We can consider `create` as an example to see the basic three kinds of callbacks, as not all object lifecycle steps support all callbacks:

  - **before_create** – runs the method before the action happens;
  - **after_create** – runs the method after the action is complete;
  - **around_create** – this one has logic before and after the action being run, a method that actually yields at some point to the original action. It's not an entirely common callback. Example:

```ruby
around_create :some_method

private

def some_method
  #do some stuff before action
  yield # this makes the save happen
  #do some stuff after action
end
```

And before we start giving examples of the use of callbacks, it is worth noting that it's considered good practice to declare callback methods as **private**. If left public, they can be called from outside the model and violate the principle of object encapsulation.

## Available Rails callbacks

To use available callbacks, they must be registered. You can implement the callbacks as regular methods and use a macro-style class method to register them as callbacks. Typically, callbacks are used to create, update, or destroy records, or to set values for the current record. Another area of use is logging information and performing cleaning tasks.

The following methods trigger callbacks:

- *create*
- *create!*
- *destroy*
- *destroy!*
- *destroy_all*
- *destroy_by*
- *save*
- *save!*
- *save(validate: false)*
- *toggle!*
- *touch*
- *update_attribute*
- *update*
- *update!*
- *valid?*

The **after_find** callback is called whenever Active Record finds and loads a record from the database -- such methods as *all*, *first*, *find*, *find_by*, *last*.

The **after_initialize** callback is triggered every time a new object of the class is initialized, whether by using directly using `new` keyword or when a record is loaded from the database.

## Trigger a callback

In cases where your code is short enough, it can be a single line. And Rails gives you the ability to additionally pass a block in the callback.

The callback below is called after the post has been destroyed:

```ruby
class Post < ApplicationRecord
  after_destroy :logging_destroy_post

  private

  def logging_destroy_post
    puts 'Post successfully destroyed'
  end
end
```

It could be rewritten to:

```ruby
class Post < ApplicationRecord
  after_destroy do
    puts 'Post successfully destroyed'
  end
end
```

A combined example:

```ruby
class User < ApplicationRecord
  before_create do |user|
    puts "Going to create #{user.name}"
  end
  after_create :when_created

  private

  def when_created
    puts "User #{user.name} has been created"
  end
end
```

Now we have a general understanding of callbacks, so we can move on to the practical part.

## Ruby-on-Rails tutorial from scratch
  
Here are the tools I used for this tutorial. 
  
```shell  
$> ruby --version  
=> 3.1.2  
$> rails --version  
=> 7.0.3.1  
$> node --version  
=> 18.6.0  
$> yarn --version  
=> 1.22.19  
```  

So, let's look at how callbacks work in the application.

Create a file named Gemfile in your working directory, and fill it like this:

```ruby
source 'https://rubygems.org'

ruby '3.0.2'

gem 'rails', '~> 7.0.3.1'
```

And then run

```ruby
bundle install
```

Now we can create our application. You may want to simplify this if one day you need to create [multiple Rails applications](/blog/how-to-create-tons-rails-applications/)

```ruby
bin/rails new myapp --database=postgresql
```
+ **rails** is the Rails CLI (command line interface) tool
+ **new** tells the Rails CLI that we want to generate a new application
+ **myapp** is your app name
+ **--database=postgresql** is an optional parameter that tells Rails we want to use the PostgreSQL to persist our data (by default Rails has SQLite database)

After generating your new Rails app, you’ll need to cd into your new app and create your database.

Run at terminal

```ruby
bin/rails db:create
```

and

```ruby
bin/rails db:migrate
```

Good! Now run up your development server

```ruby
bin/rails s
```

Let's add a couple of models with some simple validations and associations to work with. We also wrote a tutorial about [how to add a column](/blog/rails-add-column/).

```ruby
bin/rails g model User name:string
```

with

```ruby
bin/rails g model Article title:string body:text user:belongs_to
```

```ruby
bin/rails g model Comment body:text user:belongs_to article:belongs_to
```

And of course

```ruby
bin/rails db:migrate
```
That is how our models looks like:

```ruby
# models/user.rb

has_many :articles
has_many :comments

validates :name, presence: true
```

```ruby
# models/article.rb

belongs_to :user
has_many :comments

validates :title, presence: true
validates :body, presence: true
```

```ruby
# models/comment.rb

belongs_to :user
belongs_to :article

validates :body, presence: true
```

The next step is to add callbacks to our models.

## Add some callbacks

If only certain lifecycle events need to be triggered callbacks can be registered using the callback extension with `on:` , which allows you to pass one or more lifecycle events that determine when the callback is executed.

```ruby
class User < ApplicationRecord
  before_validation :capitalize_name, on: :create
  # :on also takes an array
  after_validation :set_timezone, on: [ :create, :update ]

  has_many :articles
  has_many :comments

  validates :name, presence: true

  private

  def capitalize_name
    self.name = name.capitalize!
  end

  def set_timezone
    self.timezone = Time.now.in_time_zone(self.time_zone)
  end
end
```

In some implementations, we can register multiple methods of the same callback type. They will be called in the same order in which they are registered.

Let's look at an example of two before_validation callbacks:

```ruby
class Article < ApplicationRecord
  before_validation :set_title
  before_validation :print_title
  # ...
  private

  def set_title
    self.title = 'Hello World!'
  end

  def print_title
    puts self.title
  end
end
```

In the Rails console we receive the following:

```shell
>> article = Article.new
>> article.title
#=> nil

>> article.valid?
#=> "Hello World!"
```

`set_title` is executed first when `.valid?` method is called, and "Hello World!" is assigned to the title attribute. Then it turns to execute `print_title` and the assigned value is printed.

Note, that you should avoid using [transaction callbacks](https://guides.rubyonrails.org/active_record_callbacks.html#transaction-callbacks) in such consistency with the *same* method name:

```ruby
class User < ApplicationRecord
  after_create_commit :log_user_saved_to_db
  after_update_commit :log_user_saved_to_db
  # ...
  private
  # ...
  def log_user_saved_to_db
    puts 'User was saved to database'
  end
end
```

```shell
irb> @user = User.create # prints nothing

irb> @user.save # updating @user
User was saved to database
```

Rails does not support separate callback chains for create and update internally. The above code won't work because we can't register the same method in the `after_commit` callback on both create and update. The last line of `after_update_commit` overrides the previous line and the callback will be executed only after the update.

## Relational callbacks

Callbacks can work through model relationships when the associated object changes. If you destroy a record and have enabled `dependent: :destroy`, it will destroy data associated with the parent class.

```ruby
class User < ApplicationRecord
  #...
  has_many :articles, dependent: :destroy
  #...
end

class Article < ApplicationRecord
  after_destroy :log_destroy_action
  #...
  private

  def log_destroy_action
    puts 'Article destroyed'
  end
end
```

```
irb> user = User.first
=> #<User id: 1>
irb> user.articles.create!
=> #<Article id: 1, user_id: 1>
irb> user.destroy
Article destroyed
=> #<User id: 1>
```

## Conditional callbacks

We can also make the calling of the callback method dependent on the execution of the given assertion. You can make conditional callbacks using the `:if` and [`:unless`](https://bootrails.com/blog/ruby-unless/) parameters, which can take a character, a Proc, or an Array. Use the `:if` option if you want to specify under which conditions the callback should be called. Conversely, you can use the [`:unless`](https://bootrails.com/blog/ruby-unless/) parameter if you want to specify conditions under which the callback should not be called.

```ruby
class Comment < ApplicationRecord
  # ...
  before_save :assign_user_timezone, if: Proc.new { |comment| !comment.owner.timezone.present? }
  # ...
  private
 
  def assign_user_timezone
    user.update_attribute(:timezone, timezone)
  end
end
```

Callbacks also can mix both :if and :unless in the same declaration.

## Unit testing

We need to think of two things to check the callback:

- is the callback being triggered for the right events?
- is the called function doing the right thing?

Assume you have the Article class with many callbacks, this is how you would test:

```ruby
class Article < ApplicationRecord
  after_save    :some_method
  after_destroy :another_method
  # ...
end
```

```ruby
it "triggers some_method on save" do
  expect(@article).to receive(:some_method)
  @article.save
end

it "triggers another_method on destroy" do
  expect(@article).to receive(:another_method)
  @article.destroy
end

it "some_method should work as expected" do
  # Actual tests for some_method
end
```

Importantly, this decouples your callbacks from behavior. For example, you could fire the same callback method article.some_method when another related object is updated.

So, keep testing your methods as usual. And take care of the callbacks separately.

For testing you can use [gem 'rspec-rails'](https://github.com/rspec/rspec-rails).

```ruby
class Article < ApplicationRecord
  before_validation :set_title

  private

  def set_title
    self.title = 'New article'
  end
end
```

Testing callback in the 'Article' model:

```ruby
require 'spec_helper'

describe Article do
  subject { Article.new }

  context 'when created' do
    it 'should have title by default' do
      subject.title = nil
      subject.run_callbacks :create
      expect(subject.title).to be('New article')
    end
  end
end
```

## Summary

Callbacks are an excellent technique with quick and easy set up to keep your code simple and flexible. There are a bunch of callbacks, that give Rails developers a lot of options to accomplish any task.

A safe way to write callbacks can be provided by moving the bulk of the logic into the working code. Yes, this will add more code, but it will reduce the coupling in our models and make each component more testable.

If possible, try to create immutable callbacks that can be safely executed multiple times. So they can be triggered every time and under any circumstances they trigger.

You can use callbacks to validate data, but you should avoid this. Use the [ActiveRecord Validation API](https://guides.rubyonrails.org/active_record_validations.html) instead.

