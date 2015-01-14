---
layout: post
title: "Pagination with Handlebars"
date: 2012-11-17 09:05
comments: true
categories: 
- javascript
- node.js
---

Pagination can be quite tricky with Handlebars since Handlebars does not
have any built in way to do for/while loops. One solution mix some presentation code
within your logic layer and passing an array containing all your pages in an array.

For example:

```javascript
{
  pagination: [ 
    { previous: disabled }, 
    { page: 1, active: true }, 
    { page: 2 }, 
    { page: 3 },
    { page: 4 },
    { page: 5 }
  ] 
}
```

This solution has several drawbacks: mixing of logic/view code, code
duplication, difficult to reuse, etc. 

The other, cleaner solution, is to write a Handlebars helper, which I
have already done so you don't have to!

![screenshot](https://github.com/olalonde/handlebars-paginate/raw/master/screenshot.png)

The helper is available for download or forking on Github: 

[https://github.com/olalonde/handlebars-paginate](https://github.com/olalonde/handlebars-paginate)

or through NPM:

```bash
npm install handlebars-paginate
```

To use it, all you have to do is register it as an helper:

```javascript
Handlebars.registerHelper('paginate', require('handlebars-paginate'));
```

And all you need to pass to your template is an object containing a
`page` parameter which is the number of the current page and a
`pageCount` parameter which is the total number of pages.

For example:

```javascript
{ 
  pagination: {
    page: 3,
    pageCount: 10
  }
}
```

Handlebars-paginate let's you define three types of blocks in your
template:

**middle**:

This will iterate over all the possible pages. An optional `limit`
parameter is available if you'd like to limit how many page links to
display. `limit=7` will only display 3 links to the left of the active
page and 3 pages to its right. 

For example:

{% raw %}
```html
{{#paginate pagination type="middle" limit="7"}}
  <li {{#if active}}class="active"{{/if}}><a href="?p={{n}}">{{n}}</a></li>
{{/paginate}}
```

**previous** and **next**:

Finally, previous and next are used to define how you want to display the
"previous" and "next" buttons. 

For example:

```html
{{#paginate pagination type="previous"}}
  <li {{#if disabled}}class="disabled"{{/if}}><a href="?p={{n}}" >Prev</a></li>
{{/paginate}}
```

```html
{{#paginate pagination type="next"}}
  <li {{#if disabled}}class="disabled"{{/if}}><a href="?p={{n}}">Next</a></li>
{{/paginate}}
```
{% endraw %}

Enjoy and feel free to fork or [report issues](https://github.com/olalonde/handlebars-paginate/issues)!
