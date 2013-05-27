---
layout: post
title: "Executing multiple shell commands cleanly in Node.js with async"
date: 2013-05-27 18:04
comments: true
categories: 
- node.js
- async
---

```javascript
async.parallel([
  async.apply(exec, 'git rev-parse HEAD'),
  async.apply(exec, 'git symbolic-ref --short HEAD')
], 
function (err, results) {
  console.log(results);
});
```

First, the `async.parallel` call executes all functions in the array
concurrently. If you need the commands to be executed in order, use
`async.series` instead. `async.apply` returns the function passed as a
first argument with values already applied to its arguments and sets the
`async.parallel` callback for us. Finally, the last functions receives
the results in order when all functions have finished executing. It
preserves the order of results as you would expect them.

For more info: 

[https://github.com/caolan/async](https://github.com/caolan/async)

