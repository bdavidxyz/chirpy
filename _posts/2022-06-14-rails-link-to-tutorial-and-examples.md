---
title: Rails link_to tutorial and examples
author: david
date: 2022-06-14 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Rails link_to tutorial and examples
---

## Ruby-on-Rails and links

The `link_to` helper simply builds links. It works not only to guide the user from one page to another, but to include parameters and queries in the redirection path.

Many will think that the **link_to helper** works exactly as the **href** when using `<a href="URL_path">Go to</a>`, but we will now see how the first option is much more efficient when having complex paths. Moreover, `link_to` will save us from messy interpolations with html and <a href="https://github.com/ruby/erb" target="_blank" >erb</a> such as:

```html
<!-- This works, but... -->
<a href="<%= user_path(@user) %>">My user</a>
```

As you might already know, the redirection features are included in the view pages of an application, [Model-View-Controller architecture](https://www.bootrails.com/blog/ruby-on-rails-mvc/), and rely on the defined **routes** in the routes file (in the config folder). The routes of an application generate different paths that accept instance arguments and translate into URLs to redirect the user. Remember that you can always check the available routes of your application running the command `rake routes` in the console.


## The link_to syntax

The basic syntax of the `link_to` method is as per below:

```erb
<%= link_to "This is a link", link_path %>
```

As you can see, it is only needed to call out the method and then add the text which contains the URL as a string, followed by the redirection path. From this basic structure we will now see how it is possible to easily pass parameters and append other methods such as delete.


## Passing parameters and queries

The link_to method is very powerful because it is able to recognize instances and generate related paths for them. This is very useful, when you have a list of items (objects) and you want to redirect the user to the show page of the selected item. In the example below, we are redirecting the user to the page of the selected restaurant:

```erb
<%= link_to "Select this restaurant", restaurant_path(@restaurant) %>
```

Notice that the @restaurant is the representation of an instance, in this case a specific restaurant.

And of course, it is possible to get the whole list of restaurants loaded in the application:

```erb
<%= link_to "Restaurants", restaurants_path %>
```

Notice the difference in the singular and plural form of the path, when redirecting to a specific restaurant (restaurant_path) or to the whole collection of restaurants (restaurants_path).

It is also possible to pass **search queries** to a link:

```erb
<%= link_to "Thai Food", search_path, query: "Thai restaurant" %>
```

Which would result in a URL like "/search?query=Thai+restaurant"

And also very useful to make the user's navigation fast and friendly is the **:back** feature. It is key in order to redirect the user to the previous page visited, as interfaces often redirect to a certain page from different origins. This can be done using `:back` as route:

```erb
<%= link_to "Back", :back %>
```


## Adding methods: delete

The typical method that is used when redirecting is `delete`, however, you will be able to pass any method defined in your controllers to the link_to helper. The delete method is responsible for deleting a particular instance. For example:

```erb
<%= link_to "Delete restaurant", restaurant_path(@restaurant), method: "delete" %>
```

When calling this type of method you might want the user to confirm the action before executing. The alert can be implemented as per below:

```erb
<%= link_to "Delete restaurant", restaurant_path(@restaurant), method: "delete", { confirm: "Are you sure you want to delete this restaurant?" } %>
```

## Redirecting: icons and images

Using icons and images to anchor links is a common practice in user interfaces. For example, the trash icon to delete an item or the back arrow to return to the previous page.

Some people struggle to add redirection links to this kind of assets with the link_to method because it does not follow the structure that we are used to with href. Let's take a look at the logic, which works equally for icons and images:

```erb
<%= link_to :back do %>
  <i class="icon-back-arrow"></i>
<% end %>
```

In this example we are executing the back redirection with no previous String. The link will be rendered on what we define later using the `do end` structure and then regular html.

## Variants of link_to

The redirecting method provides some interesting variants that will make our code more clean by avoiding complex conditional structures. These variants are:

- link_to_unless_current
- link_to_if
- link_to_unless

The first variant will redirect the user to the corresponding path unless the user is already there without having to reload the page.

The if and unless variants will act as regular conditional statements that will affect the redirection based on one or more conditions.

## Adding style with CSS and classes

Adding style to links with link_to is done through **classes** that are included after the _path:

```erb
<%= link_to "Restaurants", restaurants_path, class: "main-link-style" %>
```

After defining the class or classes in the view, you only need to apply the desired style in the corresponding **css file**.

Remember that it is also possible to apply style using [Bootstrap](https://www.bootrails.com/blog/rails-bootstrap-tutorial/) in the desired classes.

## Conclusion

Navigation is one of the most important things in a user interface. Having a powerful tool, such as link_to is imperative in order to be able to guide the user and create smooth interactions.

Link_to is straightforward and intuitive from a coding point of view. This is key to help you design and understand the navigation in your application, as well as to debug and update when needed.