---
permalink: /how-to-roll-out-your-own-javascript-api-with/index.html
sharing_link: /how-to-roll-out-your-own-javascript-api-with
layout: post
title: How to roll out your own Javascript API with V8
published: true
comments: true
categories:
- c/c++
- javascript
---
<p><em>Update: I wrote a new tutorial on porting our V8 code as a Node.js extension: <a href="http://syskall.com/how-to-write-your-own-native-nodejs-extension">How to write your own native Node.js extension</a>.</em></p>

<h2>Introduction</h2>

<p>This tutorial will teach you how to:</p>

<ol>
<li>Compile the V8 Javascript engine</li>
<li>Bind a Javascript function to your own C++ function</li>
</ol>


<p>For the sake of demonstration and to impress your co-workers, we will bind a Javascript function &ldquo;alert()“ that will display desktop notifications through the GTK library. Here’s what the end result looks like:</p>

<p><img src="http://posterous.com/getfile/files.posterous.com/olalonde/RiXGvyU85iXwA2KcuikQnfi8WMMVf5XfkloWrz9RtzFdiiZn3gGBAJejdnyJ/jsnotify.png" alt="jsnotify screenshot" /></p>

<p>You can get the full source code of this tutorial <a href="https://github.com/olalonde/jsnotify">from github</a>:</p>

<div class="CodeRay">
  <div class="code"><pre>git clone git://github.com/olalonde/jsnotify.git</pre></div>
</div>


<p>This tutorial was tested on Ubuntu 10.04 and 10.10 64-bit but should work fine on any Linux distribution. The notification part requires the GTK+ library.</p>

<h2>Compiling Google’s V8 Javascript engine</h2>

<p>First, let’s make sure we have all the <a href="http://code.google.com/apis/v8/build.html">required tools and dependencies</a> to compile.</p>

<div class="CodeRay">
  <div class="code"><pre>sudo apt-get install build-essential scons subversion</pre></div>
</div>


<ul>
<li>The build-essential package is a meta package that installs all the necessary tools and libraries to compile C++ programs.</li>
<li>SCons is a build tool which attempts to replace the classic “make” and is used by the V8 project.</li>
<li>Subversion is needed to checkout the source code of V8.</li>
</ul>


<p>Now, let’s grab V8’s source from the <a href="http://code.google.com/p/v8/wiki/Source?tm=4">official repository</a>:</p>

<div class="CodeRay">
  <div class="code"><pre>svn checkout http://v8.googlecode.com/svn/trunk/ v8</pre></div>
</div>


<p>We can now move into the V8 directory and try to compile!</p>

<div class="CodeRay">
  <div class="code"><pre>cd v8;
scons arch=x64;</pre></div>
</div>


<p>The “arch=x64” option specifies that we want to build a 64-bit version of V8 (the default value would be 32-bit otherwise).</p>

<p>If V8 compiled fine, you should now have a libv8.a file in your v8/ directory. As you probably guessed, libv8.a is the library that our C++ program will use to execute Javascript code.</p>

<p>So, if everything compiled fine, just skip to the next section. Otherwise, keep on reading.</p>

<p>When you get errors as a result of compiling third party code, it is usually due to the fact that the compiler can’t find required libraries (/usr/lib) and/or their associated header files (/usr/lib/include). The latter are usually available through packages conventionally named <em>libname</em>-dev . In order to find out which package installs a given file, there is a neat utility called <code>apt-file</code>.</p>

<div class="CodeRay">
  <div class="code"><pre>sudo apt-get install apt-file;
apt-file search missing-header-file.h;</pre></div>
</div>


<p>The <code>apt-file search</code> command lists the package(s) that install a given file (<em>missing-header-file.h</em> in this case). If there are more than one package listed, we have to take a semi-educated guess on which package we should install based on its name (let me know in the comments if you know of a better trick!). We then simply install the package with the usual <code>apt-get install package-name</code> command.</p>

<p>Hint: If you are on Ubuntu 10.04, you might need to install the following packages:</p>

<div class="CodeRay">
  <div class="code"><pre>sudo apt-get install libc6-dev-i368 lib32stdc++6</pre></div>
</div>


<p>Now that we’ve installed all the missing files, the compilation should work. Let&rsquo;s move on to the next section.</p>

<p>If you are still stuck with compiling V8, <a href="http://www.travisswicegood.com/2009/07/11/compiling-node-js-olibc6-dev-i368n-ubuntu-9-04/">this tutorial</a> might help.</p>

<h2>Building our own Javascript API</h2>

<p>Now that we have successfully compiled the V8 library, we will build our own C++ project that will be “Javascript scriptable”. This means that our program will be able to run Javascript code which in turn will be able to call our custom C++ functions.</p>

<p><em>Note:</em> You can also get the full source code of this tutorial from my <a>jsnotify github repository</a>): <code>git clone git://github.com/olalonde/jsnotify.git</code></p>

<p>First let’s create our file structure.</p>

