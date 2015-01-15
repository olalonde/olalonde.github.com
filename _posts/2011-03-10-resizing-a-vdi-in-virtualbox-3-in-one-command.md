---
permalink: /resizing-a-vdi-in-virtualbox-3-in-one-command
sharing_link: /resizing-a-vdi-in-virtualbox-3-in-one-command
layout: post
title: Resizing a VDI in VirtualBox 3 with one command
published: true
comments: true
categories:
- ubuntu
---
<p>Here&rsquo;s a quick way to expand a (VDI) Virtual Disk Image in VirtualBox 3.</p>

<ol>
<li>Create a new VDI with the new size of your choice. (File / Virtual
Media Manager / New&hellip;)</li>
<li><p>Run this command:</p>

<div class="CodeRay">
  <div class="code"><pre>$ VBoxManage clonehd --existing old.vdi new.vdi</pre></div>
</div>


<p> This may take a few minutes.</p></li>
<li><p>Simply replace the attached old.vdi with the new.vdi in your virtual machine&rsquo;s storage settings.</p></li>
<li>You will need to extend your partition from your guest OS. This can be done under Windows 7 from the control panel (Create and format hard disk partitions) and with GParted in Ubuntu and compatible Linux distributions.</li>
</ol>
