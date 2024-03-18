---
title: restore locally a hatchbox-deployed app
author: david
date: 2024-03-25 11:33:00 +0800
categories: [ruby-on-rails]
tags: [ruby-on-rails,hotwire]
pin: false
math: false
mermaid: false
image:
  path: path
  alt: How to add or remove a Stimulus controller
---

1) ask for backup in the UI

2) pull the backup locally

scp -r deploy@159.xx.x.xxx:~/backups/db_3783a6ce5fd9 /home/david/workspace/

3) extract the file locally

Right-click on the file in the file explorer and click on "extract here"

4) move and rename

mv 

5) drop local database and recreate

br db:drop
br db:create

6) use pg_restore 

pg_restore -d saaslitcom_development /home/david/workspace/latest.sql
  