---
layout: post
title: "Functional Javascript notes"
date: 2013-06-26 11:12
comments: true
categories: 
---

How to know you're writing functional Javascript?

Pure functions:

- do not modify arguments
- do not depend on external values (only depend on arguments)
- function call can be replaced with the value of its result and 
  still maintain program consistency

- Idempotence: the idea that executing an activity numerous times has 
  the same effect as executing it once. For example, Math.abs.

```javascript
someFun(arg) == someFun(someFun(arg));
```

In other words, running a function with some argument should be the same
as running that same function twice in a row with the same argument



Same question asked differently:
- If a tree falls in the woods, does it make a sound? NO!
- If a pure function mutates some local data in order to produce an immutable return value, is that OK? YES!

It's ok to mutate as long as it's locally and does not leak out of the
function which shields from impurity.
