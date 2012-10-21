---
permalink: /how-to-write-your-own-native-nodejs-extension/index.html
sharing_link: /how-to-write-your-own-native-nodejs-extension
layout: post
title: How to write your own native Node.js extension
published: true
comments: true
categories:
- c/c++
- javascript
- node.js
---
<h2>Introduction</h2>

<p><em>This is a follow up to <a href="http://syskall.com/how-to-roll-out-your-own-javascript-api-with">How to roll out your own Javascript API with V8</a>. You should still be able to follow if you haven&rsquo;t read it.</em></p>

<p>We will now port the <a href="https://github.com/olalonde/node-notify">code we have written for V8</a> to <a href="http://nodejs.org/">Node.js</a> and package it for <a href="http://npmjs.org/">npm</a>.</p>

<p><img src="http://i.imgur.com/n7ZIw.png" alt="node-notify screenshot" /></p>

<p>The full source code of this tutorial is available <a href="https://github.com/olalonde/node-notify">from github</a>:</p>

<div class="CodeRay">
  <div class="code"><pre>git clone git://github.com/olalonde/node-notify.git</pre></div>
</div>


<p>You can also install it through <code>npm</code>:</p>

<div class="CodeRay">
  <div class="code"><pre>npm install notify</pre></div>
</div>


<p>The code was tested on Ubuntu 10.10 64-bit and Node.js v0.5.0-pre.</p>

<h2>Getting started</h2>

<p>First let’s create a node-notify folder and with the following directory structure.</p>

<div class="CodeRay">
  <div class="code"><pre>.
