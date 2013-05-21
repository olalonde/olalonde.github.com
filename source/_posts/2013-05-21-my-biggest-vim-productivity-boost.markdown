---
layout: post
title: "My biggest Vim productivity boost"
date: 2013-05-21 10:50
comments: true
categories: 
  - vim
---

This week I added the following snippet to my .vimrc (.vimrc.after if you are using Janus):

```vim
map <C-J> :bnext<CR>
map <C-K> :bprev<CR>
map <C-L> :tabn<CR>
map <C-H> :tabp<CR>
```

It maps `CTRL-j` and `CTRL-k` to next and previous buffer and `CTRL-l` and `CTRL-h` to next and previous tabs. 

It is by far the biggest productivity boost I have gotten out of my
`.vimrc` file. 

Buffer and tab switching has never been that fast and easy.

Macbook tip: remap your CAPS LOCK key to CTRL.
