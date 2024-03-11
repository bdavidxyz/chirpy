---
title: AI-Unbeaten algorithm exercise : will MBappe join RealMadrid?
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

## Selling a player in soccer 

You can solve this exercice in the language you prefer, no matter if it's JS, Java, Python, Ruby or PHP.

You can't rely on ChatGPT for this one, since it's not able to deal such a dilemma ;)

I give you input/output as json format, feel free to change format if you don't like it.

- Let's say that MBappé value is 200. It's position on field is "striker".

- A value represents both the strengh of the player, and an amount of money (any unit)

- Let's say that RealMadrid can buy a player, only if it's able to sell players first.

- Let's say that it is not possible for a team, to sell all players of a given position (so you can't sell all strikers at once). 

It means that you need at least one player in each position before to transfer a player

- RealMadrid (as any other team) will try to sell the fewest possible player.

- Despite of rule above, the team will try to keep the strongest possible team, think about it when you are selling players!


## Input and output


```js
// input is as follow, the initial team is like this
[
  {name: "Courtois", position: "goalkeeper", value: 35},
  {name: "Lunin", position: "goalkeeper", value: 8},
  {name: "Mendy", position: "defender", value: 30},
  {name: "Alaba", position: "defender", value: 20},
  {name: "Tchouameni", position: "midfielder", value: 90},
  {name: "Valverde", position: "midfielder", value: 95},
  {name: "Camavinga", position: "midfielder", value: 85},
  {name: "Vinicius", position: "striker", value: 150},
  {name: "Rodrygo", position: "striker", value: 100},
]
```

```js
// after function call, output should be like this
// of course the initial team should now have a new player
{
  player_was_transferred: true,
  sold_players: [{name: "Vinicius", position: "striker", value: 150}, {name: "Camavinga", position: "midfielder", value: 85}]
}
```

## Now it's up to you

Write a function that can work with any other player, any other team.

Think about all corner cases, even the case where the team can't afford the player - it happens too often in real life!

Best of luck!
