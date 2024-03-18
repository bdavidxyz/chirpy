---
title:  The simplest turbo-frame example
author: david
date: 2024-03-18 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails, hotwire]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600%2Ch_836%2Cq_100/l_text:Karla_72_bold:Simplest%20turbo%20frame%20example%2Cco_rgb:ffe4e6%2Cc_fit%2Cw_1400%2Ch_240/fl_layer_apply%2Cg_south_west%2Cx_100%2Cy_180/l_text:Karla_48:How%20following%20conventions%20helps%2Cco_rgb:ffe4e680%2Cc_fit%2Cw_1400/fl_layer_apply%2Cg_south_west%2Cx_100%2Cy_100/newblog/globals/bg_me.jpg
  alt: Simplest turbo frame example
---

## What is a turbo frame ?

A turbo frame is a node of the DOM that is able to be replaced by another, without refreshing the browser (when the user clicks on a button for example).

Think about the old days where you had to update the DOM through an ajax request (without a full page reload).

## Unexplained (but short) answer

For those who already knows a little about Rails and Hotwire, and just want a quick check about syntax, here is the full (unexplained) answer :


```ruby
# inside config/routes.rb
  post "full_list", to: "welcome#full_list"
```

```ruby
# inside app/controllers/welcome_controller.rb
class WelcomeController < DashboardController

  def full_list
  end
  
end
```

```erb
<!-- inside app/views/welcome/index.html.erb -->
<turbo-frame id="view_more">
  <%= button_to "View all", full_list_path %>
</turbo-frame>
```

```erb
<!-- inside app/views/welcome/full_list.html.erb -->
<turbo-frame id="view_more">
  <p>
    That's all! Nothing else to show.
  </p>
</turbo-frame>
```

## A little bit of context

Rails is well known for it's "convention over configuration" paradigm. With simpler words, it means "as long as you follow naming conventions, everything works".

When discovering new features like Turbo and Hotwire, "everything works" usually starts by "everything is buggy"

So I decided to put this article as a reference for people who begins with Turbo Frame.

The bare minimum conventions not be off the Rails.


## Prerequisites

```shell
ruby -v  # 3.3.0
rails -v  # 7.1.3
bundle -v  # 2.4.10
node -v # 20.9.0
git --version # 2.34.1
```

## Before turbo frames

As (every Monday actually;), build the bare minimum files to play with Rails, by creating a route, an associated controller, and a view :

```shell
rails new myapp
cd myapp
```

Then

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
echo '<h1>turbo_frame tutorial</h1>' > app/views/welcome/index.html.erb

```

Then create database,

```shell
bin/rails db:create db:migrate
```

Then launch your local Rails server by typing :

```shell
bin/rails server
```

You should see the title "turbo_frame tutorial" when opening your browser at localhost:3000


## Minimalistic turbo_frame

Actually, there is a simpler example, that directly <a href="https://turbo.hotwired.dev/reference/frames#eager-loaded-frame" target="_blank">loads the content of a frame from a source</a>.

But I didn't had the use case so far, so I'll show an example where the turbo_frame is shown after a button has been clicked.

## More realistic and simple turbo_frame



Controller and route has nothing special, it's plain old Rails.

```ruby
# inside config/routes.rb

  # add this line, below Rails.application.routes.draw do
  post "full_list", to: "welcome#full_list"
```

```ruby
# inside app/controllers/welcome_controller.rb
class WelcomeController < DashboardController

  def full_list
  end
  
end
```

> There is nothing special to do in the controller when using turbo_frame
{: .prompt-tip }

Now the interesting part

```erb
<!-- inside app/views/welcome/index.html.erb -->
<!-- add these lines below the h1 title -->

<turbo-frame id="view_more">
  <%= button_to "View all", full_list_path %>
</turbo-frame>
```

Notice that the turbo-frame element is a <a href="https://developer.mozilla.org/en-US/docs/Web/API/Web_components/Using_custom_elements" target="_blank">HTML custom element</a>.

It's coming from Turbo, so you don't have to define it yourself.

> Use `<turbo-frame id="">` and not `<div id="">` if you want frames to update your DOM.
{: .prompt-tip }


```erb
<!-- inside inside app/views/welcome/full_list.html.erb -->
<turbo-frame id="view_more">
  <p>
    That's all!
  </p>
</turbo-frame>
```

> Use `.html.erb` extension, and not turbo_stream.html.erb
{: .prompt-tip }

> Use the exact same `<turbo-frame> id` inside the returned partial.
{: .prompt-tip }

To sum up,

> All you have to do is to take care about file and folder naming conventions, and Rails will take care about updating the right element of the DOM.
{: .prompt-danger }

## Checking the code

Relaunch your local web server, and refresh the browser at localhost:3000

When you click the button, you should see "That's all", instead of the button. If this doesn't work, you probably missed something in the above steps :)

Don't forget to check the network request inside the web developer tools of the browser, in order to grab what is going on.

## Summary

Turbo frame is some kind of weird name, for a very old and simple concept : update the DOM after a user action.

When following convention properly, Rails handles this for you very nicely :)