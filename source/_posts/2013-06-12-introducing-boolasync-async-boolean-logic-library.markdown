---
layout: post
title: "Introducing Boolasync - a library for async boolean logic"
date: 2013-06-12 00:23
comments: true
categories: 
  - node.js
  - javascript
---

- Github: [olalonde/boolasync](https://github.com/olalonde/boolasync)
- NPM: `npm install boolasync`
- License: MIT

Who would have thoughts things would have gone that far? Yes, I have
created a Javascript library for handling boolean logic that involves asynchronous
callbacks.

Let's say you have a web app that has an authorization layer like so:

```javascript
if (is_user() && (is_admin() || is_super_admin()) {
  console.log('Authorize!');
}
```

Note: this is a fictional example for purposes of demonstration.

However, here is the catch: your functions are asynchronous which means
that they take a callback argument which in turns takes an error and
result argument. `function callback(err, res) {}`

How do you rewrite the above code elegantly?

You could use the nice `async` library.

```javascript
async.parallel([
  is_user,
  is_admin,
  is_super_admin
], function (err, results) {
  if (results[0] && (results[1] || results[2])) {
    console.log('Authorize!');
  }
});
```

There are two problems however: 

1. The code is not very expressive.

2. We have to wait for all functions to finish. 

    In the example above, if `is_user` returns `false`, we would already know that the user is not
    authorized. `false && ...` is always false no matter what the `...`
    represents. In computer science, this is called lazy evaluation.

Here is how you would rewrite the above with boolasync:

```javascript
is_user.and(is_admin.or(is_super_admin)).eval(function (err, authorized) {
  if (authorized) {
    console.log('Authorize!');
  }
});
``` 

Notice how terse and expressive the code is compared to the async
example. In bonus, boolasync won't wait for an async call to terminate if it already knows the result
of an expression.

For more documentation and examples, visit the Github page: [https://github.com/olalonde/boolasync](https://github.com/olalonde/boolasync)

Cheers!
