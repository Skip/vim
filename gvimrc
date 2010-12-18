" Подсветка строки, в которой находится в данный момент курсор
set cursorline

" show always tab line
set showtabline=2

" высота statusline 1 строка
set ch=1

if (hostname() == "skip.nkbvs.tsure.ru")
    " my work computer
    set background=dark
    colorscheme ir_black
elseif (hostname() == "skip-note")
    " my home computer
    set background=dark
    colorscheme ir_black_note
else
    " some another computer
    set background=dark
    colorscheme ir_black
endif

set winaltkeys=no

" toggle menu and toolbar
map <silent> <C-F2> :if &guioptions =~# 'T' <Bar>
                         \set guioptions-=T <Bar>
                         \set guioptions-=m <Bar>
                    \else <Bar>
                         \set guioptions+=T <Bar>
                         \set guioptions+=m <Bar>
                         \set toolbariconsize=tiny <Bar>
                    \endif<CR>

set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=b
set guioptions-=m
set guioptions-=t
set guioptions-=T


" прячем курсор во время набота текста
set mousehide

" Выключаем надоедливый "звонок"
set noerrorbells
set visualbell
set vb t_vb=

if &diff
    if has("unix")
        if (hostname() == "skip.nkbvs.tsure.ru")
            " my work computer
            set guifont=Consolas\ 11,DejaVu\ Sans\ Mono\ 9,Terminus\ 10
        elseif (hostname() == "skip-note")
            " my home computer
            set guifont=DejaVu\ Sans\ Mono\ 10,Terminus\ 10,Consolas\ 10
        else
            set guifont=DejaVu\ Sans\ Mono\ 10
        endif
    elseif has("win16") || has("win32") || has("win64") || has("win95")

    endif
else
    " Устанавливает используемый X11 шрифт
    " используются по очереди только в случае отсутствия первых
    if has("unix")
        if (hostname() == "skip.nkbvs.tsure.ru")
            set guifont=Consolas\ bold\ 13,Terminus\ bold\ 14,DejaVu\ Sans\ Mono\ 13
        elseif (hostname() == "skip-note")
            set guifont=DejaVu\ Sans\ Mono\ 11
        else
            set guifont=DejaVu\ Sans\ Mono\ 10
        endif
    elseif has("win16") || has("win32") || has("win64") || has("win95")

    endif
endif

