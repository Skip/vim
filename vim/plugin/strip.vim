if exists("g:loaded_strip_plugin")
    finish
endif
let g:loaded_strip_plugin = 1

function! StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

nnoremap <silent> <S-F7> :call StripTrailingWhitespaces()<CR>
inoremap <silent> <S-F7> <esc>:call StripTrailingWhitespaces()<CR>a

