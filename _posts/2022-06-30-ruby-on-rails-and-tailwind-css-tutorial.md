---
title: "Ruby-on-Rails and Tailwind CSS Tutorial"
author: david
date: 2022-06-30 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: "Ruby-on-Rails and Tailwind CSS Tutorial"
---

## Why should you use Tailwind CSS with Rails?

Tailwind CSS's core concept is its utility-first fundamentals, aka being able
to build complex components from a constrained set of simple utilities. This brings many benefits and I'll be listing them in no particular order!

1. **No more wasting energy coming up with class names**: Now to style a particular component, all you need to do is use the utility classes on said component directly in the HTML file. There's no longer any need to find the perfect abstract class name to name the component so you can style it in a separate CSS file.

2. **Rarely have to write new CSS**: Since utilities are reusable and can cover nearly every conceivable situation, your CSS files will stop growing! They'll finally be maintainable and slim.

3. **Safer changes**: Classes inside of HTML are local, so they can be changed without worrying about breaking anything else. This contrasts CSS, which is global-- if you change something, it can cause a whole slew of issues.

5. **High performance**: Tailwind aims to produce the smallest possible CSS file by only generating the CSS you actually use in your project. Combined with optimizations like minification and network compression, this results in absurdly light CSS files (less than 10kB).

All of this results in code that's quick to write, easy to maintain, and scales easily no matter how large the project becomes. Just think about it, would you rather...

- Reuse utility classes or come up with a class name, then write lots of CSS for it?
- Would you rather debug by looking at a list of utility classes that apply to a single component, or scan through a couple huge CSS files?
- Imagine if you're working with a codebase that dozens of software developers have contributed to. Would you rather work with code that's completely consistent due to utility classes, or toil through HTML/CSS and see what styles apply to every component and why.

## Common concerns with Tailwind CSS

### Why not just use inline styles then?

1. **Designing with constraints**: If you use inline styles, every value is a magic number. With utilities, you're choosing styles from a predefined design system so it'll be easier to create visually consistent user interfaces.
2. **Responsive Design**: It's not possible to use media queries in inline styles, but Tailwind CSS has responsive utilities to easily build responsive interfaces.
3. **State Management**: Inline CSS can't target states like hover, focus, etc while Tailwind CSS's state variants make it easy to style said states with utility classes.

### It isn't DRY! (Don't Repeat Yourself)
 But what if a bunch of components require the same repeated utility combinations? It certainly isn't DRY to write them over and over again. These issues can be resolved with the following solutions from <a href="https://tailwindcss.com/docs/reusing-styles" target="_blank"> Tailwind CSS reusing styles guide</a>...

 1. **Loops**: Render the actual markup in a loop if it's simply a series of repeats that are only used once.
 2. **Extracting components and partials**: If some styles need to be reused across multiple files, the best strategy is to create a component or partial depending on if you're using a front-end framework or a templating language.
 3. **Extracting classes with @apply**: If you're using a templating language, then sometimes it feels like overkill to create a partial for something small that can be done in a basic CSS class. And this is where the @apply directive comes in; compose a custom CSS class using existing utilities.

## Tailwind CSS vs Bootstrap 5

Tailwind CSS is currently the most popular utility-first CSS framework, while Bootstrap 5 is the most popular UI kit (a collection of pre-built components and resources). We already have a tutorial about [Rails and Bootstrap](https://www.bootrails.com/blog/rails-7-bootstrap-5-tutorial/), and we also discussed about [Tailwind vs Bootstrap for a Rails app](https://www.bootrails.com/blog/tailwind-vs-bootstrap/). Our choice so far is to stick with Bootstrap, as long as you can purge the CSS at the end of the journey.

### What does Tailwind CSS do better than Bootstrap 5?

With Tailwind you (theoretically) don't have to write any CSS class, instead you put existing utility CSS classes directly into your HTML - no more CSS file. And no more "magic number", every font, color, spacing belongs to a well-designed, pre-defined scale.

### What does Bootstrap 5 do better than Tailwind CSS?

Bootstrap is more well-known, so you will find help more easily than with Tailwind (so far). You can add your own CSS classes more easily - whereas this is discouraged for Tailwind. Which also means that tweaking is possible.

So far with Bootrails we have stuck to the very latest Bootstrap version available, notably because all the dynamic components are 1) accessible (a11y) and 2) already free, open-source, and included in the stack. This is a private, locked-in topic in the Tailwind area.

## Creating a Rails application utilizing Tailwind CSS

### First, ensure that you have all the necessary tools installed

```bash
$> ruby -v  
ruby 3.1.2 # you need at least version 3 here
$> rails -v
Rails 7.0.2.4 # And Rails 7 to keep things fresh
$> bundle -v  
Bundler version 2.3.14 # Bundler 2.xx
$> foreman -v
0.87.2
```

### Initialize and setup the project

```bash
rails new --css tailwind my_project
cd my_project
```

Then run this command to complete the setup!
```bash
foreman start -f Procfile.dev
```

### Create routes, a controller, and a view to play around with!

Configure a default route:

```bash
echo "Rails.application.routes.draw do" > config/routes.rb  
echo ' get "welcome/index"' >> config/routes.rb  
echo ' root to: "welcome#index"' >> config/routes.rb  
echo 'end' >> config/routes.rb  
```

Create a controller:

```bash
echo "class WelcomeController < ApplicationController" > app/controllers/welcome_controller.rb  
echo "end" >> app/controllers/welcome_controller.rb  
```

Create a view:

```bash
mkdir app/views/welcome  
echo '<h1 class="text-3xl font-bold underline">Hello world!</h1>' > app/views/welcome/index.html.erb  
```

And now you should be able to see the view by pasting http://127.0.0.1:3000 into your browser!

<figure>
  <img style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/v1656581982/rails/tailwind_result.png" loading="lazy" alt="localhost">
  <figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:80%">Tailwind classes</figcaption>  
</figure>

The absolute best way to learn is just to experiment and see what happens. Write HTML with Tailwind CSS utility classes inside of index.html.erb and see what you can create! As always, have the <a href="https://tailwindcss.com/docs/installation" target="_blank"> Tailwind CSS documentation</a> on hand when learning something new!

## Conclusion

Tailwind CSS's utility-first approach makes it easy to style your application quickly. Not only is it quick to code in, it's also extremely maintainable and scales very well as the application gets larger. If you play around with the utility classes, you'll notice two things immediately: it's consistent and self-contained. This makes it really simple to reason about how components are styled-- it's right there in front of you! I hope that you'll give Tailwind CSS and the utility-first paradigm to writing CSS a chance.