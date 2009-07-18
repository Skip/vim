" Подсветка строки, в которой находится в данный момент курсор
set cursorline

" show always tab line
set showtabline=2

" высота statusline 1 строка
set ch=1                

set background=light

colorscheme pyte

" from book "Hacking VIM"
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
        set guifont=Consolas\ 10,DejaVu\ Sans\ Mono\ 9,Terminus\ 10
    elseif has("win16") || has("win32") || has("win64") || has("win95")

    endif
    au VimEnter * windo set foldcolumn=0
    au VimEnter * windo syntax off
    au VimEnter * windo set diffopt=filler,context:8
else
    " Устанавливает используемый X11 шрифт
    " используются по очереди только в случае отсутствия первых
    if has("unix")
        set guifont=Consolas\ 11,Terminus\ bold\ 14,DejaVu\ Sans\ Mono\ 13
    elseif has("win16") || has("win32") || has("win64") || has("win95")

    endif
endif

