if exists('b:helpex_omnicomplete_loaded')
    finish
endif

call helpex#start()

setlocal omnifunc=helpex#omnifunc

let b:helpex_omnicomplete_loaded = 1
