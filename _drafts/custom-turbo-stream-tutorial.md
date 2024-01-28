---
title: How to add or remove a Stimulus controller
author: david
date: 2024-02-22 11:33:00 +0800
categories: [rails]
tags: [rails,hotwire]
pin: false
math: false
mermaid: false
image:
  path: path
  alt: How to add or remove a Stimulus controller
---

## How to add a Stimulus controller

```shell
bin/rails generate stimulus foo
```

I don't always rely on Rails generator, I parcularly enjoy to write Rails migration file by myself.

However I advise to stick with the generator for Stimulus, I find it safer, to avoid spelling mistakes - remember that Rails relies on naming conventions to wire things together.

Now the Stimulus controller is generated as follow inside the `app/javascript/controllers/index.js` file :

```js
// app/javascript/controllers/index.js

import { application } from "./application"

import HelloController from "./hello_controller.js"
application.register("hello", HelloController)

import FooController from "./foo_controller.js"
application.register("foo", FooController)
```

## How to remove a Stimulus controller

```shell
bin/rails destroy stimulus foo
```
> This command may fail, so check that lines were correctly removed inside `app/javascript/controllers/index.js`.
{: .prompt-danger }

If not, then manually remove the two lines, and run `bin/rails stimulus:manifest:update`. 

## Tutorial from scratch