<div class="CodeRay">
  <div class="code"><pre>jsnotify/
  |-- deps/  # third party code
  |   `-- v8  # move your v8 folder here
  `-- src/ # our code goes here
      `-- jsnotify.cpp</pre></div>
</div>


<p>Now let’s copy the sample code available at <code>deps/v8/samples/shell.cc</code> and paste it into jsnotify.cpp. The sample code given by V8 let’s you execute a Javascript file or start an interactive Javascript shell. It also binds some useful Javascript functions such as print() which will output text to the terminal.</p>

<p>Let’s try to compile this!</p>

<div class="CodeRay">
  <div class="code"><pre>g++ src/jsnotify.cpp;</pre></div>
</div>


<p>Of course, this gives us a bunch of errors since we haven’t specified where the V8 header and library files are. Let’s try again!</p>

<div class="CodeRay">
  <div class="code"><pre>g++ src/jsnotify.cpp -Ideps/v8/include -Ldeps/v8/ -lv8</pre></div>
</div>


<p>Oops, still some errors. Looks like we also have to link the pthread library.</p>

<div class="CodeRay">
  <div class="code"><pre>g++ src/jsnotify.cpp -Ideps/v8/include -Ldeps/v8/ -lv8 -lpthread</pre></div>
</div>


<p>This finally compiles! Now that we have our mini Javascript shell, let’s play a bit with it.</p>

<div class="CodeRay">
  <div class="code"><pre>$ ./a.out 
V8 version 3.1.5
&gt; var foo = “Hello World”;
&gt; print(foo);
Hello World</pre></div>
</div>


<p>Now, all we have to do is to create our custom alert() function in C++.</p>

<div class="CodeRay">
  <div class="code"><pre><span class="comment">// INSERT THIS BEFORE int RunMain(int argc, char* argv[]) {</span>
<span class="comment">// We need those two libraries for the GTK+ notification </span>
<span class="preprocessor">#include</span> 
<span class="preprocessor">#include</span> 
v8::Handle Alert(<span class="directive">const</span> v8::Arguments&amp; args);

<span class="comment">// INSERT THIS AT END OF FILE   </span>
<span class="comment">// The callback that is invoked by v8 whenever the JavaScript 'alert'</span>
<span class="comment">// function is called.  Displays a GTK+ notification.</span>
v8::Handle Alert(<span class="directive">const</span> v8::Arguments&amp; args) {
  v8::String::Utf8Value str(args[<span class="integer">0</span>]); <span class="comment">// Convert first argument to V8 String</span>
  <span class="directive">const</span> <span class="predefined-type">char</span>* cstr = ToCString(str); <span class="comment">// Convert V8 String to C string</span>

  Notify::init(<span class="string"><span class="delimiter">&quot;</span><span class="content">Basic</span><span class="delimiter">&quot;</span></span>);
  <span class="comment">// Arguments: title, content, icon</span>
  Notify::Notification n(<span class="string"><span class="delimiter">&quot;</span><span class="content">Alert</span><span class="delimiter">&quot;</span></span>, cstr, <span class="string"><span class="delimiter">&quot;</span><span class="content">terminal</span><span class="delimiter">&quot;</span></span>);
  <span class="comment">// Display notification</span>
  n.show();

  <span class="keyword">return</span> v8::Undefined();
}</pre></div>
</div>


<p>Now that we have our Alert C++ function, we need to tell V8 to bind it to the Javascript alert() function. This is done by adding the following code in the RunMain function:</p>

<div class="CodeRay">
  <div class="code"><pre><span class="comment">// INSERT AFTER v8::Handle global = v8::ObjectTemplate::New();</span>
<span class="comment">// Bind the global 'alert' function to the C++ Alert callback.</span>
global-&gt;Set(v8::String::New(<span class="string"><span class="delimiter">&quot;</span><span class="content">alert</span><span class="delimiter">&quot;</span></span>), v8::FunctionTemplate::New(Alert));</pre></div>
</div>


<p>Now, in order to compile, the compiler needs to know where to find the two header files we introduced. This is done using the pkg-config utility:</p>

<div class="CodeRay">
  <div class="code"><pre>g++ src/jsnotify.cpp -Ideps/v8/include -Ldeps/v8/ -lv8 -lpthread pkg-config --cflags --libs gtkmm-2.4 libnotifymm-1.0</pre></div>
</div>


<p>We can now try our new alert function.</p>

<div class="CodeRay">
  <div class="code"><pre>$./a.out 
V8 version 3.1.5
&gt; alert(“wow, it works!”);</pre></div>
</div>


<p>You should see a nice notification in the top right of your screen! Note that you can also put you Javascript code in a file and pass the file name as an argument <code>./a.out filename.js</code>.</p>

<h2>Conclusion</h2>

<p>It&rsquo;s quite easy to make a C++ program &ldquo;Javascriptable&rdquo; with V8 and the proper setup. If you&rsquo;d like to practice your newfound skills, I suggest you try to add a title argument to the alert function. You might also want to follow me on Posterous in order to be informed when I post the follow up to this tutorial on how to extend <a href="http://nodejs.org/">Node.js</a> with our alert function.</p>

<p>That’s all for today, thanks for reading! Let me know in the comments if you run into any problem, I’ll be glad to help.</p>

<p><em>If you liked this, maybe you&rsquo;d also like what I <a href="http://twitter.com/o_lalonde">tweet on Twitter</a>!</em></p>
