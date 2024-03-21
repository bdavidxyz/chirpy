---
title: Rails callbacks tutorial
author: david
date: 2024-03-04 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:Rails%20callbacks%20tutorial,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:Insights%20and%20tutorial%20from%20scratch,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  alt: Rails callbacks tutorial
---

inside `app/controllers/welcome_controller.rb`

```shell
class WelcomeController < ApplicationController  
  
  # welcome_path GET /welcome  
  # root_path GET /  
  def index  
  end  
    
  # update_book_path POST /welcome/update_book  
  def update_book  
  end

  def book_params  
    params.require(:book).permit(:title).to_h  
  end  
end
```

inside `app/views/welcome/index.html.erb`

```erb  
<h1>Welcome ! This is a tutorial about Rails forms</h1>  
  
<%= form_with scope: "book", url: update_book_path, method: :put do |form| %>  
  <%= form.text_field :title %>  
  <%= form.submit "Create" %>  
<% end %>  
```  

  
inside `config/routes.rb`

```ruby  
Rails.application.routes.draw do  
  get "/welcome", to: "welcome#index"  
  put "/welcome/update_book", to: "welcome#update_book", as: 'update_book'  
    
  root "welcome#index"  
end  
```  


Now type in your terminal  
  
```shell  
bin/rails db:create db:migrate
bin/rails server  
```


