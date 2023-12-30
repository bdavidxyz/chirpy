---
title: Ruby-on-Rails ViewComponents tutorial and examples
author: david
date: 2022-06-23 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Ruby-on-Rails ViewComponents tutorial and examples
---

## What is a ViewComponent and why should you use them?

A ViewComponent is simply a Ruby object and a template. There are five main reasons why you should use ViewComponents!

1. **Single Responsibility**: Instead of view-related logic being scattered across the project, all the logic needed for a template is consolidated into a single class. 
2. **Ease of Testing**: ViewComponents can be unit tested, unlike traditional Rails templates! Another bonus is that these unit tests are typically more than a hundred times faster than similar controller tests.
3. **Explicit Data Flow**: Since ViewComponents use a standard Ruby initializer, the data needed to render the template is explicitly known. This is the opposite of traditional Rails templates, which have an implicit interface. 
4. **Improved Performance**: On average, ViewComponents are roughly 10 times faster than partials. 
5. **Increased Code Quality**: Since ViewComponents are just plain old Ruby objects, they're simple to enforce code quality standards on. 

ViewComponents are ideal for templates that are constantly reused or would benefit from being tested directly. If you have partials or templates with significant amounts of embedded Ruby, they would probably make good ViewComponents.

A typical use case is the navigation bar, for example in a [Bootstrap and Rails app](https://www.bootrails.com/blog/rails-7-bootstrap-5-tutorial/).

Now that you know what ViewComponents are and why you should use them, it's time to implement it yourself!

## Create a fresh new Rails app

```bash
$> ruby -v  
ruby 3.1.2p20 # Please use Ruby 3! 
$> rails -v  
Rails 7.0.2.4 # And Rails 7 to keep things fresh
$> bundle -v  
Bundler version 2.3.14 # Bundler 2.xx
```

Now enter your workspace and type

```bash
rails new -G myapp # -G so it doesn't initialize a git repository
cd myapp
```

Now in the gemfile, add

```bash
gem "view_component"
```

Then run this command to complete the setup!

```bash
bundle install
```

## Implementing your first ViewComponent

Just like how you can do 'rails generate controller/model', you can also do rails generate component! The component generator accepts a component name then a list of arguments.

```bash
bin/rails generate component Example title
# Which will result in
create  app/components/example_component.rb
invoke  test_unit
create    test/components/example_component_test.rb
invoke  erb
create    app/components/example_component.html.erb
```

```bash
# example_component.rb should look like this
class ExampleComponent < ViewComponent::Base
  def initialize(title:)
    @title = title
  end
end
```

- Notice how in example_component.rb, ExampleComponent inherits from ViewComponent::Base. To make this more similar to Rails models/controllers, you can make an ApplicationComponent class that inherits from ViewComponent::Base, then have all of your components inherit from ApplicationComponent.
- Make sure to name components after what they render, NOT the arguments they take in
- Remember what a ViewComponent is; a Ruby object and a template. Look at how it's implemented: one Ruby file and one corresponding template file with the same base name.
- Components are held in app/components
- Component class names should always end in *Component*

Now, overwrite what's originally in the template file (example_component.html.erb)

```bash
echo '<span title="<%= @title %>"><%= content %></span>' > app/components/example_component.html.erb
```
- @title is taken from the component class
- Pay attention to the *content* accessor, it comes in handy in a moment!

Create a controller: 

```bash
# inside app/controllers/home_controller.rb  
class HomeController < ApplicationController  
end  
```

Configure a default route:

```bash
# inside config/routes.rb  
Rails.application.routes.draw do  
  get "home/index"  
  root to: "home#index"  
end  
```

Now create a home folder and a view for home#index

```bash
mkdir app/views/home
echo '<%= render(ExampleComponent.new(title: "my title")) do %>' > app/views/home/index.html.erb 
echo '  Hello, World!' >> app/views/home/index.html.erb 
echo '<% end %>' >> app/views/home/index.html.erb 
```

- Notice when rendering a component, it's just a regular Ruby initializer and you can just look at the class to see what needs to be passed in. Content passed to the ViewComponent as a block is captured and assigned to the *content* accessor.

Now, run 

```bash
bin/rails server
```

And now you should be able to see the view by pasting http://127.0.0.1:3000 into your browser!

<figure>
  <img style="display:block;float:none;margin-left:auto;margin-right:auto" src="/images/viewcomponents/result.png" loading="lazy" alt="localhost" width="994" height="288">
</figure>

That's how you render a ViewComponent in a view. You can also render ViewComponents in controllers directly by doing something like


```ruby
render(ExampleComponent.new(title: "My Title")) { "Hello, World!" }
```

## How do I unit test a component?

Notice how when you generated a component earlier, it created a component test file as well. Paste this inside of `test/components/example_component_test.rb

```ruby
require "test_helper"

class ExampleComponentTest < ViewComponent::TestCase
  def test_render_component
    render_inline(ExampleComponent.new(title: "my title")) { "Hello, World!" }

    assert_selector("span[title='my title']", text: "Hello, World!")
    # or, to just assert against the text:
    assert_text("Hello, World!")
  end
end
```

Then simply run

```bash
bin/rails test
```

Wouldn't you look at that, the controller isn't involved at all! 

## Production-ready Ruby-on-Rails example

Sometimes just reading code is both a great way to learn and a relaxing activity. Let's explore <a href="https://github.com/joemasilotti/railsdevs.com/tree/main/app/components" target="_blank">GitHub source code of railsdevs</a> .

here is `app/components/conversations/read_indicator_component.html.erb`

```erb
<% return unless render? %>
<% if show_read? %>
  <div class="flex justify-end my-3 mr-4">
    <div class="flex items-center justify-center space-x-2 text-sm">
      <%= inline_svg_tag "icons/solid/check.svg", class: "h-5 w-5 text-green-600" %>
      <p class="text-gray-500"><%= t(".read") %></p>
    </div>
  </div>
<% else %>
  <div class="flex justify-end my-3 mr-4">
    <div class="flex items-center justify-center space-x-2 text-sm">
      <p class="text-gray-500"><%= t(".unread") %></p>
    </div>
  </div>
<% end %>
```

And this is `app/components/conversations/read_indicator_component.rb`

```ruby
module Conversations
  class ReadIndicatorComponent < ApplicationComponent
    def initialize(user, conversation:)
      @user = user
      @conversation = conversation
    end

    def render?
      @conversation.latest_message&.sender?(@user)
    end

    def show_read?
      @conversation.latest_message_read_by_other_recipient?(@user)
    end
  end
end
```

Is there anything you find weird ? Google it around, or clone the repo and ransack (locally!) the codebase until you find how things work, it's an excellent way to improve skills.

## Conclusion

You can see that all the logic needed to render the component is encapsulated within a single class. It's easy to know exactly what has to be passed into the component for it to be rendered properly as well. And lastly, you are able to do unit tests on ViewComponents which makes it significantly easier to write bug-free code. All of these reasons combined should be more than enough for you to use ViewComponents in all of your Rails projects from now on.