---
layout: post
title: "How to follow HTTP redirects in Node.js"
date: 2012-11-16 06:16
comments: true
categories: 
- node.js
- javascript
---

One of the biggest annoyance with Node.js' native HTTP and HTTPS
clients is that there is no way to automatically follow HTTP redirects.
Let's say you want to fetch the content of a page that has moved (301
redirect), you will have to write a lot of *boilerplate code* to handle
the redirect(s) by yourself.

Since following redirects is fairly common, I decided to write a
a drop-in replacement for the native HTTP and HTTPS module that would handle redirection seamlessly.

This module has exactly the same interface has the native HTTP and HTTPS
module but it will handle redirects automatically. In other words, if
you want to automatically start following redirects, all you have to do
is replace

```javascript
var http = require('http');
```

by

```javascript
var http = require('follow-redirects').http
```

Before that, you will of course need to install the module through NPM:

```bash
npm install follow-redirects
```

More usage info is available at the Github repository: [https://github.com/olalonde/follow-redirects/](https://github.com/olalonde/follow-redirects/)


