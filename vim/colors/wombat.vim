" Maintainer:	Lars H. Nielsen (dengmao@gmail.com)
" Last Change:	January 22 2007

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "wombat"


" Vim >= 7.0 specific colors
if version >= 700
  hi CursorLine guibg=#2d2d2d
  hi CursorColumn guibg=#2d2d2d
  hi MatchParen guifg=#f6f3e8 guibg=#857b6f gui=bold
  hi Pmenu 		guifg=#f6f3e8 guibg=#444444
  hi PmenuSel 	guifg=#000000 guibg=#cae682
endif

" General colors
"hi Cursor 		guifg=NONE    guibg=#656565 gui=none
hi Cursor 		guifg=NONE    guibg=#ff0000 gui=none
hi Normal 		guifg=#f6f3e8 guibg=#242424 gui=none
hi NonText 		guifg=#808080 guibg=#303030 gui=none
hi LineNr 		guifg=#857b6f guibg=#000000 gui=none
hi StatusLine 	guifg=#f6f3e8 guibg=#444444 gui=italic
hi StatusLineNC guifg=#857b6f guibg=#444444 gui=none
hi VertSplit 	guifg=#444444 guibg=#444444 gui=none
hi Folded 		guibg=#384048 guifg=#a0a8b0 gui=none
"hi Title		guifg=#f6f3e8 guibg=NONE	gui=bold
hi Title		guifg=#f6f3e8 guibg=NONE	gui=none
hi Visual		guifg=#f6f3e8 guibg=#444444 gui=none
hi SpecialKey	guifg=#808080 guibg=#343434 gui=none

" Syntax highlighting
hi Comment 		guifg=#99968b gui=italic
hi Todo 		guifg=#8f8f8f gui=italic
hi Constant 	guifg=#e5786d gui=none
hi String 		guifg=#95e454 gui=italic
hi Identifier 	guifg=#cae682 gui=none
hi Function 	guifg=#cae682 gui=none
"hi Type 		guifg=#cae682 gui=none
hi Type 		guifg=#ebc54a gui=none
hi Statement 	guifg=#8ac6f2 gui=none
hi Keyword		guifg=#8ac6f2 gui=none
hi PreProc 		guifg=#e5786d gui=none
hi Number		guifg=#e5786d gui=none
"hi Special		guifg=#e7f6da gui=none
hi Special		guifg=#00B003 gui=none
hi Operator     guifg=lightgreen guibg=NONE    gui=NONE
hi cDelimiter   guifg=#e08000 guibg=NONE    gui=NONE

hi Search       guibg=orange

" Message displayed in lower left, such as --INSERT--
hi ModeMsg      guifg=cyan guibg=#242424 gui=NONE

hi DiffAdd	    guifg=darkgray guibg=darkred    gui=none
hi DiffChange   guifg=black    guibg=brown      gui=none
hi DiffDelete   guifg=yellow   guibg=darkblue   gui=none
hi DiffText     guifg=blue     guibg=darkyellow gui=none


if exists("g:loaded_ctags_highlighting")
    "hi ctags_d  guifg=#EBC54A gui=none guibg=#242424
    hi ctags_d  guifg=#e5786d gui=none guibg=#242424
endif
