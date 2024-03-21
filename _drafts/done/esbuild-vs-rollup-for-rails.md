---
title: Rollup vs esbuild
author: david
date: 2024-02-22 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails,hotwire]
pin: false
math: false
mermaid: false
image:
  path: path
  alt: Rollup vs esbuild
---

Rollup and esbuild are two ways to produce an production-optimized JavaScript file, thanks to jsbundling-rails.

## ESBuild vs Rollup locally

You can create a new Rails application, with rollup for handling JS assets, with

```shell
rails new myapp --database=postgresql -j=rollup -c=tailwind
```

`postgresql` is necessary if you want to try the final result in production.

For esbuild, try

```shell
rails new myapp --database=postgresql -j=esbuild -c=tailwind
```

## Difference between ESBuild and Rollup locally

Both are very transparent IMHO. I wrote several articles about the best way to handle JS with Rails some years ago, now I hjave to admit those articles are deprecated.

It's set-and-forget setup, you don't have to care much about how JS files are handled. How great is that!

## The only noticeable difference

Apart from this nice abstraction, I have noticed one difference though : by default, you can debug easily JS by navigation through uncompressed JS files, when you use `rollup`.

With Rollup :

```
├── assets
│   ├── application-e07fd.js
├── javascript
│   ├── controller
│   │   ├── application.js
│   ├── turbo_streams
│   │   ├── focus.js
│   │   ├── log.js
│   ├── darkener.js
│   ├── sidebar.js
```

How good is that? I can debug whatever I want easily.

With Esbuild :

```
├── assets
│   ├── application-a42fc.js
```

You only have the compressed version with `esbuild`. Not a big deal, but here I prefer the rollup version.

## Experimentation on production website

I created a production-ready app, from a [template](/) that has already images, Tailwind (for CSS) and some Stimulus controllers - so assets are here.

I created a first one with ESBuild, and another with Rollup

## Results with Esbuild

So I deployed this template on a Heroku-like platform, and let's see what displaying the Homepage means in terms of resources 

| Status | Method | File  | Type  | Size  |
| ------ | ------ | ----- | ----- | ----- |
| 200   | GET | / | html | 34.11kb | 
| 200   | GET | application-73da2.css | css | 76.88kb | 
| 200 | GET | application-e037f.js | js | 514.80kb |
| 200    | GET | logo-da45f.png | png | 7.94kb |

Ok, that's a good comparison basis. Assets are compressed, so not so easy to read and debug, but after all we are in production mode.

## Results with Rollup

| Status | Method | File  | Type  | Size  |
| ------ | ------ | ----- | ----- | ----- |
| 200   | GET | / | html | 34.11kb | 
| 200   | GET | application-73da2.css | css | 76.88kb | 
| 200 | GET | application-e037f.js | js | 494.52kb |
| 200    | GET | logo-da45f.png | png | 7.94kb |

Ok, no surprise about HTML, CSS, and image.

But what about JS? The compression seems more efficient - remember this is the exact same app.

Moreover, it's still possible to debug JS files (in the web developer tool of the browser) in production website.

I'm not sure this behaviour is intentional, or desirable. But I'm impressed that rollup still allow me to debug things, with a better compression result.

## Summary

Both ESBuild and rollup will achieve the same result with Rails. They take care of assets, and you don't have to care much about it. But rollup seems a little bit better in terms of performance and debug-ability.