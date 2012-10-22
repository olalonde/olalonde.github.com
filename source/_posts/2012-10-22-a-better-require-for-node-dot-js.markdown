---
layout: post
title: "A better require() for Node.js"
date: 2012-10-22 17:20
comments: true
categories: 
  - node.js 
  - javascript 
---

While reading the Node.js API documentation today, I stumbled upon an [interesting feature](http://nodejs.org/api/all.html#all_require_extensions). This feature let's you add handlers for arbitrary file extensions that `require()`  will call when requiring a file of that extension. Internally, it looks for the extension in `require.extensions` and if the extension is found, the handler is called instead of the default require routine. 

I thought that was pretty cool so I couldn't resist the urge of wrapping a bunch of file parsers into a standalone NPM module that would make it easy to support for multiple file formats through `require()`.

This gave birth to [better-require](https://github.com/olalonde/better-require).

    npm install better-require

If allows developers to seamlessly require `json`, `yaml`, `csv`, `xml` and `ini` files without having to deal with `require.extensions` or finding the appropriate parsing libraries. It is also easily extensible so feel free to fork and add additional file formats!

Here's a usage example:

```javascript
require('better-require')('json yaml xml');

// we can now require .xml, .yaml and .xml files!

var yaml = require('./config.yaml')
  , json = require('./config.json')
  , xml = require('./config.xml');

console.log(yaml);
console.log(json);
console.log(xml);
```

Enjoy!
