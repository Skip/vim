
set background=dark

hi clear

if exists("syntax_on")
    syntax reset
endif

let colors_name = "ir_black_note"

" normal text
hi Normal           guifg=gray        guibg=black       gui=NONE      ctermfg=NONE        ctermbg=NONE        cterm=NONE

" '~' and '@' at the end of the window, characters from
" 'showbreak' and other characters that do not really exist in
" the text (e.g., ">" displayed when a double-wide character
" doesn't fit at the end of the line).
hi NonText          guifg=brown       guibg=NONE        gui=NONE      ctermfg=brown       ctermbg=NONE        cterm=NONE

" the character under the cursor
hi Cursor           guifg=white       guibg=#ff0000     gui=NONE      ctermfg=black       ctermbg=white       cterm=NONE

" Line number for ":number" and ":#" commands, and when 'number'
" or 'relativenumber' option is set.
hi LineNr           guifg=#707070     guibg=NONE        gui=NONE      ctermfg=darkgray    ctermbg=NONE        cterm=NONE

" the column separating vertically split windows
hi VertSplit        guifg=#202020     guibg=#202020     gui=NONE      ctermfg=darkgray    ctermbg=darkgray    cterm=NONE

" status line of current window
hi StatusLine       guifg=#DBDBDB     guibg=#3D3D3D     gui=italic    ctermfg=white       ctermbg=darkgray    cterm=NONE

" status lines of not-current windows
hi StatusLineNC     guifg=#989898     guibg=#3D3D3D     gui=NONE      ctermfg=gray        ctermbg=darkgray    cterm=NONE

" line used for closed folds
hi Folded           guifg=#a0a8b0     guibg=#384048     gui=NONE      ctermfg=NONE        ctermbg=NONE        cterm=NONE

" titles for output from ":set all", ":autocmd" etc.
hi Title            guifg=#f6f3e8     guibg=NONE        gui=NONE      ctermfg=NONE        ctermbg=NONE        cterm=NONE

" Visual mode selection
hi Visual           guifg=NONE        guibg=#262D20     gui=NONE      ctermfg=lightgray   ctermbg=darkgray    cterm=NONE

" Meta and special keys listed with ":map", also for text used
" to show unprintable characters in the text, 'listchars'.
" Generally: text that is displayed differently from what it really is.
hi SpecialKey       guifg=brown       guibg=NONE        gui=NONE      ctermfg=brown       ctermbg=NONE        cterm=NONE

" current match in 'wildmenu' completion
hi WildMenu         guifg=black       guibg=yellow      gui=NONE      ctermfg=black       ctermbg=yellow      cterm=NONE

" error messages on the command line
hi ErrorMsg         guifg=white       guibg=#FF6C60     gui=NONE      ctermfg=white       ctermbg=red         cterm=NONE

" warning messages
hi WarningMsg       guifg=white       guibg=#FF6C60     gui=NONE      ctermfg=white       ctermbg=red         cterm=NONE

" 'showmode' message (e.g., "-- INSERT --")
hi ModeMsg          guifg=cyan        guibg=NONE        gui=NONE      ctermfg=cyan        ctermbg=black       cterm=NONE

if version >= 700 " Vim 7.x specific colors
    " the screen line that the cursor is in when 'cursorline' is set
    hi CursorLine    guifg=NONE        guibg=#101010     gui=NONE      ctermfg=yellow      ctermbg=blue        cterm=NONE

    " the screen column that the cursor is in when 'cursorcolumn' is set
    hi CursorColumn  guifg=NONE        guibg=#121212     gui=NONE      ctermfg=NONE        ctermbg=NONE        cterm=NONE

    " The character under the cursor or just before it, if it is a paired bracket, and its match.
    hi MatchParen    guifg=#f6f3e8     guibg=#857b6f     gui=NONE      ctermfg=white       ctermbg=darkgray    cterm=NONE

    " Popup menu: normal item.
    hi Pmenu         guifg=#f6f3e8     guibg=#444444     gui=NONE      ctermfg=gray        ctermbg=black       cterm=NONE

    " Popup menu: selected item.
    hi PmenuSel      guifg=#000000     guibg=#cae682     gui=NONE      ctermfg=white       ctermbg=black       cterm=NONE

    " Popup menu: scrollbar.
    hi PmenuSbar     guifg=black       guibg=white       gui=NONE      ctermfg=black       ctermbg=white       cterm=NONE

    " Word that is not recognized by the spellchecker.
    hi SpellBad      guifg=NONE        guibg=NONE        gui=undercurl ctermfg=black       ctermbg=red         cterm=NONE
endif

