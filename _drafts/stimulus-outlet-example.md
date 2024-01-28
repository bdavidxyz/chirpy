---
title: Stimulus outlet example
author: david
date: 2024-02-22 11:33:00 +0800
categories: [rails]
tags: [rails]
pin: false
math: false
mermaid: false
image:
  path: path
  alt: Stimulus outlet example
---

## How to understand StimulusJS

Stimulus doesn't serve the same purposes than Vue or React, so basically you will not find the same concepts.

The best things to do with Stimulus (IMHO) is to learn by example.

The good news is, there are not so much things to understand with StimulusJS. I found it very Rails-y framework, because the glue is made thanks to by following naming conventions.

## Stimulus outlet

You will need a Stimulus outlet when you want to control multiple elements on the same page, at once.

For example, if you want to expand all side of an accordion. Or toggle all checkboxes of an "accept cookies" modal.

You could do this with TurboStream of course, but when the need is purely on the frontend, then you have Stimulus.

## Tutorial from scratch

We will build a "accept cookies" page here