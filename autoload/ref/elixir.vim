" A ref source for elixir.
" Version: 0.0.1
" Author: Michael Coles <michael.coles@gmail.com>
" License: ???

let s:save_cpo = &cpo
set cpo&vim

if !exists('g:ref_elixir_cmd')
    let g:ref_elixir_cmd = executable('iex') ? 'iex' : ''
endif

let s:source = {}

" name					*ref-source-attr-name*
" 			Required.  The name for this source.
let s:source.name = 'elixir'

" get_body({query})			*ref-source-attr-get_body()*
" 			Required.  Return the body of reference by List of
" 			line break delimitation or String.
" 			A dictionary that has the following entries also can
" 			be returned.
" 			body: Required.  The body of reference.
" 			query: Optional.  The normalized {query}.
" 			Throws an exception with an error message if body is
" 			not found.
function! s:source.get_body(query)
    return helpex#get_doc(a:query)
endfunction

" available()				*ref-source-attr-available()*
" 			Optional.  Return true if this source is available.
" 			Always available when this is omitted.

" opened({query})				*ref-source-attr-opened()*
" 			Optional.  When every reference page is opened, this
" 			function is called.  You can edit the |ref-viewer|
" 			buffer in this timing to initialization.

" get_keyword()				*ref-source-attr-get_keyword()*
" 			Optional.  Pick up the keyword from current cursor
" 			position.  If omitted, "expand('<cword>')" is used.
" 			You can move the cursor because cursor position are
" 			restored.
" 			The keyword is treated as {query}.
" 			The list of the form of [{source-name}, {keyword}] can
" 			be returned.  In this case, the keyword is opened by
" 			the specified source.

" complete({query})			*ref-source-attr-complete()*
" 			Optional.  Return the completion list for command-line.
function! s:source.complete(query)
    return helpex#get_doc_suggestions(a:query)
endfunction

" normalize({query})			*ref-source-attr-normalize()*
" 			Optional.  Normalize the {query}.  It is used for
" 			buffer name, and passed to get_body() and opened().

" leave()					*ref-source-attr-leave()*
" 			Optional.  This function is called when move to other
" 			source page.

" cache({name} [, {gather} [, {update}]])	*ref-source-attr-cache()*
" 			Defined by core.  This is a shortcut to |ref#cache()|.

function! ref#elixir#define()
    return copy(s:source)
endfunction

call ref#register_detection('ex', 'elixir')
call ref#register_detection('exs', 'elixir')

let &cpo = s:save_cpo
unlet s:save_cpo