if version >= 703
    " used for the columns set with 'colorcolumn'
    hi ColorColumn   guifg=NONE        guibg=#101010     gui=NONE      ctermfg=NONE        ctermbg=brown       cterm=NONE
endif

" any comment
hi Comment          guifg=#7C7C7C     guibg=NONE        gui=NONE      ctermfg=darkgray    ctermbg=NONE        cterm=NONE

" a string constant: "this is a string"
hi String           guifg=#A8FF60     guibg=NONE        gui=NONE      ctermfg=green       ctermbg=NONE        cterm=NONE

" a number constant: 234, 0xff
hi Number           guifg=#f570ff     guibg=NONE        gui=NONE      ctermfg=magenta     ctermbg=NONE        cterm=NONE

" any other keyword
hi Keyword          guifg=blue        guibg=NONE        gui=NONE      ctermfg=blue        ctermbg=NONE        cterm=NONE

" generic Preprocessor
hi PreProc          guifg=#5050FF     guibg=NONE        gui=NONE      ctermfg=blue        ctermbg=NONE        cterm=NONE

" if, then, else, endif, switch, etc.
hi Conditional      guifg=#6699CC     guibg=NONE        gui=NONE      ctermfg=darkcyan    ctermbg=NONE        cterm=NONE

" anything that needs extra attention; mostly the keywords TODO FIXME and XXX
hi Todo             guifg=white       guibg=red         gui=NONE      ctermfg=white       ctermbg=red         cterm=NONE

" any constant
hi Constant         guifg=cyan        guibg=NONE        gui=NONE      ctermfg=cyan        ctermbg=NONE        cterm=NONE

" any variable name
hi Identifier       guifg=#13B81E     guibg=NONE        gui=NONE      ctermfg=darkgreen   ctermbg=NONE        cterm=NONE

" function name (also: methods for classes)
hi Function         guifg=#00b000     guibg=NONE        gui=NONE      ctermfg=darkgreen   ctermbg=NONE        cterm=NONE

" int, long, char, etc.
hi Type             guifg=yellow      guibg=NONE        gui=NONE      ctermfg=yellow      ctermbg=NONE        cterm=NONE

" any statement
hi Statement        guifg=#6699CC     guibg=NONE        gui=NONE      ctermfg=darkcyan    ctermbg=NONE        cterm=NONE

" case, default, etc.
hi Label            guifg=#FF7070     guibg=NONE        gui=NONE      ctermfg=red         ctermbg=NONE        cterm=NONE

" any special symbol
hi Special          guifg=cyan        guibg=NONE        gui=NONE      ctermfg=cyan        ctermbg=NONE        cterm=NONE

" character that needs attention
hi Delimiter        guifg=#00FFFF     guibg=NONE        gui=NONE      ctermfg=lightblue   ctermbg=NONE        cterm=NONE

" character that needs attention from C-language
hi cDelimiter       guifg=#00FFFF     guibg=NONE        gui=NONE      ctermfg=lightblue   ctermbg=NONE        cterm=NONE

" "sizeof", "+", "*", etc.
hi Operator         guifg=white       guibg=NONE        gui=NONE      ctermfg=white       ctermbg=NONE        cterm=NONE

" Last search pattern highlighting
hi Search           guifg=black       guibg=yellow      gui=NONE      ctermfg=black       ctermbg=yellow      cterm=NONE

hi SignColumn       guifg=red         guibg=NONE        gui=NONE      ctermfg=red         ctermbg=NONE        cterm=NONE

" Changed line
hi DiffChange       guifg=NONE        guibg=brown       gui=NONE      ctermfg=NONE        ctermbg=brown       cterm=NONE

" Added line
hi DiffAdd          guifg=NONE        guibg=darkgreen   gui=NONE      ctermfg=NONE        ctermbg=darkblue    cterm=NONE

" Deleted line
hi DiffDelete       guifg=NONE        guibg=darkred     gui=NONE      ctermfg=NONE        ctermbg=darkred     cterm=NONE

" Changed text within a changed line
hi DiffText         guifg=NONE        guibg=darkmagenta gui=NONE      ctermfg=NONE        ctermbg=darkmagenta cterm=NONE

hi Question         guifg=green       guibg=NONE        gui=NONE      ctermfg=green       ctermbg=NONE        cterm=NONE

hi link Character       Constant
hi link Boolean         Type
hi link Float           Number
hi link Repeat          Statement
hi link Label           Label
hi link Exception       Statement
hi link Include         PreProc
hi link Define          PreProc
hi link Macro           PreProc
hi link PreCondit       PreProc
hi link StorageClass    Type
hi link Structure       Type
hi link Typedef         Type
hi link Tag             Special
hi link SpecialChar     Special
hi link SpecialComment  Special
hi link Debug           Special

