---
title: Tailwind vs Bootstrap, from a Rails developer point of view
review: deprecate
author: david
date: 2021-04-06 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600,h_836,q_100/l_text:Karla_72_bold:Tailwind%20vs%20Bootstrap%20%20from%20a%20Rails%20developer%20point%20of%20view,co_rgb:ffe4e6,c_fit,w_1400,h_240/fl_layer_apply,g_south_west,x_100,y_180/l_text:Karla_48:A%20Ruby-on-Rails%20tutorial,co_rgb:ffe4e680,c_fit,w_1400/fl_layer_apply,g_south_west,x_100,y_100/newblog/globals/bg_me.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Tailwind vs Bootstrap, from a Rails developer point of view
---

## Is it related to Rails anyway ?  
  
Tailwind and Bootstrap are both CSS frameworks, so one could argue that they have nothing to do with Rails itself. Which is true. But both try to "get things done" as fast as possible, in the most delightful developer experience, which is something that Rails also tries to achieve. Moreover, a lot of Rails developers used Bootstrap - now they tend to pick Tailwind by default.  
  
## Bootstrap was first in the room  
  
Bootstrap is here for a long time, and still very active today. Strengths are : consistent UI design, cross-devices compatibility, strong responsive considerations, and dynamic components (like navigation bar) that already work out-of-the-box.  
  
Another strength is the community. It is widely used, for a long time, and you will very likely find the theme or help you need.  
  
The main weakness is that it "forces" you to use their design. This is not entirely true since Bootstrap tends to be more and more customisable. But, even for recent versions, some components and behaviours are really hard to tweak without heavy hacks - buttons behaviour, for example.  
  
## Enters Tailwind  
  
Tailwind is a utility-first CSS framework. What does this mean ? A simple example worth thousands explanations, so here is how you style a component with tailwind :  

```css
<div class="flex items-center m-20 border border-gfray-100 rouded shadow p-3">    
    <div class="text-gray-700">
        <h2 class="font-bold text-2xl text-gray-900">David B</h2>
        <div class="text-sm">Product Engineer</div>
        <div class="text-sm">davidb@example.com</div>
        <div class="text-sm">(5595) 9876-4321</div>
    </div>
</div>  
```

At first glance it seems icky. The first time I met Tailwind, I immediately rejected it. I started to reconsider once I saw 1) the skyrocketing number of stars increasing on Github, and 2) the number of well-known people and agencies using it. Probably both are linked, but anyway. I had to reconsider my opinions.
  
What I love with TailWind is the ability to experiment, and to reach a custom design in the fastest possible way.  
  
For a Rails developer, it should sound delightful. Remember how many times you "hack" your feature before you deliver it. The Rails console. The error stack is right in the browser. The business code inside the Model. Just to quickly test things around before refactoring and have a nice production code.  
  
The same applies to Tailwind. You hack things around very fast, and then refactor once you're happy with the result.  
  
The mandatory thing for Tailwind is to "purge" the CSS, or you end up with massive unused CSS files downloaded by the browser, making your website slow(er).  
Another drawback is that you must take care of cleaning up the way your CSS is organised very frequently, if you want to achieve a maintainable, reusable CSS code.  
Lastly, there is no JavaScript inside. Which somes may consider great and logical for a CSS framework, but the drawback is that some dynamic UI component like navigation bar may miss.  
  
  
## Bootstrap 5 : a good compromise  
  
Bootstrap 5 is not yet officially ready for production (at the time of writing, it is still in beta), however I can guess the influence of Tailwind in this last version. There are a lot more utilities classes. Moreover, you will have the ability to define your own utility classes, and purge them later.
  
## So, who wins ?  
  
Sorry for the boring answer here : it depends.  
  
Do you have to go fast into production, with a pre-made, decent design ? Choose a Bootstrap v4 template.  
  
Do you have to achieve a custom design, and you like the hack/refactor coding cycle ? Choose Tailwind.  
  
If you want a mix of both approaches, and you're not afraid of not-yet-stable frameworks, choose Bootstrap v5.  
  
  
## Other possibilities  
  
The two other CSS frameworks I like the most are Inuit and Knacss.  
  
InuitCSS, have a solid foundation and opinion about how to think and structure your CSS code. However the project is not very active these last years.  
  
The other one I like the most is KNACSS, very concise and to the point, but it's more about personal taste here.  
  
Enjoy !  
  
David.