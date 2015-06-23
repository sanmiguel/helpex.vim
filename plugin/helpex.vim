" A set of Elixir development tools
" Version: 0.2.0
" Author:  sanmiguel <michael.coles@gmail.com>
" License: Apache 2

if exists('g:loaded_helpex')
  finish
endif

" TODO: Start node
" TODO: reconnect socket if necessary
let s:elixir_namespace= '\<[A-Z][[:alnum:]]\+\(\.[A-Z][[:alnum:].]\+\)*.*$'
let s:erlang_module= ':\<'
let s:elixir_fun_w_arity = '.*/[0-9]$'
let s:elixir_module = '[A-Z][[:alnum:]_]\+\([A_Z][[:alnum:]_]+\)*'

" plugin/helpex.vim
" TODO Make env configurable (esp while we're writing tests?)
let s:alchemist = expand("<sfile>:p:h:h") . '/tools/alchemist.exs'
let s:startcmd = 'elixir ' . s:alchemist . ' dev'

let s:process = {}

"function! helpex#setup()
"    call vimproc#system(['mix do deps.get, compile, release'])
"endfunction

function! helpex#start()
    let s:process = vimproc#popen2(s:startcmd)
    return s:process
endfunction

function! helpex#stop()
    call s:process.kill(0)
    let [cond, status] = s:process.waitpid()
    return [cond, status]
endfunction

function! helpex#restart()
    call helpex#stop()
    call helpex#start()
endfunction

function! helpex#status()
    return s:process.checkpid()
endfunction

function! helpex#ensure()
    let [cond, status] = s:process.checkpid()
    if cond == 'run'
        return s:process
    else
        return helpex#start()
    endif
endfunction

function! helpex#debug()
    return s:process
endfunction

function! helpex#flush()
    echo s:process.stdout.read()
endfunction

function! helpex#ping()
    call s:process.stdin.write("PING\n")
    echo s:process.stdout.read()
endfunction

function! helpex#stop()
    call s:process.kill(0)
    return s:process.waitpid()
endfunction

function! helpex#get_suggestions(hint)
    call helpex#ensure()
    call s:process.stdin.write("COMPLETE " . a:hint . "\n")
    let reply = ""
    while reply !~# '.*\nEND-OF-COMPLETE\n'
        let reply .= s:process.stdout.read()
    endwhile
    return s:clean(filter(split(reply, '\n'), 'v:val != "END-OF-COMPLETE"'))
endfunction

function! helpex#get_doc(word)
    call helpex#ensure()
    call s:process.stdin.write("DOC " . a:word . "\n")
    let reply = ""
    while reply !~# '.*\nEND-OF-DOC\n'
        let reply .= s:process.stdout.read()
    endwhile
    return filter(split(reply, '\n'), 'v:val != "END-OF-DOC"')
endfunction

function! helpex#get_doc_suggestions(hint)
    let suggestions = s:build_completions(a:hint)
    return map(suggestions, 'v:val.word')
endfunction

function! s:clean1(suggestion)
    if a:suggestion =~ 'cmp:.*$'
        let [cmp ; str] = split(a:suggestion, ":")
        return join(str, ":")
    endif
endfunction

function! s:clean(suggestions)
    return map(a:suggestions, 's:clean1(v:val)')
endfunction

function! helpex#omnifunc(findstart, base)
    if a:findstart
        return s:findstart()
    else
        return s:build_completions(a:base)
    endif
endfunction

function! s:findstart()
    " return int 0 < n <= col('.')
    let lnum = line('.')
    let column = col('.')
    let line = strpart(getline('.'), 0, column - 1)
    if line =~ s:erlang_module
        return match(line, s:erlang_module)
    elseif line =~ s:elixir_namespace
        return match(line, s:elixir_namespace)
    endif
    return match(line, '\S\+')
endfunction

function! s:build_completions(base)
    let suggestions = helpex#get_suggestions(a:base)
    if len(suggestions) == 0
        return -1
    elseif len(suggestions) == 1
        return { 'words': suggestions, 'refresh': 'always' }
    elseif len(suggestions) > 1
        let [ newbase ; tail ] = suggestions
        if newbase !~ '.*\.$' " non-unique match
            " trim the last part - it'll be in all the subsequent matches
            let newbase = strpart(newbase, 0, match(newbase, '[^.]\+$'))
        endif
        return { 'words': map(tail, 's:parse_suggestion(newbase, v:val)'), 'refresh': 'always'}
    endif
endfunction

function! s:parse_suggestion(base, suggestion)
    "echom "base: " . a:base . " | suggestion:" . a:suggestion
    if a:suggestion =~ s:elixir_fun_w_arity
        let word = strpart(a:suggestion, 0, match(a:suggestion, '/[0-9]\+$'))
        return {'word': a:base . word, 'abbr': a:suggestion, 'kind': 'f' }
    elseif a:suggestion =~ s:elixir_module
        return {'word': a:base.a:suggestion.'.', 'abbr': a:suggestion, 'kind': 'm'}
    elseif a:suggestion =~ s:erlang_module
        return {'word': ':'.a:suggestion, 'abbr': a:suggestion, 'kind': 'm'}
    else
        return {'word': a:suggestion, 'abbr': a:suggestion }
    endif
endfunction

let g:loaded_helpex = 1
