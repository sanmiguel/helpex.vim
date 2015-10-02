helpex.vim [![Build Status](https://travis-ci.org/sanmiguel/helpex.vim.svg?branch=master)](https://travis-ci.org/sanmiguel/helpex.vim)
==========

Scripts to integrate helpex into vim

Installation
------------

Either with your favourite plugin/addon manager (I use [vim-plug](https://github.com/junegunn/vim-plug)), or manually:

 - `git clone --recursive https://github.com/sanmiguel/helpex.vim /path/to/helpex.vim`
 - Add /path/to/helpex.vim to your `runtimepath` as usual. 

Dependencies
------------

 - elixir > v1.0.4 due to [this commit](https://github.com/elixir-lang/elixir/commit/8e65562808fe80b0c481dbfcf40e66b8c8872c67)
 - [vimproc](https://github.com/Shougo/vimproc.vim)
 - [vim-ref](http://github.com/Thinca/vim-ref)
 - Optional: [AnsiEsc](http://www.drchip.org/astronaut/vim/index.html#ANSIESC)

Usage
-----

  Completion
  -----
  [![asciicast](https://asciinema.org/a/27165.png)](https://asciinema.org/a/27165)

  Documentation
  -----

Issues
------

 - No error checking
 - No options
