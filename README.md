helpex.vim [![Build Status](https://travis-ci.org/sanmiguel/helpex.vim.svg?branch=master)](https://travis-ci.org/sanmiguel/helpex.vim)
==========

Scripts to integrate the excellent [alchemist-server] into vim.
Currently supported features are:

 - code-completion
 - integrated docs (via [vim-ref])

Installation
------------

Either with your favourite plugin/addon manager (I use [vim-plug]), or manually:

 - `git clone --recursive https://github.com/sanmiguel/helpex.vim /path/to/helpex.vim`
   - Note that [alchemist-server] is included as a git submodule, so you must use recursive clone.
 - Add `/path/to/helpex.vim` to your `runtimepath` as usual. 

Dependencies
------------

 - elixir > v1.0.4 due to [this commit](https://github.com/elixir-lang/elixir/commit/8e65562808fe80b0c481dbfcf40e66b8c8872c67)
 - [vimproc] NB: vimproc has a manual post-install step to build it - some plugin managers seem to deal with this OK, some do not - check the vimproc README for details of what to do
 - [vim-ref]
 - Optional: [AnsiEsc]

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


Troubleshooting
--------------

To check if helpex has even managed to start alchemist.exs, try:

`:echo helpex#status()`

If it's running, it should print `['run', 0]`. If there's been a problem it'll print `['exit', 1]`. If it prints nothing something might be chomping the output. In which case, try `:echom string(helpex#status()) | messages`.

If it's not running, most likely there's a problem either with `vimproc` (post-install build step required), or there's a problem with how erlang and elixir are available in vim's env. Check e.g. `:!elixir --version` to verify.

If it is running, and still doesn't work please contact me (@sanmiguel on elixir slack, gen_ale_drinker in #elixir-lang on freenode), or raise an issue here on github!


[alchemist-server]: https://github.com/tonini/alchemist-server
[vim-ref]: https://github.com/Thinca/vim-ref
[vimproc]: https://github.com/Shougo/vimproc.vim
[AnsiEsc]: http://www.drchip.org/astronaut/vim/index.html#ANSIESC
[vim-plug]: https://github.com/junegunn/vim-plug
