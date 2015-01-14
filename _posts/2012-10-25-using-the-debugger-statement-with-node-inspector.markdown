---
layout: post
title: "Using the debugger statement with node-inspector"
date: 2012-10-25 15:41
comments: true
categories: 
- node.js
- javascript
---

The first thing client-side Javascript developers miss when
starting out with Node.js is the ability to debug their code through
a GUI debugger as they are acustomed to when developing for the browser.

Fortunately, it wasn't long before the Node.js community came up with
GUI debuggers and as of today, the most widespread one is [node-inspector](https://github.com/dannycoates/node-inspector). 

In this post, I won't go into the details of using node-inspector but I
will instead introduce a neat feature that many Node.js developers aren't aware of
or don't know how to use.

This feature is called the `debugger` statement. If you have ever caught
yourself firing up node-inspector and browsing through the huge file
pane on the left in order to find a file and insert a breakpoint, then
this post should save you a lot of trouble in the future.

Here's what the [ECMA-262 specification](http://www.ecma-international.org/publications/files/ECMA-ST/Ecma-262.pdf) 
has to say about the `debugger` statement:

> Syntax
>
>  DebuggerStatement :

>    `debugger ;`

> Evaluating the DebuggerStatement  production may allow an implementation to cause a  breakpoint when run 
under a debugger. If a debugger is not present or active this statement has no observable effect.

In other words, you can insert breakpoints directly in your code using
`debugger;`, fire up your app in debug mode, open your debugging client
and the breakpoint will be set. Don't forget to remove `debugger;` from
your code once you are done debugging!

Here's a quick demonstration.

1. Insert debugger; statement in your code

    ![screen shot](http://i.minus.com/ibd1ju4lGR4i1u.png)

2. Fire up node-inspector

    ```bash
    node-inspector;
    ```

3. Launch your app in debugging mode (don't forget to use the
   `--debug-brk` flag if your debugger statement is "early" in your code)

    ```bash
    node --debug server.js
    ```

4. Open the debugging client

    ![screenshot](http://i.minus.com/ibqWEpgANEWaeM.png)


No more hunting for files!
