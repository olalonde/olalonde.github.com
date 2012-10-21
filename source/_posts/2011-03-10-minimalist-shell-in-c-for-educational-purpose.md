---
permalink: /minimalist-shell-in-c-for-educational-purpose/index.html
sharing_link: /minimalist-shell-in-c-for-educational-purpose
layout: post
title: Minimalist shell in C (for educational purposes only!)
published: true
comments: true
categories:
- c/c++
---
<h2>Introduction</h2>

<p>I was kind of bored tonight so I decided to write a very minimalist
shell in C. Here&rsquo;s how it looks:</p>

<div class="CodeRay">
  <div class="code"><pre><span class="comment">/*
 * DISCLAIMER: THIS CODE IS FOR EDUCATIONAL PURPOSES ONLY. USE AT YOUR OWN RISKS.
 *
 * This code shows the basic workings of a shell.
 *
 * Append &quot;/path/to/dashell&quot; to /etc/shells, to make it a valid shell:
 * sudo echo &quot;/path/to/dashell&quot; &gt;&gt; /etc/shells
 *
 * Change your &quot;username&quot;'s shell. &quot;username&quot; should have execute permission for the shell:
 * chsh --shell /path/to/dashell username
 *
 */</span>

<span class="preprocessor">#include</span> <span class="include">&lt;unistd.h&gt;</span>
<span class="preprocessor">#include</span> <span class="include">&lt;string.h&gt;</span>
<span class="preprocessor">#include</span> <span class="include">&lt;stddef.h&gt;</span>
<span class="preprocessor">#include</span> <span class="include">&lt;stdlib.h&gt;</span>
<span class="preprocessor">#include</span> <span class="include">&lt;stdio.h&gt;</span>
<span class="preprocessor">#include</span> <span class="include">&lt;ctype.h&gt;</span>
<span class="preprocessor">#include</span> <span class="include">&lt;sys/signal.h&gt;</span>

<span class="preprocessor">#define</span> STDIN <span class="integer">0</span>
<span class="preprocessor">#define</span> STDOUT <span class="integer">1</span>
<span class="preprocessor">#define</span> STDERR <span class="integer">2</span>

<span class="preprocessor">#define</span> BUFFER_SIZE <span class="integer">1024</span>

<span class="directive">void</span> parse_arguments(<span class="predefined-type">char</span> buffer[], <span class="predefined-type">int</span> *args_count, <span class="predefined-type">char</span> *args[]) {
  <span class="predefined-type">char</span> *delimiters = <span class="string"><span class="delimiter">&quot;</span><span class="content"> </span><span class="char">\r</span><span class="char">\n</span><span class="delimiter">&quot;</span></span>;
  <span class="predefined-type">char</span> *token;
  *args_count = <span class="integer">0</span>;
  <span class="comment">// &quot;abc def ghi&quot; =&gt; {&quot;abc&quot;, &quot;def&quot;, &quot;ghi&quot;}</span>
  <span class="keyword">while</span>(token = strsep(&amp;buffer, delimiters)) {
    args[*args_count] = token;
    (*args_count)++;
  }
}

<span class="predefined-type">int</span> main(<span class="predefined-type">int</span> argc, <span class="directive">const</span> <span class="predefined-type">char</span>* argv[]) {
  <span class="comment">// The weird characters are used to format the text's appearance.</span>
  <span class="comment">// See http://en.wikipedia.org/wiki/ANSI_escape_code</span>
  <span class="predefined-type">char</span> prompt[] = <span class="string"><span class="delimiter">&quot;</span><span class="char">\033</span><span class="content">[1mdashell</span><span class="char">\033</span><span class="content">[2m&gt;</span><span class="char">\033</span><span class="content">[0m </span><span class="delimiter">&quot;</span></span>;
  <span class="predefined-type">char</span> exec_error[] = <span class="string"><span class="delimiter">&quot;</span><span class="content">Cannot execute program %s.</span><span class="char">\n</span><span class="delimiter">&quot;</span></span>;
  <span class="predefined-type">char</span> buffer[BUFFER_SIZE + <span class="integer">1</span>];

  <span class="predefined-type">int</span> args_count;
  <span class="predefined-type">char</span> *args[BUFFER_SIZE];

  <span class="predefined-type">int</span> n;
  <span class="keyword">while</span>(<span class="integer">1</span>) {
    write(STDOUT, prompt, strlen(prompt) + <span class="integer">1</span>);
    n = read(STDIN, buffer, BUFFER_SIZE); <span class="comment">// Read from STDIN (keyboard input)</span>
    buffer[n] = <span class="char">'\0'</span>; <span class="comment">// Null character to indicate string end</span>

    <span class="comment">// &quot;abc def ghi&quot; =&gt; {&quot;abc&quot;, &quot;def&quot;, &quot;ghi&quot;}</span>
    parse_arguments(buffer, &amp;args_count, args);

    <span class="comment">// No arguments</span>
    <span class="keyword">if</span>(args_count == <span class="integer">0</span> || strcmp(args[<span class="integer">0</span>], <span class="string"><span class="delimiter">&quot;</span><span class="delimiter">&quot;</span></span>) == <span class="integer">0</span>) <span class="keyword">continue</span>;

    <span class="comment">// Argument = exit</span>
    <span class="keyword">if</span>(strcmp(args[<span class="integer">0</span>], <span class="string"><span class="delimiter">&quot;</span><span class="content">exit</span><span class="delimiter">&quot;</span></span>) == <span class="integer">0</span>) exit(<span class="integer">0</span>);

    pid_t child_pid = fork(); <span class="comment">// Duplicate process</span>
    <span class="keyword">if</span>(child_pid == <span class="integer">0</span>) {
      <span class="comment">// Child</span>
      <span class="keyword">if</span>(execvp(args[<span class="integer">0</span>], args) &lt; <span class="integer">0</span>) { <span class="comment">// Replace executable code by command passed</span>
        fprintf(stderr, exec_error, args[<span class="integer">0</span>]);
      }
    }
    <span class="keyword">else</span> {
      <span class="comment">// Parent</span>
      <span class="comment">// Wait for child to finish</span>
      wait();
    }
  }
}</pre></div>
</div>


<p>The full source code is freely <a href="https://github.com/olalonde/dashell">available at
Github</a>:</p>

<p><code>git clone git://github.com/olalonde/dashell.git</code></p>

<p>Note that I never code in C so it might not be perfect&hellip; I&rsquo;m looking at you <code>parse_arguments()</code> ;)</p>

<h2>Install &amp; have fun</h2>

<p>The optional steps will let you use the shell as a login shell for a given user.</p>

<ol>
<li><p><code>make</code></p></li>
<li><p>(optional) Append &ldquo;/path/to/dashell&rdquo; to /etc/shells, to make it a
valid shell:</p>

<div class="CodeRay">
  <div class="code"><pre>sudo echo &quot;/path/to/dashell&quot; &gt;&gt; /etc/shells</pre></div>
</div>
</li>
<li><p>(optional) Change &ldquo;username&rdquo;&rsquo;s shell. &ldquo;username&rdquo; should have
execute permission for the shell:</p>

<div class="CodeRay">
  <div class="code"><pre>chsh --shell /path/to/dashell username</pre></div>
</div>
</li>
</ol>


<p>Now, you can launch the shell and start having fun with it and be
reminded how great bash really is!</p>

<div class="CodeRay">
  <div class="code"><pre>./dashell
dashell&gt; ls -al
dashell&gt; ./launchme 1 2 3
....
dashell&gt; exit</pre></div>
</div>


<p>Feel free to ask questions!</p>
