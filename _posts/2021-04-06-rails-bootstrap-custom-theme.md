---
title: How to create a custom Bootstrap theme for Rails
review: deprecated
author: david
date: 2021-04-06 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:How%20to%20create%20a%20custom%20Bootstrap%20theme%20for%20Rails,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:A%20Ruby-on-Rails%20tutorial,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: How to create a custom Bootstrap theme for Rails
---

## 0. Prerequisite

You will need both Rails and Bootstrap for this tutorial. I already [wrote a tutorial](https://bootrails.com/blog/rails-bootstrap-tutorial) about this, so just follow the steps, or checkout the [corresponding GitHub repository](https://github.com/bdavidxyz/bootstraprails) in order to start this new tutorial.

## 1. SCSS is standard for Rails and Bootstrap

The language we will use is SCSS (Sassy CSS). It's a well-known CSS preprocessor, heavily used in both Bootstrap and Rails space. Amongst other things, it adds variables, functions, maps and syntaxic sugar to the plain old CSS language. The good news is that plain old CSS is still valid when writing a SCSS file, so the entry barrier is very low.

## 2. File structure

Create an empty file `app/frontend/css/customized_bootstrap.scss` 

This will be our main customisation file.

Open app/frontend/packs/application.scss, and copy/paste the following code : 

```scss
@import '../css/customized_bootstrap.scss';
@import "~bootstrap/scss/bootstrap";
```

So you should end up with the following file structure.

```tree
+-- app
    +-- frontend
        +-- css
            +-- customized_bootstrap.scss
        +-- packs
          +-- application.scss
```

As a reminder, everything under the "frontend/packs" directory will be compiled by webpacker, and may be referenced by any HTML file.

Every other directory under the "frontend" directory can be considered as private : our application can use those files, but they are not visible to the end user.

So everything should be logical so far : we have one stylesheet pack for the whole application, and one main customisation file that will allow us to fine tune Bootstrap.


## 3. Main customisation file : structure

Now copy/paste the code below inside  `app/frontend/css/customized_bootstrap.scss` 

```scss
/** 
* 1 - Set SCSS variables below
*/

/** 
* 2 - Import bare minimum of bootstrap
*/
@import "~bootstrap/scss/functions";
@import "~bootstrap/scss/variables";

/** 
* 3 - Now you can refine Bootstrap here
*/
```
As you can see, there are three parts : 

First, you set variables. Either the some of Bootstrap, or your own. Second, you import all Bootstrap variables and functions. Don't worry, Bootstrap will NOT override the variable you defined before. And lastly, you may define any CSS selector that rely on any variable.


## 4. Main customisation file : fine tune

For bootrails, here is a (very simplified) overview of how I use this customisation file :

```scss
/** 
* Set SCSS variables below
*/

// Custom variable, prefix with my- to avoid confusion
$my-navbar-height: 60px;

// Bootstrap setting
$enable-negative-margins: true;

// Bootstrap variable : typography
$lead-font-weight: 400;

/** 
* Import bare minimum of bootstrap
*/
@import "~bootstrap/scss/functions";
@import "~bootstrap/scss/variables";

/** 
* 3 - Now you can refine Bootstrap here
*/

// missing utility function
.cursor-pointer {
  cursor: pointer;
}

// new utility class that relies on Bootstrap variable
.halflead {
  font-size: $font-size-base * 1.125;
}
```

## 5. Add custom components for Bootstrap

Note that the main customisation should remain relatively small, I would say I will end up with a few hundreds of lines, but no more.

In order to avoid a maintenance nightmare, you must rely on small  SCSS components, that are focused on only one thing (single responsibility principle) : style a well-identified piece of HTML : a footer (c-footer.scss), a blog article (c-article.scss), and so on.

Side-note : this is not specific to Rails or Bootstrap. "Stay small and focused" is a well-known programming principle.

So now, how do you achieve this ?

Create a folder `app/frontend/css/components`

And reference any file inside thanks to the main entry file application.scss, like this :

```scss
// inside app/frontend/packs/application.scss

@import '../css/customized_bootstrap.scss';
@import "~bootstrap/scss/bootstrap";

// Automagically loads all our custom components thanks to node-sass-glob-importer
@import '../css/components/*.scss';
```
And now our tree structure looks like this :

```tree
+-- app
    +-- frontend
        +-- components
            +-- c-article.scss
            +-- c-footer.scss
            +-- ...
        +-- css
            +-- customized_bootstrap.scss
        +-- packs
          +-- application.scss
```

Note the use of "c-" as a prefix, it's known as the [BEM convention](https://csswizardry.com/2015/08/bemit-taking-the-bem-naming-convention-a-step-further/). Since Bootstrap doesn't follows this convention, it makes instantaneously clear that these component are our own, avoiding confusion with Bootstrap's own components.

## 6. Conclusion

Customise Bootstrap with Rails is not very complicated : Bootstrap v5 opened wide the doors (and variables file) to make it easy. Don't worry there is still the possibility to override selector if things get too complicated, while maintaining a nice CSS structure.