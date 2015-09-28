" Vim global plugin to handle commenting and uncommenting of varius filetypes
" Last Change: 2013-04-12
" Maintainer:  Ulf Renman <ulf.renman@gmail.com>
" License:	   This file is placed in the public domain.

if exists("loaded_ulf_comment")
  finish
endif
let loaded_ulf_comment = 1


" Set default comments
let s:Comment="BLA"
let s:EndComment=""
" Define specified commentstyle for certain files
au BufRead,BufNewFile *.sh,*.pl,*.tcl,*.py let s:Comment="#"  | let s:EndComment=""
au BufRead,BufNewFile *.js                 let s:Comment="//" | let s:EndComment=""
au BufRead,BufNewFile *.cc,*.php,*.cxx     let s:Comment="//" | let s:EndComment=""
au BufRead,BufNewFile *.c,*.h,*.css        let s:Comment="/*" | let s:EndComment="*/"
au BufRead,BufNewFile *.sql,*.lua          let s:Comment="--" | let s:EndComment=""
au BufRead,BufNewFile *.tmpl               let s:Comment="##" | let s:EndComment=""
au filetype vim                            let s:Comment='"'  | let s:EndComment=""

if !hasmapto('<Plug>UlfcommCommentLines')
  map <unique> ö  <Plug>UlfcommCommentLines
endif
noremap <unique> <script> <Plug>UlfcommCommentLines  <SID>CommentLines
noremap <SID>CommentLines  :call <SID>CommentLines()<CR>

function s:CommentLines()
    exe ":s@^\\s*@\\0".s:Comment."@g"
    exe ":s@$@".s:EndComment."@g"
    exe "+"
endfun


if !hasmapto('<Plug>UlfcommUnCommentLines')
  map <unique> Ö  <Plug>UlfcommUnCommentLines
endif
noremap <unique> <script> <Plug>UlfcommUnCommentLines  <SID>UnCommentLines
noremap <SID>UnCommentLines  :call <SID>UnCommentLines()<CR>

function s:UnCommentLines()
    exe ":s@\\(^\\s*\\)".s:Comment."@\\1@g"
    exe ":s@".s:EndComment."$@@g"
    exe "+"
endfun
