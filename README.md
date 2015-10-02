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

  Completion via omni-complete: `<C-x><C-o>`

  [![asciicast](https://asciinema.org/a/27165.png)](https://asciinema.org/a/27165)

  -----

  Documentation, via `:Ref elixir ...`

  [![asciicast](https://asciinema.org/a/27166.png)](https://asciinema.org/a/27166)

  NB: There is currently a problem the way ref changes the content of the buffer if you try to open a subsequent ref page from within the ref buffer. Simple workaround (for now) is to close the ref buffer between `:Ref` invocations.

  -----

Issues
------

 - No error checking
 - No options
