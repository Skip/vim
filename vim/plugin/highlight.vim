if exists("g:loaded_highlight_plugin")
    finish
endif
let g:loaded_highlight_plugin = 1

if has("syntax")

    " вкл/выкл подсвечивание всех символов свыше 80
    function! Highlight_80_symbol_toggle()
        if exists("g:show_80")
            unlet g:show_80
            match NONE '\%>80v.\+'
            echo "highlight 80 symbol off"
        else
            let g:show_80 = 1
            match ErrorMsg '\%>80v.\+'
            echo "highlight 80 symbol on"
        endif
    endfunction

    nmap <C-s>d :call Highlight_80_symbol_toggle()<cr>

    function! Highlight_cursor_line_toggle()
        if !exists("s:highlight_cursor")
            match Todo /^.*\%#.*$/
            let s:highlight_cursor = 1
        else
            match None
            unlet s:highlight_cursor
        endif
    endfunction

    map <C-f> <esc>:call Highlight_cursor_line_toggle()<cr>
endif " has("syntax")

