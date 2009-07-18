set background=light

hi clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "pyte"

hi CursorLine      guifg=NONE      guibg=#d5d5d5   gui=NONE
hi Visual          guifg=NONE      guibg=#d0d0d0   gui=NONE
hi MatchParen      guifg=white     guibg=#80a090   gui=bold
hi TabLine         guifg=black     guibg=#b0b8c0   gui=italic
hi TabLineFill     guifg=#9098a0   guibg=NONE      gui=NONE
hi TabLineSel      guifg=black     guibg=#f0f0f0   gui=italic,bold
hi Pmenu           guifg=white     guibg=#808080   gui=NONE
hi Title           guifg=#202020   guibg=NONE      gui=bold
hi Underlined      guifg=#202020   guibg=NONE      gui=underline
hi Cursor          guifg=bg        guibg=fg        gui=NONE
hi lCursor         guifg=black     guibg=white     gui=NONE
hi LineNr          guifg=gray50    guibg=#e0e0e0   gui=NONE
hi Normal          guifg=#202020   guibg=#e0e0e0   gui=NONE
hi StatusLine      guifg=white     guibg=#8090a0   gui=bold,italic
hi StatusLineNC    guifg=#506070   guibg=#a0b0c0   gui=italic
hi VertSplit       guifg=#a0b0c0   guibg=#a0b0c0   gui=NONE
hi Folded          guifg=#708090   guibg=#c0d0e0   gui=NONE
hi NonText         guifg=#c0c0c0   guibg=#e0e0e0   gui=NONE
hi Comment         guifg=gray60   guibg=NONE      gui=italic
hi Constant        guifg=#a07040   guibg=NONE      gui=NONE
hi String          guifg=#4070a0   guibg=NONE      gui=NONE
hi Number          guifg=#40a070   guibg=NONE      gui=NONE
hi Float           guifg=#70a040   guibg=NONE      gui=NONE
hi Statement       guifg=#007020   guibg=NONE      gui=bold
hi Type            guifg=#CC8F0B   guibg=NONE      gui=italic
hi Structure       guifg=#007020   guibg=NONE      gui=italic
hi Function        guifg=#06287e   guibg=NONE      gui=italic
hi Identifier      guifg=#5b3674   guibg=NONE      gui=italic
hi Repeat          guifg=#7fbf58   guibg=NONE      gui=bold
hi Conditional     guifg=#4c8f2f   guibg=NONE      gui=bold
hi PreProc         guifg=#1060a0   guibg=NONE      gui=NONE
hi Define          guifg=#1060a0   guibg=NONE      gui=bold
hi Error           guifg=red       guibg=white     gui=bold,underline
hi Todo            guifg=black     guibg=red       gui=italic,bold,underline
hi Special         guifg=#70a0d0   guibg=NONE      gui=italic
hi Operator        guifg=#408010   guibg=NONE      gui=NONE
hi SpecialKey      guifg=#d8a080   guibg=#e8e8e8   gui=italic
hi DiffChange      guifg=NONE      guibg=#e0e0e0   gui=italic,bold
hi DiffText        guifg=NONE      guibg=#f0c8c8   gui=italic,bold
hi DiffAdd         guifg=NONE      guibg=#c0e0d0   gui=italic,bold
hi DiffDelete      guifg=NONE      guibg=#f0e0b0   gui=italic,bold
hi Label           guifg=#1060a0   guibg=NONE      gui=bold
