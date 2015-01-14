---
layout: post
title: "Connectr: Programmatically manipulating the Connect stack"
date: 2013-05-18 12:36
comments: true
categories:
  - node.js
  - javascript
---

[Connectr](https://github.com/olalonde/connectr) is a Node.js module I wrote that aims to solve the following problem: how
to manipulate the [Connect](https://github.com/senchalabs/connect) stack after it has been created.

This is a problem I faced while writing a REST framework on top of [Express.js](http://expressjs.com). The framework initialized the middleware stack but there was no easy way to expose the stack to end users of the framework so they could add their own middlewares at arbitrary positions on the stack.

# Install

    npm install connectr

# Usage

```javascript
var connectr = require('connectr')(app);

// Add labeled middleware
connectr.use(middleware).as(label);

// Insert before middleware
connectr.before(label).use(middleware).as(label);

// Insert after middleware
connectr.after(label).use(middleware);

// Remove middleware
connectr.remove(label);

// the .as, .before and .after calls are optional
```

# Simple Example

```javascript
var connect = require('connect'),
var app = connect();
var connectr = require('connectr')(app);

connectr.use(connect.cookieParser).as('cookieParser');

/* ... */

connectr.before('cookieParser').use(function (req, res, next) {
  console.log('Before cookie parser...');
  next();
}).as('log before cookie parser');

```

I am hoping the methods that Connectr provide can eventually be
supported natively by Connect but until then, Connectr does the job.

If you use Connectr, please [star the project on Github](https://github.com/olalonde/connectr/blob/master/README.md) to show your support.

Happy coding!

