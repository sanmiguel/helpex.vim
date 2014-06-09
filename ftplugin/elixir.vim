if exists('b:helpex_omnicomplete_loaded')
    finish
else
    let b:erlang_compiler_loaded = 1
endif

setlocal omnifunc=helpex#omnifunc

