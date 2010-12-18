syn keyword	cAnsiName	errno environ

" Operators
syn match cOperator	"\(<<\|>>\|[-+*/%&^|<>!=]\)="
syn match cOperator	"<<\|>>\|&&\|||\|++\|--\|->"
syn match cOperator	"[.!~*&%<>^|=,+-]"
syn match cOperator	"/[^/*=]"me=e-1
syn match cOperator	"/$"
syn match cOperator "&&\|||"
syn match cOperator	"[][]"

syn match cUserFunction "\<\I\i*\>\(\s\|\n\)*("me=e-1
" syn match cUserFunctionPointer "\<\h\w*\>[^()]*)\(\s\|\n\)*(" contains=cDelimiter

" syn match cDelimiter	"[\[\](){};\\]"
" ; расположен в модифицированном c.vim
syn match cDelimiter	"[\[\](){}\\]"

" Links
hi def link cDelimiter Delimiter
hi def link cUserFunction Function
" hi def link cUserFunctionPointer Function
" hi def link cAnsiFunction Function
" hi def link cAnsiName Identifier
" hi def link cBoolean Boolean

syn keyword cType uint ubyte ulong uint64_t uint32_t uint16_t uint8_t boolean_t int64_t int32_t int16_t int8_t u_int64_t u_int32_t u_int16_t u_int8_t u8 u16 u32

