" A ref source for Elixir
" Version: 0.0.1
" Author:  sanmiguel <michael.coles@gmail.com>
" With inspiration from:
" Author : thinca <thinca+vim@gmail.com>
" License: Creative Commons Attribution 2.1 Japan License
"          <http://creativecommons.org/licenses/by/2.1/jp/deed.en>

let s:save_cpo = &cpo
set cpo&vim

" config. {{{1
if !exists('g:ref_elixir_cmd')  " {{{2
  let g:ref_elixir_cmd = executable('helpex') ? 'helpex' : ''
endif

let s:source = ref#man#define()  " {{{1

let s:source.name = 'elixir'

unlet s:source.opened
unlet s:source.complete
unlet s:source.get_keyword

function! s:source.get_body(query)
    let query = a:query
    let body = ref#system(ref#to_list(g:ref_elixir_cmd, 'man', query)).stdout
    return {'body': body, 'query': query}
endfunction

function! s:source.option(opt)
  if a:opt ==# 'cmd'
    return ref#to_list(g:ref_elixir_cmd, 'man')
  endif
  return ''
endfunction

function! s:source.get_keyword()
  return ref#get_text_on_cursor('[[:alnum:]]\+\(\.[[:alnum:]]\+\)*')
endfunction

function! ref#elixir#define()
  return copy(s:source)
endfunction

call ref#register_detection('elixir', 'elixir')

let &cpo = s:save_cpo
unlet s:save_cpo
