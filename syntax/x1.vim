" Vim syntax file
" Language: X1
" Maintainer: Normen Müller
" Latest Revision: 10 November 2017

if exists("b:current_syntax")
  finish
endif

scriptencoding utf-8

let b:current_syntax = "x1"

syn keyword x1Keyword unit
syn keyword x1Keyword import
syn keyword x1Keyword as
syn keyword x1Keyword use
syn keyword x1Keyword provide
syn keyword x1Keyword calculate
syn keyword x1Keyword export
syn keyword x1Keyword match
syn keyword x1Keyword case
syn keyword x1Keyword val
hi link x1Keyword Keyword

syn keyword x1External import
hi link x1External Include

syn match x1Char /'.'/
syn match x1Char /'\\[\\"'ntbrf]'/ contains=x1EscapedChar
syn match x1Char /'\\u[A-Fa-f0-9]\{4}'/ contains=x1UnicodeChar
syn match x1EscapedChar /\\[\\"'ntbrf]/
syn match x1UnicodeChar /\\u[A-Fa-f0-9]\{4}/
hi link x1Char Character
hi link x1EscapedChar Function
hi link x1UnicodeChar Special

syn match x1StringEmbeddedQuote /\\"/ contained
syn region x1String start=/"/ end=/"/ contains=x1StringEmbeddedQuote,x1EscapedChar,x1UnicodeChar
hi link x1String String
hi link x1StringEmbeddedQuote String
syn region x1RoundBrackets start="(" end=")" skipwhite contained contains=x1RoundBrackets

syn region x1IString matchgroup=x1InterpolationBrackets start=/\<[a-zA-Z][a-zA-Z0-9_]*"/ skip=/\\"/ end=/"/ contains=x1Interpolation,x1InterpolationB,x1EscapedChar,x1UnicodeChar
syn match x1Interpolation /\$[a-zA-Z0-9_$]\+/ contained
hi link x1InterpolationB Normal
hi link x1InterpolationBrackets Special

syn region x1MultilineComment start="/\*" end="\*/" contains=x1MultilineComment,x1DocLinks,x1ParameterAnnotation,x1CommentAnnotation,x1Todo,x1CommentCodeBlock keepend fold
syn match x1CommentAnnotation "@[_A-Za-z0-9$]\+" contained
syn match x1ParameterAnnotation "\%(@param\|@see\)" nextgroup=x1ParamAnnotationValue skipwhite contained
syn match x1ParamAnnotationValue /[.`_A-Za-z0-9$]\+/ contained
syn region x1DocLinks start="\[\[" end="\]\]" contained
syn region x1CommentCodeBlock matchgroup=Keyword start="{{{" end="}}}" contained
syn match x1Todo "\vTODO|FIXME|XXX" contained
hi link x1MultilineComment Comment
hi link x1DocLinks Function
hi link x1ParameterAnnotation Function
hi link x1ParamAnnotationValue Keyword
hi link x1CommentAnnotation Function
hi link x1CommentCodeBlockBrackets String
hi link x1CommentCodeBlock String
hi link x1Todo Todo

syn match x1Unimplemented /???/
hi link x1Unimplemented Todo

syn match x1TrailingComment "--.*$" contains=x1Todo
hi link x1TrailingComment Comment
