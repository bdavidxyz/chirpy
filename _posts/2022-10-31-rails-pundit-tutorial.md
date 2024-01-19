---
title: Rails pundit tutorial
author: david
date: 2022-10-31 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:Rails%20pundit%20tutorial,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:A%20Ruby-on-Rails%20tutorial,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Rails pundit tutorial
---

## Introducing Pundit

As you probably know, web applications need the ability to assign different roles and permissions.

New developers often confuse two terms - *Authorization* and *Authentication*.

[*Authentication*](/blog/rails-authentication-with-rodauth-an-elegant-gem/) is a method of granting access to users through the process of verifying the claimed identity of the user, device, or other entity using the user's credentials, such as username, email address, password, etc. [This article](/blog/ruby-on-rails-authentication-tutorial-with-devise/) is about the functionality of the Devise gem, authentication mechanism for Ruby-on-Rails applications.

*Authorization* is a method of granting users or a group of users the ability to access data with restrictions or permission to perform only the tasks they are allowed to by assigning user roles or access levels to users or groups of users.

Usually, in web applications, granting limited access distinguishes between administrators and ordinary users. This can be done with a simple boolean that determines if the user is an administrator. However, in production applications, roles and permissions are more complex.

How well roles and access restrictions to actions and data are implemented determines the quality of your application.

In this post, we'll implement roles and permissions in a basic Ruby on Rails application using the <a href="https://github.com/varvet/pundit" target="_blank">Pundit gem</a>.

Pundit is a gem that provides a set of helpers that guide you to use simple Ruby objects and object-oriented design patterns to create an authorization system. It's easy to use, has minimal permissions, and is great for managing role-based authorization using policies defined in simple Ruby classes.

To describe how the gem works, it binds the methods of the required class to the actions of the controller by executing the method corresponding to the action when a request is received. If the response evaluates to false, access is denied and an error is thrown.

To put it simply, Pundit's job is to authorize whether the user is allowed to perform an action or not. Then your policy methods return a boolean and a Pundit::NotAuthorizedError will be raised if it's false.

## Policies

Each time you have to check whether something or someone is allowed to perform an action in the application you will refer to the Policy Object pattern. This pattern is used to deal with permissions and roles.

For example, we have a guest user in our application. Using a guest policy object we can check if this user is able to retrieve certain resources. And if the user is an admin, we can easily change guest policy object to an admin policy object with different rules.

We need to stick to these rules when working with Policy Object pattern: 

- The return has to be a boolean value
- The logic has to be simple
- Inside the method, we should only call methods on the passed objects

## How to work with Pundit

1) Create a Policy class that handles authorizing access to a specific type of record — whether it be a Post or User, or something else.

2) Call the built-in authorization function, passing in what you need to authorize access to.

3) Pundit will find the appropriate Policy class and call the Policy method that matches the name of the method you are authorizing. If it returns true, you have permission to perform the action. If not, it’ll throw an exception.

In which scenarios should you use them:

When your application has more than one type of restricted access and restricted actions. As an example, posts can be created with the following:

- a restriction that only admins and/or editors can create posts
- a requirement that editors need to be verified

By default, Pundit provides two objects to your authorization context: the User and the Record being authorized. This is enough if you have a system-wide role in your system like Admin, but not enough if you need to allow more specific context.

As an example, you worked with a system that supported the concept of an Office, with different roles and offices to support. The system-wide authorization would not be able to deal with it because it is unacceptable that an admin of Office One to be able to do things to Office Two unless they are an admin of both. In this case, you would need access to 3 items: the User, the Record, and the user’s role information in the Office.

Pundit provides the ability to provide additional context. You can change what is considered a user by defining a function called `pundit_user`. The object authorization context from this function will be available to your policies.

```ruby
# inside application_controller.rb

class ApplicationController < ActionController::Base
  include Pundit

  def pundit_user
    AuthorizationContext.new(current_user, current_office)
  end
end
```

```ruby
# inside authorization_context.rb

class AuthorizationContext
  attr_reader :user, :office

  def initialize(user, office)
    @user = user
    @office = office
  end
end
```

```ruby
# inside application_policy.rb

class ApplicationPolicy
  attr_reader :request_office, :user, :record

  def initialize(authorization_context, record)
    @user = authorization_context.user
    @office = authorization_context.office
    @record = record
  end

  def index?
    # Your policy has access to @user, @office, and @record.  
  end
end
```

## Create an empty Rails app

Here are the tools I used for this tutorial. 

```shell  
$> ruby --version  
=> 3.1.2  
$> rails --version  
=> 7.0.4
$> node --version  
=> 18.6.0  
$> yarn --version  
=> 1.22.19
```

