---
layout: post
title:  "Boot2docker: Using nfs instead of vboxsf to mount /Users"
date:   2015-04-14 17:00:00
comments: true
categories: docker devops
---

After trying to run bitcoind in a docker container on boot2docker and
mounting my local ~/.bitcoin directory as a volume I discovered that the
file system VirtualBox uses for mounting directories (vboxsf) doesn't
support some operations that LevelDB needs in order to operate.

Unfortunately, at the time of this writing, boot2docker doesn't have an
official way to switch from VirtualBox shared folders to nfs.

Which prompted me to write this short script that does exactly this:

{% gist olalonde/3f7512c0bd2bc8abb46d %}
