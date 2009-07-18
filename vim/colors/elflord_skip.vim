" local syntax file - set colors on a per-machine basis:
" vim: tw=0 ts=4 sw=4
" Vim color file
" Maintainer:	Ron Aaron <ron@ronware.org>
" Last Change:	2003 May 02

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "elflord_skip"
hi Normal                               ctermfg=gray        ctermbg=black           guifg=gray        guibg=black
hi Comment    term=bold	        ctermfg=DarkCyan    ctermbg=black           guifg=DarkCyan    guibg=black
hi Constant   term=underline	        ctermfg=Magenta     ctermbg=black           guifg=Magenta     guibg=black
hi Special    term=bold		        ctermfg=DarkMagenta ctermbg=black           guifg=DarkMagenta guibg=black
hi Identifier term=underline cterm=bold ctermfg=Cyan        ctermbg=black           guifg=Cyan        guibg=black
hi Statement  term=bold		        ctermfg=yellow      ctermbg=black  gui=bold guifg=yellow      guibg=black
hi PreProc    term=underline	        ctermfg=Blue	    ctermbg=black           guifg=Blue        guibg=black
hi Type	      term=underline		ctermfg=Green       ctermbg=black  gui=bold guifg=Green       guibg=black
hi Function   term=bold		        ctermfg=White       ctermbg=black           guifg=White       guibg=black
hi Repeat     term=underline	        ctermfg=White	    ctermbg=black           guifg=white       guibg=black
hi Operator			        ctermfg=Red	    ctermbg=black           guifg=Red         guibg=black
hi Ignore			        ctermfg=white	    ctermbg=black           guifg=white       guibg=black
hi Error      term=reverse              ctermfg=White       ctermbg=Red             guifg=White       guibg=Red          
hi Todo	      term=standout             ctermfg=black       ctermbg=yellow          guifg=black       guibg=yellow       
hi LineNr     guifg=#3D3D3D     guibg=black       gui=NONE      ctermfg=darkgray    ctermbg=NONE        cterm=NONE
"highlight Visual term=reverse  cterm=reverse  gui=reverse
highlight Visual                        ctermfg=blue       ctermbg=yellow           guifg=blue        guibg=yellow

" Common groups that link to default highlighting.
" You can specify other highlighting easily.
hi link IncSearch       Visual
hi link String	        Constant
hi link Character	Constant
hi link Number	        Constant
hi link Boolean	        Constant
hi link Float		Number
hi link Conditional	Repeat
hi link Label		Statement
hi link Keyword	        Statement
hi link Exception	Statement
hi link Include	        PreProc
hi link Define	        PreProc
hi link Macro		PreProc
hi link PreCondit	PreProc
hi link StorageClass	Type
hi link Structure	Type
hi link Typedef	        Type
hi link Tag		Special
hi link SpecialChar	Special
hi link Delimiter	Special
hi link SpecialComment  Special
hi link Debug		Special