Let's create our brand new [Ruby-on-Rails](blog/ruby-on-rails-mvc/) application. There’s a lot of ways to do this, but the easiest and cleanest way probably is to create a file named Gemfile in your working directory, and fill it like this:

```ruby
source 'https://rubygems.org'

ruby '3.1.2'

gem 'rails', '~> 7.0.4'
```

And then run 

```shell
bundle install
```

So we can now create our application. You may want to simplify this if one day you need to create [multiple Rails applications](/blog/how-to-create-tons-rails-applications/)

```shell
bundle exec rails new . --force -d=postgresql
```

+ **rails** is the Rails CLI (command line interface) tool
+ **new** tells the Rails CLI that we want to generate a new application
+ **.** means working in the current directory
+ **--database=postgresql** is an optional parameter that tells Rails we want to use the PostgreSQL to persist our data (by default Rails has SQLite database)

After generating your new Rails app, you’ll need to cd into your new app and create your database.

Run at terminal 

```shell
bin/rails db:create
```

and

```shell
bin/rails db:migrate
```

Great! Now run up your development server

```shell
bin/rails s
```

Make sure you can navigate to your browser at localhost:3000, and if everything has gone well, you should see the Rails default index page.

<figure>
  <img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="https://res.cloudinary.com/shinocloud/image/upload/v1664545894/rails/---" loading="lazy" alt="Rails works!" width="400" height="250">  
  <figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">Rails works!</figcaption>
</figure>

```
**NOTE:** *You must follow all the steps to authenticate users as in the [Devise tutorial](/blog/ruby-on-rails-authentication-tutorial-with-devise/).*
```

Now let's add a scaffold for `Article` so we have something to work with:

```shell
bin/rails g scaffold Article title body:text published:boolean user:belongs_to
```

and then

```shell
bin/rails db:migrate
```

We will add a column to the `User` type to be either admin or guest. We also wrote a tutorial about [how to add a column](/blog/rails-add-column/).
Follow the steps to add in the migration:

```shell
bin/rails g migration AddAdminToUser admin:boolean
```

```shell
bin/rails db:migrate
```

## Pundit gem installation

It is quit easy to set up this gem. For clear instruction, you can check gem's documentation. Now start to set up it:

Add `gem 'pundit'` to Gemfle:

```ruby
gem 'pundit'
```

And run

```shell
bundle install
```

Include Pundit in your application controller:

```ruby
class ApplicationController < ActionController::Base
  include Pundit::Authorization
end
```

*Also, you can run the generator to set up an application policy with some useful defaults:*

```shell
rails g pundit:install
```

After that, you need to restart the Rails server. Now Rails can pick up any classes in the new `app/policies/` directory.

## Adding policies:

```shell
mkdir app/policies
touch app/policies/article_policy.rb
```

Our `article_policy.rb` with some code:

```ruby
class ArticlePolicy < ApplicationPolicy
  attr_reader :user, :article

  def initialize(user, article)
    @user = user
    @article = article
  end

  def show?
    # a condition which returns a boolean value
  end
end
```

The `ArticlePolicy` class has the same name as that of model class, only with the "Policy" suffix. Given that the first argument is a `user`, in your controller, Pundit will call the *current_user* method we defined in in `ApplicationController`, to get what to send into this argument. The second argument is the model object, whose authorization you want to check. And finally, some request method is implemented for the class in this case `show?`. This will map to the name of a specific controller action. Note that the method names should correspond to controller actions suffixed with a **?**. So for controller actions such as new, create, update etc, the policy methods `new?`, `create?`, `update?` etc are to be defined.

## Adding policy checks

Let's look at the required code for class ArticlePolicy:

```ruby
class ArticlePolicy < ApplicationPolicy
  attr_reader :user, :article

  def initialize(user, article)
    @user = user
    @article = article
  end

  def index?
    true
    # if set to false - no one will have access
  end

  def show?
    true
  end

  # Same as for create 
  def new?
    create?
  end

  # Same as that of the update.
  def edit?
    update?
  end

  # Only admin is allowed to update the article and only if article is not published
  def update?
    user.admin? || !article.published
  end

  # Only admin is allowed to create the article.
  def create?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
```

We need to generate the controller:

```shell
bin/rails g controller Articles index
```

Don't forget about routes:

```ruby
Rails.application.routes.draw do
  root 'articles#index'
  resources :articles
  devise_for :users
end
```

Now we will manage the `articles_controller.rb`:

```ruby
class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]

  # GET /articles or /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1 or /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)
    authorize @article

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    authorize @article

    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :body, :published)
    end
end
```

Do some work on the views:

