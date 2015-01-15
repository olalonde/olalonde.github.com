---
permalink: /trouble-installing-imagemagick-on-os-x-1072/index.html/
sharing_link: /trouble-installing-imagemagick-on-os-x-1072
layout: post
title: Trouble installing ImageMagick on OS X 10.7.2
published: true
comments: true
categories: []
---
<p>I wanted to use the node-imagemagick library but was getting weird error messages coming from the `identify` binary although I had installed ImageMagick through brew (brew install imagemagick).</p>
<script src="https://gist.github.com/3852226.js?file=bug"></script>
<p>I fixed it by grabbing the latest libfreetype from another brew package and linking it to the old library:</p>
<script src="https://gist.github.com/3852226.js?file=fix"></script>