|-- build/                   # This is where our extension is built. 
|-- demo/
|   `-- demo.js              # This is a demo Node.js script to test our extension.
|-- src/
|   `-- node_gtknotify.cpp   # This is the where we do the mapping from C++ to Javascript.
`-- wscript                  # This is our build configuration used by node-waf</pre></div>
</div>


<p><em>This fine looking tree was generated with the <code>tree</code> utility.</em></p>

<p>Now let&rsquo;s create our test script <code>demo.js</code> and decide upfront what our extension&rsquo;s API should look like:</p>

<div class="CodeRay">
  <div class="code"><pre><span class="comment">// This loads our extension on the notify variable. </span>
<span class="comment">// It will only load a constructor function, notify.notification().</span>
<span class="keyword">var</span> notify = require(<span class="string"><span class="delimiter">&quot;</span><span class="content">../build/default/gtknotify.node</span><span class="delimiter">&quot;</span></span>); <span class="comment">// path to our extension</span>

<span class="keyword">var</span> notification = <span class="keyword">new</span> notify.notification();
notification.title = <span class="string"><span class="delimiter">&quot;</span><span class="content">Notification title</span><span class="delimiter">&quot;</span></span>;
notification.icon = <span class="string"><span class="delimiter">&quot;</span><span class="content">emblem-default</span><span class="delimiter">&quot;</span></span>; <span class="comment">// see /usr/share/icons/gnome/16x16</span>
notification.send(<span class="string"><span class="delimiter">&quot;</span><span class="content">Notification message</span><span class="delimiter">&quot;</span></span>);</pre></div>
</div>


<h2>Writing our Node.js extension</h2>

<h3>The Init method</h3>

<p>In order to create a Node.js extension, we need to write a C++ class that extends <a href="https://github.com/joyent/node/blob/master/src/node_object_wrap.h">node::ObjectWrap</a>. ObjectWrap implements some utility methods that lets us easily interface with Javascript.</p>

<p>Let&rsquo;s write the skeletton for our class:</p>

<div class="CodeRay">
  <div class="code"><pre><span class="preprocessor">#include</span> <span class="include">&lt;v8.h&gt;</span> <span class="comment">// v8 is the Javascript engine used by Node</span>
<span class="preprocessor">#include</span> <span class="include">&lt;node.h&gt;</span>
<span class="comment">// We will need the following libraries for our GTK+ notification </span>
<span class="preprocessor">#include</span> <span class="include">&lt;string&gt;</span>
<span class="preprocessor">#include</span> <span class="include">&lt;gtkmm.h&gt;</span>
<span class="preprocessor">#include</span> <span class="include">&lt;libnotifymm.h&gt;</span>

<span class="directive">using</span> <span class="keyword">namespace</span> v8;

<span class="keyword">class</span> <span class="class">Gtknotify</span> : node::ObjectWrap {
  <span class="directive">private</span>:
  <span class="directive">public</span>:
    Gtknotify() {}
    ~Gtknotify() {}
    <span class="directive">static</span> <span class="directive">void</span> Init(Handle&lt;Object&gt; target) {
      <span class="comment">// This is what Node will call when we load the extension through require(), see boilerplate code below.</span>
    }
};

<span class="comment">/*
 * WARNING: Boilerplate code ahead.
 * 
 * See https://www.cloudkick.com/blog/2010/aug/23/writing-nodejs-native-extensions/ &amp; http://www.freebsd.org/cgi/man.cgi?query=dlsym
 *  
 * Thats it for actual interfacing with v8, finally we need to let Node.js know how to dynamically load our code. 
 * Because a Node.js extension can be loaded at runtime from a shared object, we need a symbol that the dlsym function can find, 
 * so we do the following:  
 */</span>

v8::Persistent&lt;FunctionTemplate&gt; Gtknotify::persistent_function_template;
<span class="directive">extern</span> <span class="string"><span class="delimiter">&quot;</span><span class="content">C</span><span class="delimiter">&quot;</span></span> { <span class="comment">// Cause of name mangling in C++, we use extern C here</span>
  <span class="directive">static</span> <span class="directive">void</span> init(Handle&lt;Object&gt; target) {
    Gtknotify::Init(target);
  }
  <span class="comment">// @see http://github.com/ry/node/blob/v0.2.0/src/node.h#L101</span>
  NODE_MODULE(gtknotify, init);
}</pre></div>
</div>


<p>Now, we&rsquo;ll have to we have to write the following code in our Init() method:</p>

<ol>
<li><p>Declare our constructor function and bind it to our target variable. <code>var n = require("notification");</code> will bind notification() to n: <code>n.notification()</code>.</p>

<div class="CodeRay">
  <div class="code"><pre><span class="comment">// Wrap our C++ New() method so that it's accessible from Javascript</span>
 <span class="comment">// This will be called by the new operator in Javascript, for example: new notification();</span>
 v8::Local&lt;FunctionTemplate&gt; local_function_template = v8::FunctionTemplate::New(New);

 <span class="comment">// Make it persistent and assign it to persistent_function_template which is a static attribute of our class.</span>
 Gtknotify::persistent_function_template = v8::Persistent&lt;FunctionTemplate&gt;::New(local_function_template);

 <span class="comment">// Each JavaScript object keeps a reference to the C++ object for which it is a wrapper with an internal field.</span>
 Gtknotify::persistent_function_template-&gt;InstanceTemplate()-&gt;SetInternalFieldCount(<span class="integer">1</span>); <span class="comment">// 1 since a constructor function only references 1 object</span>
 <span class="comment">// Set a &quot;class&quot; name for objects created with our constructor</span>
 Gtknotify::persistent_function_template-&gt;SetClassName(v8::String::NewSymbol(<span class="string"><span class="delimiter">&quot;</span><span class="content">Notification</span><span class="delimiter">&quot;</span></span>));

 <span class="comment">// Set the &quot;notification&quot; property of our target variable and assign it to our constructor function</span>
 target-&gt;Set(String::NewSymbol(<span class="string"><span class="delimiter">&quot;</span><span class="content">notification</span><span class="delimiter">&quot;</span></span>), Gtknotify::persistent_function_template-&gt;GetFunction());</pre></div>
</div>
</li>
<li><p>Declare our attributes: <code>n.title</code> and <code>n.icon</code>.</p>

<div class="CodeRay">
  <div class="code"><pre><span class="comment">// Set property accessors</span>
 <span class="comment">// SetAccessor arguments: Javascript property name, C++ method that will act as the getter, C++ method that will act as the setter</span>
 Gtknotify::persistent_function_template-&gt;InstanceTemplate()-&gt;SetAccessor(String::New(<span class="string"><span class="delimiter">&quot;</span><span class="content">title</span><span class="delimiter">&quot;</span></span>), GetTitle, SetTitle);
 Gtknotify::persistent_function_template-&gt;InstanceTemplate()-&gt;SetAccessor(String::New(<span class="string"><span class="delimiter">&quot;</span><span class="content">icon</span><span class="delimiter">&quot;</span></span>), GetIcon, SetIcon);
 <span class="comment">// For instance, n.title = &quot;foo&quot; will now call SetTitle(&quot;foo&quot;), n.title will now call GetTitle()</span></pre></div>
</div>
</li>
<li><p>Declare our prototype method: <code>n.send()</code></p>

<div class="CodeRay">
  <div class="code"><pre><span class="comment">// This is a Node macro to help bind C++ methods to Javascript methods (see https://github.com/joyent/node/blob/v0.2.0/src/node.h#L34)</span>
 <span class="comment">// Arguments: our constructor function, Javascript method name, C++ method name</span>
 NODE_SET_PROTOTYPE_METHOD(Gtknotify::persistent_function_template, <span class="string"><span class="delimiter">&quot;</span><span class="content">send</span><span class="delimiter">&quot;</span></span>, Send);</pre></div>
</div>
</li>
</ol>


<p>Our Init() method should now look like this:</p>

<div class="CodeRay">
  <div class="code"><pre><span class="comment">// Our constructor</span>
    <span class="directive">static</span> v8::Persistent&lt;FunctionTemplate&gt; persistent_function_template;

    <span class="directive">static</span> <span class="directive">void</span> Init(Handle&lt;Object&gt; target) {
      v8::HandleScope scope; <span class="comment">// used by v8 for garbage collection</span>

      <span class="comment">// Our constructor</span>
      v8::Local&lt;FunctionTemplate&gt; local_function_template = v8::FunctionTemplate::New(New);
      Gtknotify::persistent_function_template = v8::Persistent&lt;FunctionTemplate&gt;::New(local_function_template);
      Gtknotify::persistent_function_template-&gt;InstanceTemplate()-&gt;SetInternalFieldCount(<span class="integer">1</span>); <span class="comment">// 1 since this is a constructor function</span>
      Gtknotify::persistent_function_template-&gt;SetClassName(v8::String::NewSymbol(<span class="string"><span class="delimiter">&quot;</span><span class="content">Notification</span><span class="delimiter">&quot;</span></span>));

      <span class="comment">// Our getters and setters</span>
      Gtknotify::persistent_function_template-&gt;InstanceTemplate()-&gt;SetAccessor(String::New(<span class="string"><span class="delimiter">&quot;</span><span class="content">title</span><span class="delimiter">&quot;</span></span>), GetTitle, SetTitle);
      Gtknotify::persistent_function_template-&gt;InstanceTemplate()-&gt;SetAccessor(String::New(<span class="string"><span class="delimiter">&quot;</span><span class="content">icon</span><span class="delimiter">&quot;</span></span>), GetIcon, SetIcon);

      <span class="comment">// Our methods</span>
      NODE_SET_PROTOTYPE_METHOD(Gtknotify::persistent_function_template, <span class="string"><span class="delimiter">&quot;</span><span class="content">send</span><span class="delimiter">&quot;</span></span>, Send);

      <span class="comment">// Binding our constructor function to the target variable</span>
      target-&gt;Set(String::NewSymbol(<span class="string"><span class="delimiter">&quot;</span><span class="content">notification</span><span class="delimiter">&quot;</span></span>), Gtknotify::persistent_function_template-&gt;GetFunction());
    }</pre></div>
</div>


<p>All that is left to do is to write the C++ methods that we used in our Init method: <code>New</code>, <code>GetTitle</code>, <code>SetTitle</code>, <code>GetIcon</code>, <code>SetIcon</code>, <code>Send</code></p>

<h3>Our constructor method: New()</h3>

<p>The New() method creates an instance of our class (a Gtknotify object), sets some default values to our properties and returns a Javascript handle to this object. This is the expected behavior when calling a constructor function with the new operator in Javascript.</p>

<div class="CodeRay">
  <div class="code"><pre>std::<span class="predefined-type">string</span> title;
std::<span class="predefined-type">string</span> icon; 

<span class="comment">// new notification()</span>
<span class="directive">static</span> Handle&lt;Value&gt; New(<span class="directive">const</span> Arguments&amp; args) {
  HandleScope scope;
  Gtknotify* gtknotify_instance = <span class="keyword">new</span> Gtknotify();
  <span class="comment">// Set some default values</span>
  gtknotify_instance-&gt;title = <span class="string"><span class="delimiter">&quot;</span><span class="content">Node.js</span><span class="delimiter">&quot;</span></span>;
  gtknotify_instance-&gt;icon = <span class="string"><span class="delimiter">&quot;</span><span class="content">terminal</span><span class="delimiter">&quot;</span></span>;

  <span class="comment">// Wrap our C++ object as a Javascript object</span>
  gtknotify_instance-&gt;Wrap(args.This());

  <span class="keyword">return</span> args.This();
}</pre></div>
</div>


<h3>Our getters and setters: GetTitle(), SetTitle(), GetIcon(), SetIcon()</h3>

<p>The following is pretty much boilerplate code. It boils down to back and forth conversion between C++ values to Javascript (V8) values.</p>

<div class="CodeRay">
  <div class="code"><pre><span class="comment">// this.title</span>
<span class="directive">static</span> v8::Handle&lt;Value&gt; GetTitle(v8::Local&lt;v8::String&gt; property, <span class="directive">const</span> v8::AccessorInfo&amp; info) {
  <span class="comment">// Extract the C++ request object from the JavaScript wrapper.</span>
  Gtknotify* gtknotify_instance = node::ObjectWrap::Unwrap&lt;Gtknotify&gt;(info.Holder());
  <span class="keyword">return</span> v8::String::New(gtknotify_instance-&gt;title.c_str());
}
<span class="comment">// this.title=</span>
<span class="directive">static</span> <span class="directive">void</span> SetTitle(Local&lt;String&gt; property, Local&lt;Value&gt; value, <span class="directive">const</span> AccessorInfo&amp; info) {
  Gtknotify* gtknotify_instance = node::ObjectWrap::Unwrap&lt;Gtknotify&gt;(info.Holder());
  v8::String::Utf8Value v8str(value);
  gtknotify_instance-&gt;title = *v8str;
}
<span class="comment">// this.icon</span>
<span class="directive">static</span> v8::Handle&lt;Value&gt; GetIcon(v8::Local&lt;v8::String&gt; property, <span class="directive">const</span> v8::AccessorInfo&amp; info) {
  <span class="comment">// Extract the C++ request object from the JavaScript wrapper.</span>
  Gtknotify* gtknotify_instance = node::ObjectWrap::Unwrap&lt;Gtknotify&gt;(info.Holder());
  <span class="keyword">return</span> v8::String::New(gtknotify_instance-&gt;icon.c_str());
}
<span class="comment">// this.icon=</span>
<span class="directive">static</span> <span class="directive">void</span> SetIcon(Local&lt;String&gt; property, Local&lt;Value&gt; value, <span class="directive">const</span> AccessorInfo&amp; info) {
  Gtknotify* gtknotify_instance = node::ObjectWrap::Unwrap&lt;Gtknotify&gt;(info.Holder());
  v8::String::Utf8Value v8str(value);
  gtknotify_instance-&gt;icon = *v8str;
}</pre></div>
</div>


<h3>Our prototype method: Send()</h3>

<p>First we have to extract the C++ object <code>this</code> references. We then build our notification using the object&rsquo;s properties (title, icon) and finally display it.</p>

<div class="CodeRay">
  <div class="code"><pre><span class="comment">// this.send()</span>
<span class="directive">static</span> v8::Handle&lt;Value&gt; Send(<span class="directive">const</span> Arguments&amp; args) {
  v8::HandleScope scope;
  <span class="comment">// Extract C++ object reference from &quot;this&quot;</span>
  Gtknotify* gtknotify_instance = node::ObjectWrap::Unwrap&lt;Gtknotify&gt;(args.This());

  <span class="comment">// Convert first argument to V8 String</span>
  v8::String::Utf8Value v8str(args[<span class="integer">0</span>]);

  <span class="comment">// For more info on the Notify library: http://library.gnome.org/devel/libnotify/0.7/NotifyNotification.html </span>
  Notify::init(<span class="string"><span class="delimiter">&quot;</span><span class="content">Basic</span><span class="delimiter">&quot;</span></span>);
  <span class="comment">// Arguments: title, content, icon</span>
  Notify::Notification n(gtknotify_instance-&gt;title.c_str(), *v8str, gtknotify_instance-&gt;icon.c_str()); <span class="comment">// *v8str points to the C string it wraps</span>
  <span class="comment">// Display the notification</span>
  n.show();
  <span class="comment">// Return value</span>
  <span class="keyword">return</span> v8::Boolean::New(<span class="predefined-constant">true</span>);
}</pre></div>
</div>


<h2>Compiling our extension</h2>

<p><code>node-waf</code> is the build tool used to compile Node extensions which is basically a wrapper for <a href="http://code.google.com/p/waf/">waf</a>. The build process can be configured with a file called <code>wscript</code> in our top directory:</p>

<div class="CodeRay">
  <div class="code"><pre><span class="keyword">def</span> <span class="function">set_options</span>(opt):
  opt.tool_options(<span class="string"><span class="delimiter">&quot;</span><span class="content">compiler_cxx</span><span class="delimiter">&quot;</span></span>)

<span class="keyword">def</span> <span class="function">configure</span>(conf):
  conf.check_tool(<span class="string"><span class="delimiter">&quot;</span><span class="content">compiler_cxx</span><span class="delimiter">&quot;</span></span>)
  conf.check_tool(<span class="string"><span class="delimiter">&quot;</span><span class="content">node_addon</span><span class="delimiter">&quot;</span></span>)
  <span class="comment"># This will tell the compiler to link our extension with the gtkmm and libnotifymm libraries.</span>
  conf.check_cfg(package=<span class="string"><span class="delimiter">'</span><span class="content">gtkmm-2.4</span><span class="delimiter">'</span></span>, args=<span class="string"><span class="delimiter">'</span><span class="content">--cflags --libs</span><span class="delimiter">'</span></span>, uselib_store=<span class="string"><span class="delimiter">'</span><span class="content">LIBGTKMM</span><span class="delimiter">'</span></span>)
  conf.check_cfg(package=<span class="string"><span class="delimiter">'</span><span class="content">libnotifymm-1.0</span><span class="delimiter">'</span></span>, args=<span class="string"><span class="delimiter">'</span><span class="content">--cflags --libs</span><span class="delimiter">'</span></span>, uselib_store=<span class="string"><span class="delimiter">'</span><span class="content">LIBNOTIFYMM</span><span class="delimiter">'</span></span>)

<span class="keyword">def</span> <span class="function">build</span>(bld):
  obj = bld.new_task_gen(<span class="string"><span class="delimiter">&quot;</span><span class="content">cxx</span><span class="delimiter">&quot;</span></span>, <span class="string"><span class="delimiter">&quot;</span><span class="content">shlib</span><span class="delimiter">&quot;</span></span>, <span class="string"><span class="delimiter">&quot;</span><span class="content">node_addon</span><span class="delimiter">&quot;</span></span>) 
  obj.cxxflags = [<span class="string"><span class="delimiter">&quot;</span><span class="content">-g</span><span class="delimiter">&quot;</span></span>, <span class="string"><span class="delimiter">&quot;</span><span class="content">-D_FILE_OFFSET_BITS=64</span><span class="delimiter">&quot;</span></span>, <span class="string"><span class="delimiter">&quot;</span><span class="content">-D_LARGEFILE_SOURCE</span><span class="delimiter">&quot;</span></span>, <span class="string"><span class="delimiter">&quot;</span><span class="content">-Wall</span><span class="delimiter">&quot;</span></span>]
  <span class="comment"># This is the name of our extension.</span>
  obj.target = <span class="string"><span class="delimiter">&quot;</span><span class="content">gtknotify</span><span class="delimiter">&quot;</span></span>
  obj.source = <span class="string"><span class="delimiter">&quot;</span><span class="content">src/node_gtknotify.cpp</span><span class="delimiter">&quot;</span></span>
  obj.uselib = [<span class="string"><span class="delimiter">'</span><span class="content">LIBGTKMM</span><span class="delimiter">'</span></span>, <span class="string"><span class="delimiter">'</span><span class="content">LIBNOTIFYMM</span><span class="delimiter">'</span></span>]</pre></div>
</div>


<p>We&rsquo;re now ready to build! In the top directory, run the following command:</p>

<div class="CodeRay">
  <div class="code"><pre>node-waf configure &amp;&amp; node-waf build</pre></div>
</div>


<p>If everything goes right, we should now have our compiled extension in <code>./build/default/gtknotify.node</code>. Let&rsquo;s try it!</p>

<div class="CodeRay">
  <div class="code"><pre>$ node
&gt; var notif = require('./build/default/gtknotify.node');
&gt; n = new notif.notification();
{ icon: 'terminal', title: 'Node.js' }
&gt; n.send(&quot;Hello World!&quot;);
true</pre></div>
</div>


<p>The previous code should display a notification in the top right corner of your screen!</p>

<h2>Packaging for npm</h2>

<p>That&rsquo;s pretty cool, but how about sharing your hard work with the Node community? That&rsquo;s primarily what the Node Package Manager is used for: making it easy to import extensions/modules and distribute them.</p>

<p>Packaging an extension for npm is very straightforward. All you have to do is create a <code>package.json</code> file in your top directory which contains some info about your extension:</p>

<div class="CodeRay">
  <div class="code"><pre>{
  <span class="comment">// Name of your extension (do not include node or js in the name, this is implicit). </span>
  <span class="comment">// This is the name that will be used to import the extension through require().</span>

  <span class="key"><span class="delimiter">&quot;</span><span class="content">name</span><span class="delimiter">&quot;</span></span> : <span class="string"><span class="delimiter">&quot;</span><span class="content">notify</span><span class="delimiter">&quot;</span></span>,

  <span class="comment">// Version should be http://semver.org/ compliant</span>

  <span class="key"><span class="delimiter">&quot;</span><span class="content">version</span><span class="delimiter">&quot;</span></span> : <span class="string"><span class="delimiter">&quot;</span><span class="content">v0.1.0</span><span class="delimiter">&quot;</span></span>

  <span class="comment">// These scripts will be run when calling npm install and npm uninstall.</span>

  , <span class="key"><span class="delimiter">&quot;</span><span class="content">scripts</span><span class="delimiter">&quot;</span></span> : {
      <span class="key"><span class="delimiter">&quot;</span><span class="content">preinstall</span><span class="delimiter">&quot;</span></span> : <span class="string"><span class="delimiter">&quot;</span><span class="content">node-waf configure &amp;&amp; node-waf build</span><span class="delimiter">&quot;</span></span>
      , <span class="key"><span class="delimiter">&quot;</span><span class="content">preuninstall</span><span class="delimiter">&quot;</span></span> : <span class="string"><span class="delimiter">&quot;</span><span class="content">rm -rf build/*</span><span class="delimiter">&quot;</span></span>
    }

  <span class="comment">// This is the relative path to our built extension.</span>

  , <span class="key"><span class="delimiter">&quot;</span><span class="content">main</span><span class="delimiter">&quot;</span></span> : <span class="string"><span class="delimiter">&quot;</span><span class="content">build/default/gtknotify.node</span><span class="delimiter">&quot;</span></span>

  <span class="comment">// The following fields are optional:</span>

  , <span class="key"><span class="delimiter">&quot;</span><span class="content">description</span><span class="delimiter">&quot;</span></span> : <span class="string"><span class="delimiter">&quot;</span><span class="content">Description of the extension....</span><span class="delimiter">&quot;</span></span>
  , <span class="key"><span class="delimiter">&quot;</span><span class="content">homepage</span><span class="delimiter">&quot;</span></span> : <span class="string"><span class="delimiter">&quot;</span><span class="content">https://github.com/olalonde/node-notify</span><span class="delimiter">&quot;</span></span>
  , <span class="key"><span class="delimiter">&quot;</span><span class="content">author</span><span class="delimiter">&quot;</span></span> : { 
      <span class="key"><span class="delimiter">&quot;</span><span class="content">name</span><span class="delimiter">&quot;</span></span> : <span class="string"><span class="delimiter">&quot;</span><span class="content">Olivier Lalonde</span><span class="delimiter">&quot;</span></span>
      , <span class="key"><span class="delimiter">&quot;</span><span class="content">email</span><span class="delimiter">&quot;</span></span> : <span class="string"><span class="delimiter">&quot;</span><span class="content">olalonde@gmail.com</span><span class="delimiter">&quot;</span></span>
      , <span class="key"><span class="delimiter">&quot;</span><span class="content">url</span><span class="delimiter">&quot;</span></span> : <span class="string"><span class="delimiter">&quot;</span><span class="content">http://www.syskall.com/</span><span class="delimiter">&quot;</span></span>
    } 
  , <span class="key"><span class="delimiter">&quot;</span><span class="content">repository</span><span class="delimiter">&quot;</span></span> : { 
      <span class="key"><span class="delimiter">&quot;</span><span class="content">type</span><span class="delimiter">&quot;</span></span> : <span class="string"><span class="delimiter">&quot;</span><span class="content">git</span><span class="delimiter">&quot;</span></span>
      , <span class="key"><span class="delimiter">&quot;</span><span class="content">url</span><span class="delimiter">&quot;</span></span> : <span class="string"><span class="delimiter">&quot;</span><span class="content">https://github.com/olalonde/node-notify.git</span><span class="delimiter">&quot;</span></span>
    }
}</pre></div>
</div>


<p><em>For more details on the package.json format, documentation is available through <code>npm help json</code>. Note that most fields are optional.</em></p>

<p>You can now install your new npm package by running <code>npm install</code> in your top directory. If everything goes right, you should be able to load your extension with a simple <code>var notify = require('your-package-name');</code>. Another useful command is <code>npm link</code> which creates a symlink to your development directory so that any change to your code is reflected instantly &ndash; no need to install/uninstall perpetually.</p>

<p>Assuming you wrote a cool extension, you might want to publish it online in the central npm repository. In order to do that, you first need to create an account:</p>

<div class="CodeRay">
  <div class="code"><pre>$ npm adduser</pre></div>
</div>


<p>Next, go back to the root of your package code and run:</p>

<div class="CodeRay">
  <div class="code"><pre>$ npm publish</pre></div>
</div>


<p>That&rsquo;s it, your package is now available for anyone to install through the <code>npm install your-package-name</code> command.</p>

<h2>Conclusion</h2>

<p>Writing a native Node extension can be cumbersome and verbose at times but it is well worth the hard earned bragging rights!</p>

<p>Thanks for reading. Let me know in the comments if you run into any problem, I’ll be glad to help.</p>

<p><em>If you liked this, maybe you&rsquo;d also like what I <a href="http://twitter.com/o_lalonde">tweet on Twitter</a>! Might even want to <a href="mailto:olalonde@gmail.com">hire me</a>?</em></p>

<h2>References</h2>

<p><a href="http://syskall.com/how-to-roll-out-your-own-javascript-api-with">How to roll out your own Javascript API with V8</a></p>

<p><a href="https://www.cloudkick.com/blog/2010/aug/23/writing-nodejs-native-extensions/">Writing Node.js Native Extensions</a></p>

<p><a href="http://code.google.com/apis/v8/embed.html">V8 JavaScript Engine Embedder&rsquo;s Guid</a>
Part 1 (V8 extension) available here: <a href="http://syskall.com/how-to-roll-out-your-own-javascript-api-with">http://syskall.com/how-to-roll-out-your-own-javascript-api-with</a></p>

<p><a href="http://howtonode.org/introduction-to-npm">Introduction to npm</a></p>

<p><a href="http://nodejs.org/">Node.js</a></p>