```html
# inside views\articles\index.html.erb

<p style="color: green"><%= notice %></p>

<h1>Articles</h1>

<div id="articles">
  <p>
    <strong>Title:</strong>
    <%= @article.title %>
  </p>

  <p>
    <strong>Body:</strong>
    <%= @rticle.body %>
  </p>

  <p>
    <strong>Published:</strong>
    <%= @article.published %>
  </p>
  <p>
    <%= link_to "Show this article", article %>
  </p>
</div>

<%= link_to "New article", new_article_path %>
```

```html
# inside views\articles\show.html.erb

<p style="color: green"><%= notice %></p>

  <p>
    <strong>Title:</strong>
    <%= @article.title %>
  </p>

  <p>
    <strong>Body:</strong>
    <%= @article.body %>
  </p>

  <p>
    <strong>Published:</strong>
    <%= @article.published %>
  </p>

<div>
  <%= link_to "Edit this article", edit_article_path(@article) %> |
  <%= link_to "Back to articles", articles_path %>

  <%= button_to "Destroy this article", @article, method: :delete %>
</div>
```

```html
# inside views\articles\new.html.erb

<h1>New article</h1>

<%= form_with(model: @article) do |form| %>
  <% if @article.errors.any? %>
    <div style="color: red">
      <h2><%= pluralize(@article.errors.count, "error") %> prohibited this article from being saved:</h2>

      <ul>
        <% @article.errors.each do |error| %>
          <li><%= error.full_message %></li>
        <% end %>
      </ul>
    </div>
  <% end %>

  <div>
    <%= form.label :title, style: "display: block" %>
    <%= form.text_field :title %>
  </div>

  <div>
    <%= form.label :body, style: "display: block" %>
    <%= form.text_area :body %>
  </div>

  <div>
    <%= form.label :published, style: "display: block" %>
    <%= form.check_box :published %>
  </div>

  <div>
    <%= form.submit %>
  </div>
<% end %>

<br>

<div>
  <%= link_to "Back to articles", articles_path %>
</div>
```

Stop and run up again your development server and go to the `/articles` page:

<figure>
  <img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="https://res.cloudinary.com/shinocloud/image/upload/v1664545894/rails/---" loading="lazy" alt="Articles page" width="400" height="250">  
  <figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">Articles page</figcaption>
</figure>

Update the `application_controller.rb` to handle an error with [flash messages](/blog/how-to-use-rails-flash-messages/):

```ruby
class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :pundishing_user

  private

  def pundishing_user
    flash[:notice] = "You are not authorized to perform this action."
    redirect_to article_path
  end
end
```

And try to do actions as not an admin user:

<figure>
  <img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="https://res.cloudinary.com/shinocloud/image/upload/v1664545894/rails/---" loading="lazy" alt="Not authorized" width="400" height="250">  
  <figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">Not authorized</figcaption>
</figure>

Or login as an admin and try to delete the article:

<figure>
  <img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="https://res.cloudinary.com/shinocloud/image/upload/v1664545894/rails/---" loading="lazy" alt="Destroyed by admin" width="400" height="250">  
  <figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">Destroyed by admin</figcaption>
</figure>

## Pundit policy scopes

This allows you to let users with different authorizations see different scopes of items.

For example, admins can see all articles, other users can see own articles.

Modify the `article_policy.rb`:

```ruby
class ArticlePolicy < ApplicationPolicy
  # ...
  class Scope < Scope
    def resolve
      if @user.has_role? :admin
        scope.all
      else
        scope.where(articles: {article_id: current_user.id})
      end
    end
  end
end
```

And then add to your ArticlesController:

```ruby
class ArticlesController < ApplicationController
  # existing code

  def index
    @articles = policy_scope(Article).order(created_at: :desc)
    authorize @articles
  end
end
```

## Extending policy with multiple roles

In practice, it is quite common to require that the authorization of a particular CRUD action be different for multiple roles. Let's add to our example, say, the role 'supporter'. And now there are articles that can only be viewed by supporter users and admins. We need to create a new 'supporter' role and update our ArticlePolicy as shown below:

```ruby
class ArticlePolicy < ApplicationPolicy
  # ...
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.supporter?
        scope.where(published: true)
      else
        scope.where(published: true, supporter: false)
      end
    end
  end

  # ...

  def show?
    return user.supporter? || user.admin? if article.published?
    true
  end
end
```

Now a normal user can’t view articles for supporters in the index view listings as we are scoping it out. Also we are authorizing the show page as to not allow non-supporter users to see supporter content.

## Conclusion

You have read the basics of authorization with Pundit. If you are looking for decentralized solutions for your Rails application it could be a nice one. Pundit can also be customized deeply to add your own methods or features.

The policy pattern concept produces big results. Each time you have to deal with simple or complex permissions a policy object could be applied. When it comes to testing, your policies are purely Ruby objects, and your testing will be simple and fast.