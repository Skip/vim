syntax match infoInstruction "^info"
syntax match errorInstruction "^error"
syntax match atollFunction "\<\h\w*\>\(\s\|\n\)*("me=e-1
syntax match atollFileC "\<\h\w*\>\.c"
syntax match atollFileCPP "\<\h\w*\>\.cpp"
syntax match atollLine "(\d*)"hs=s+1,he=e-1
" syntax match atollOperator "->"
syntax region atollMessage start="->"hs=s+2 end="$"


hi def link infoInstruction		Type
hi def link errorInstruction	Error
" hi def link atollOperator       Label
hi def link atollFunction       Function
hi def link atollFileC          Operator
hi def link atollFileCPP        Operator
hi def link atollLine           Delimiter
hi def link atollMessage        String
