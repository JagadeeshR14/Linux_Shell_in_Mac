# Linux_Shell_in_Mac

# Linux-Shell
An implementation of a Linux shell for Mac using the Linux system calls such as fork(), execvp(), wait(), and exit(). The input is tokenized using the flex tool and parsed using the yacc parser.
## Table of Contents
- [Linux-Shell](#linux-shell)
  - [Table of Contents](#table-of-contents)
  - [Features](#features)
  - [How to run](#how-to-run)
  - [Lexical Analysis](#lexical-analysis)
  - [Yacc Parser](#yacc-parser)
  - [Result](#result)

## Features
- The shell supports the following features:
    * Running commands in the foreground and background
    * Redirection of input and output
    * Piping of commands
    * Handling of signals
    * Listing the contents of a directory
    * Changing the current working directory
    * Log file for all commands run in the shell

## How to run
1. Clone the repository
2. install the flex, bison packages, gcc and make
```bash
$ sudo apt-get install flex bison gcc make
```
3. Compile the shell by running the command `make`
```bash
$ make
```
4. Run the shell using the command `./shell`

## Lexical Analysis
- The lexical analysis is done using the flex tool. The flex tool is used to generate a lexical analyzer (scanner) from a regular expression. The regular expression is written in a file with the extension `.l`. The file `shell.l` contains the regular expression for the shell.
- The regular expression is used to generate the file `lex.yy.c` which contains the lexical analyzer. 
- The lexical analyzer is used to tokenize the input from the user. The tokens are then used to parse the input.


## Yacc Parser
- The yacc parser is used to generate a parser from a context-free grammar. The context-free grammar is written in a file with the extension `.y`. The file `shell.y` contains the context-free grammar for the shell. 
- The context-free grammar is used to generate the file `y.tab.c` which contains the parser.
- The parser is used to parse the input from the user and generate a parse tree. The parse tree is then used to execute the commands.

## Result
I've just implemented the output for some commands, You can ckeck it [here](Result) by clicking it.
