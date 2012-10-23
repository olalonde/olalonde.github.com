---
layout: post
title: "Don't run Node.js as root!"
date: 2012-10-24 01:56
comments: true
categories: 
- node.js
---

The [root user](http://en.wikipedia.org/wiki/Root_user) on Linux and Unix operating systems is a special user that has absolutely total power over a machine. It is therefore very important to use the root account only when absolutely necessary and preferrably through the use of a program such as [sudo](http://en.wikipedia.org/wiki/Sudo). From Wikipedia:

> In operating systems which have the concept of a superuser, it is generally recommended that most application work be done using an ordinary account which does not have the ability to make system-wide changes.

Indeed, if you are running your server as root and it gets hacked
through a vulnerability in your code, the attacker will have total control
over your machine. This means the attacker could potentially wipe out
your whole disk or worse instead of having limited permissions as
regular users do. 

The problem most Node.js developers will face is that in order to open
ports below 1024 (i.e. port 80), one has to possess superuser
permissions.  There are a few solutions around that problem, one being the use of `iptables` to redirect port 80 to a higher port such as port 3000, but today I will focus on a solution that can be done entirely within your code.

We still start our server with root permissions using sudo but once we
have opened our port(s), we will revert back our server's permission to that of
a regular user using a special trick. That trick is to read the SUDO_UID
environment variable which sudo passes to any process it launches and
using Node's global `process.setuid()` function.

```javascript
var http = require('http');

var app = function(req, res) {};

http.createServer(app)
  .listen(80, function(err) {
    if (err) return cb(err);

    // Find out which user used sudo through the environment variable
    var uid = parseInt(process.env.SUDO_UID);
    // Set our server's uid to that user
    if (uid) process.setuid(uid);
    console.log('Server\'s UID is now ' + process.getuid());
  });
```

No excuses for running your server as root anymore!

