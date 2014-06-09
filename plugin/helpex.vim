" A set of Elixir development tools
" Version: 0.0.1
" Author:  sanmiguel <michael.coles@gmail.com>
" License: Apache 2

if exists('g:loaded_helpex')
  finish
endif

" TODO: Start node
" TODO: reconnect socket if necessary

let s:sock = vimproc#socket_open('localhost', 9999)

function! helpex#complete(hint)
    call s:sock.write("complete:" . a:hint . "\n")
    let reply = ""
    while reply !~# '.*\nEOF\n'
        let reply .= s:sock.read()
    endwhile
    let ret = split(reply, '\n')
    return filter(ret, 'v:val != "EOF"')
endfunction

let g:loaded_helpex = 1
