---
permalink: /minimalist-shell-in-c-for-educational-purpose
sharing_link: /minimalist-shell-in-c-for-educational-purpose
layout: post
title: Minimalist shell in C (for educational purposes only!)
published: true
comments: true
categories:
- c/c++
---

## Introduction ##

I was kind of bored tonight so I decided to write a very minimalist
shell in C. Here's how it looks:

```c
/*
 * DISCLAIMER: THIS CODE IS FOR EDUCATIONAL PURPOSES ONLY. USE AT YOUR OWN RISKS.
 *
 * This code shows the basic workings of a shell.
 *
 * Append "/path/to/dashell" to /etc/shells, to make it a valid shell:
 * sudo echo "/path/to/dashell" >> /etc/shells
 *
 * Change your "username"'s shell. "username" should have execute permission for the shell:
 * chsh --shell /path/to/dashell username
 *
 */

#include <unistd.h>
#include <string.h>
#include <stddef.h>
#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>
#include <sys/signal.h>

#define STDIN 0
#define STDOUT 1
#define STDERR 2

#define BUFFER_SIZE 1024

void parse_arguments(char buffer[], int *args_count, char *args[]) {
  char *delimiters = " \r\n";
  char *token;
  *args_count = 0;
  // "abc def ghi" => {"abc", "def", "ghi"}
  while(token = strsep(&buffer, delimiters)) {
    args[*args_count] = token;
    (*args_count)++;
  }
}

int main(int argc, const char* argv[]) {
  // The weird characters are used to format the text's appearance.
  // See http://en.wikipedia.org/wiki/ANSI_escape_code
  char prompt[] = "\033[1mdashell\033[2m>\033[0m ";
  char exec_error[] = "Cannot execute program %s.\n";
  char buffer[BUFFER_SIZE + 1];

  int args_count;
  char *args[BUFFER_SIZE];

  int n;
  while(1) {
    write(STDOUT, prompt, strlen(prompt) + 1);
    n = read(STDIN, buffer, BUFFER_SIZE); // Read from STDIN (keyboard input)
    buffer[n] = '\0'; // Null character to indicate string end

    // "abc def ghi" => {"abc", "def", "ghi"}
    parse_arguments(buffer, &args_count, args);

    // No arguments
    if(args_count == 0 || strcmp(args[0], "") == 0) continue;

    // Argument = exit
    if(strcmp(args[0], "exit") == 0) exit(0);

    pid_t child_pid = fork(); // Duplicate process
    if(child_pid == 0) {
      // Child
      if(execvp(args[0], args) < 0) { // Replace executable code by command passed
        fprintf(stderr, exec_error, args[0]);
      }
    }
    else {
      // Parent
      // Wait for child to finish
      wait();
    }
  }
}
```

The full source code is freely [available at Github](https://github.com/olalonde/dashell):

    git clone git://github.com/olalonde/dashell.git

Note that I never code in C so it might not be perfect... I'm looking at you `parse_arguments()` ;)

## Install & have fun ##

The optional steps will let you use the shell as a login shell for a given user.

1. `make`

2. (optional) Append "/path/to/dashell" to /etc/shells, to make it a
valid shell:

```bash
sudo echo "/path/to/dashell" >> /etc/shells
```

3. (optional) Change "username"'s shell. "username" should have
execute permission for the shell:

```bash
chsh --shell /path/to/dashell username
```

Now, you can launch the shell and start having fun with it and be
reminded how great bash really is!

```bash
./dashell
dashell> ls -al
dashell> ./launchme 1 2 3
....
dashell> exit
```

Feel free to ask questions!
