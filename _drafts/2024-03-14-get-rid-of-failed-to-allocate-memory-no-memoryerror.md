---
title: Get rid of Rails Failed to allocate memory (No MemoryError)
author: david
date: 2024-03-14 06:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails]
pin: false
math: false
mermaid: false
image:
  path: https://res.cloudinary.com/bdavidxyz-com/image/upload/w_1600%2Ch_836%2Cq_100/l_text:Karla_72_bold:Get%20rid%20of%20Rails%20Failed%20to%20allocate%20memory%2Cco_rgb:ffe4e6%2Cc_fit%2Cw_1400%2Ch_240/fl_layer_apply%2Cg_south_west%2Cx_100%2Cy_180/l_text:Karla_48:Or%20how%20I%20badly%20tried%20to%20solve%20a%20bug%2Cco_rgb:ffe4e680%2Cc_fit%2Cw_1400/fl_layer_apply%2Cg_south_west%2Cx_100%2Cy_100/newblog/globals/bg_me.jpg
  alt: Get rid of Rails Failed to allocate memory (No MemoryError)
---


## Failed to allocate memory (No MemoryError)

I had this problem quite randomly, when I was booting a new Rails 7 application from a template.

Despite removing / recreating the project from scratch, I still go this error from Bootsnap

```shell
bootsnap - Failed to allocate memory (No MemoryError)
```

## How to reproduce this error

You can't. There is a <a href="https://github.com/Shopify/bootsnap/issues/448" target="_blank">opened issue on GitHub</a> about this.

## Don't do things like I did

Don't be impatient like me. Here is what I did :

- Reboot my machine (didn't solve the problem)
- Upgrade the OS (didn't solve the problem, but at least my OS was up-to-date)
- Reinstalled rbenv (still had the bug)

## What I should have done

I should have checked earlier that the problem was specific to the project. I mistakenly thought it was not the case after reinitializing everything.

> Error doesn't come from what we don't know. It often comes from what we mistakenly admitted as true.
{: .prompt-tip }

I should have tried to reproduce the bug on another unlinked project.

I should have read one more time <a href="https://www.thegreatcodeadventure.com/how-to-get-un-stuck/" target="_blank">how to get un-stuck</a>

## Solution to (No MemoryError) error

I ended up by removing the `tmp` folder of the project, which worked. Now this bug may still occurs from time to time, but I know how to correct it.

I plan now to remove bootsnap from my default template. 😬

## Summary

It was *that* weird bug that you don't want to encounter, and that makes this job sometimes difficult - but how enjoyable once corrected.

Lastly, if I may ask a question : what is your relationship with bootsnap?

