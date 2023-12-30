---
title: Rails, How to work with Bootstrap v5
author: david
date: 2021-05-06 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: v1702310772/newblog/globals/Mediamodifier-Design-Template_2.jpg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Rails, How to work with Bootstrap v5
---

## 0. Setup
If you want a setup from scratch, see [this article](https://bootrails.com/blog/rails-bootstrap-tutorial).  
  
## 1. Download the source file  
  
Go to the "download" section of Bootstrap, the URL should look like [https://getbootstrap.com/docs/5.0/getting-started/download/](https://getbootstrap.com/docs/5.0/getting-started/download/) - the version number may vary, it depends which version you prefer.  
  
Then click on "Download source".  
  
Unzip the file, then open the created directory, and copy the scss folder.  
  
<figure>
  <img style="display:block;float:none;margin-left:auto;margin-right:auto;width:60%" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/c_thumb,w_200,g_face/v1617280411/rails/folders2.png" loading="lazy" alt="Scss folder">
  <figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:60%">Scss folder</figcaption>
</figure>
  
Then paste it at the root of your regular workspace folder, and give this folder a memorable name (like bs5_scss)  
  
## 2. Open a workspace  
  
Now open your favorite code editor (here Sublime on the screenshot) at the root of this new folder  
  
<figure>
  <img style="display:block;float:none;margin-left:auto;margin-right:auto;width:60%" src="https://res.cloudinary.com/bdavidxyz-com/image/upload/v1617280667/rails/sublime_bs5.png" loading="lazy" alt="Bootstrap and Sublime">
  <figcaption style="display:block;float:none;margin-left:auto;margin-right:auto;width:60%">Bootstrap and Sublime</figcaption>
</figure>
  
Good ! now you are able to search in the pre-compiled stylesheet.  
It's also worth reading the code to see how the CSS is structured.  
  
After the quick tour, open the _variables.scss file.  
  
## 3. Let the _variables.scss file open  
  
Note that you can change the SCSS, but the most customizable file is _variables.scss - hence the name.  
  
Outside these variables, deep Bootstrap customisation is still possible, but is more hacky - you have to be good at CSS.  
  
My advice here is to stick to the _variables.scss file customisation, and simply use the capacity of each CSS property to be overloaded if you need deeper customisation. Thus, you won't risk breaking Bootstrap's internal mechanisms.  
  
One good news is that version 5 of Bootstrap is deeply customisable, and in these times of utility-first CSS classes, you can even add your [own utility classes](https://getbootstrap.com/docs/5.0/utilities/api/).  
  
## 4. Be able to toggle with this workspace  
  
Now each time you have to work with Bootstrap, you can simply read the sources, it's even easier if you are able to toggle between your IDE's workspaces. I've mapped the CMD + @ shortcut on my Mac to allow window switching, you probably have another trick in your environment.  
  
## 5. Let's the official docs in the browser open  
  
This is a no-brainer : open the official docs [here](https://getbootstrap.com/docs/5.0/getting-started/introduction/), and use the "search" button on the top-left corner. I can't remember when Bootstrap added a fuzzy search, but I find it extremely useful for daily coding.  
  
## 6. Conclusion  
  
I think that the combination of a tab opened to the official docs and a workspace opened to the source is extremely powerful.  
  
You can't memorize all the selectors and all the way of thinking of a CSS framework.  
  
That's very true for heavy CSS frameworks like Tailwind or Bootstrap. And still relevant if you use a smaller CSS framework (in this case, a cheatsheet could suffice though).