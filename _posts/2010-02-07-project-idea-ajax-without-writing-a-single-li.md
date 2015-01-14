---
permalink: /project-idea-ajax-without-writing-a-single-li/index.html
sharing_link: /project-idea-ajax-without-writing-a-single-li
layout: post
title: ! 'Project Idea: AJAX without writing a single line of Javascript'
published: true
comments: true
categories:
- idea
- javascript
---
I had this idea of a Javascript library for rapidly implementing / prototyping AJAX on a web page. Here is how it would work:<br /><ol><li>User clicks a link on a page.</li><li>Javascript requests a server side script through an AJAX request and passes the HREF attribute of the link as a parameter <i>target_url</i>. </li> <li>The server script DIFFs the target page with the current page and returns a JSON string containing every modifications of the DOM. The format could be as such:</li></ol>

```javascript
[
{
  "action" : "delete",
  "path" : "/p[1]"
},
{
  "action" : "modify",
  "path" : "/ul[1]/li[1]",
  "node" : {
    "innerHTML" : "modified 1st line",
    "attributes" : {
      "class" : "testClass"
    }
  }
},
{
  "action" : "insert",
  "parentPath" : "/ul[1]",
  "siblingPath" : "/li[3]",
  "node" : {
    "tagName" : "li",
    "innerHTML" : "should insert after 2nd item",
    "attributes" : []
  }
}
]
```

This would delete the first paragraph, modify the 1st list item in the
1st unordered list and insert a new list item before the 3rd list item
in the first unordered list.<p />A use case of this library could be for
a blog with a &quot;Show comments&quot; link. Instead of the browser
reloading the entire page with blog comments enabled when clicking the
link, the request would be sent asynchronously to the server script
which would return the appropriate DOM modifications to display the
comments. Of course, this particular example could easily be implemented
with trivial Javascript, but my point was to show how it would work in
&quot;real life&quot;.<p /><b>Limitations of this technique:</b><br
/><ul><li>innerHTML isn&#39;t (yet) a standard</li><li>Blindly
manipulating the DOM might interfere with other Javascript code already
present on the page</li> <li>The entire process would have to be faster
than actually loading the target page<br /></li></ul><b>Benefits of this
technique:</b><br /><ul><li>It could be used to unobtrusively implement
AJAX without having to write a single line of Javascript, resulting in a
productivity increase.</li> <li>It could possibly be used as a browser
add-on to enable faster page rendering. (This idea came from my
frustration of having to wait for the whole DOM to be re-rendered by web
browsers when clicking links within a site. Often times, a big part of
the DOM structure remains the same and yet, your browser has to render
everything once again.)</li></ul><b>In a nutshell:</b><br /><ul><li>This
technique should be used for productivity boosts and on pages that share
a similar layout.<br /></li></ul>I had a hard time putting this idea
into words and I hope I made myself clear. I would appreciate some
feedback from fellow developers!<p /> PS: So far, I&#39;ve done most of
the Javascript implementation. If anyone is willing to help for the
server script, let me know!
