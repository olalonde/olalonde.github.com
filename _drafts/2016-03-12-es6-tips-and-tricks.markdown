---
layout: post
title:  "ES6 patterns and tricks"
date:   2016-03-12 17:00:00
comments: true
categories: javascript es6
---

DRAAAAAAAAAFT

Thanks to [Babel](), I have now been exclusively writing ES2015/ES2016
code for the last few months and have learned a few patterns along the
way which I believe make code more readable and bug free. The present
post assumes some level of familiarity with the latest ES standards.  A
lot of those patterns were traditionally only made possible through
external libraries such as [Underscore.js]() but are now easy to do with
vanilla javascript.

## 1) Return statement to expression

```javascript
(res) => { return { res, debug: true } }
```

```javascript
() => ({ res, debug: true })
```

## 2) Tap

```javascript
Somepromise.then((res) => (
  { res, { debug: true } }
))
```

adding a simple temporary console.log in there requires lot of typing

```javascript
Somepromise.then((res) => {
  console.log(res)
  return { res, { debug: true } }
})
```

Introduce the () operator...

```javascript
Somepromise.then((res) => (
  console.log(res),
  { res, someProp: true }
))
```

## 3) Cloning an object

```javascript
var newObj = _.clone(obj)
```

becomes

```javascript
const newObj = { ...obj }
```

## 4) Object with default values

```javascript
var connection = {
  host: opts.host || 'localhost',
  user: opts.user || 'postgres',
  database: opts.database || 'mydatabase',
}
```

becomes

```javascript
const connection = {
  ...{
    host: 'localhost',
    user: 'postgres',
    database: 'mydatabase',
  },
  ...opts,
}
```

`...opts` overwrites any properties above

## 4) Complex conditional or boolean expression to II function expression

/*
Sometimes there are awkward conditional expressions which you wrote
that way just to avoid naming and assigning temporary variables or
mutating a variable
*/

If you're writing functional JS, you sometimes will wonder how to refactor
this sort of code so that you don't mutate the message variable:

```javascript
let message
if (user.isNew) {
  message = 'Welcome!'
} else if (user.isDisabled) {
  message = 'Your account was disabled.'
} else {
  message = 'Welcome back.'
}
```

One option is to use an hard to read ternary conditional expression:

```javascript
var message = user.isNew ? 'Welcome!'
  : (user.isDisabled ? 'Your account was disabled' : 'Welcome back')
```

```javascript
const message = (() => {
  if (user.isNew) {
    return 'Welcome!'
  } else if (user.isDisabled) {
    return 'Your account was disabled.'
  }
  return 'Welcome back.'
})()
```

One advantage of this approach is that it can be used to define
properties on object literals "in line", without assigning an
intermediary variable. For example:

```javascript
const connection = {
  ...{
    adapter: 'psql',
    host: 'localhost',
    user: (() => {
      if (opts.adapter === 'psql') {
        return 'postgres'
      } else if (opts.adapter === 'mysql') {
        return 'mysql'
      }
      return 'oracle'
    })(),
    database: 'mydatabase',
  },
  ...opts,
}
```

I admit this is a contrived example since the above would probably be better
rewritten as:


```javascript
const defaultUsers = {
  psql: 'pogtgres',
  mysql: 'mysql',
  default: 'oracle',
}
const connection = {
  ...{
    adapter: 'psql',
    host: 'localhost',
    user: defaultUsers[opts.adapter || 'default'],
    database: 'mydatabase',
  },
  ...opts,
}
```

## x) Curried funcitons

What used to be verbose and error prone is now relatively simple:

Before:

```javascript
function someFn(arg1) {
  return function(arg2) {
    return function(arg3) {
      // do something
      return arg1 + arg2 + arg3
    }
  }
}
```

After

```javascript
(arg1) => (arg2) => (arg3) => {
  // do something
  return arg1 + arg2 + arg3
}
```

or

```javascript
(arg1) => (arg2) => (arg3) => (arg1 + arg2 + arg3)
```

## x) zip object

```javascript
const keys = [ 'sha1', 'md5' ]
const digests = [ 'DEADBEEF', 'BADA55' ]
const hashes = keys.reduce((acc, key, index) => (
  { ...acc, [key]: digests[index] }
), {})
```
