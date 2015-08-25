" Vim global plugin to handle commenting and uncommenting of varius filetypes
" Maintainer:  Ulf Renman <ulf.renman@gmail.com>
" License:	   This file is placed in the public domain.

if exists("loaded_ulf_comment")
  finish
endif
let loaded_ulf_comment = 1


" Set default comments
let b:UlfComment="#"
let b:UlfEndComment=""
" Define specified commentstyle for certain files
au BufRead,BufNewFile *.sh,*.pl,*.tcl,*.py let b:UlfComment="#"  | let b:UlfEndComment=""
au BufRead,BufNewFile *.js                 let b:UlfComment="//" | let b:UlfEndComment=""
au BufRead,BufNewFile *.cc,*.php,*.cxx     let b:UlfComment="//" | let b:UlfEndComment=""
au BufRead,BufNewFile *.c,*.h,*.css        let b:UlfComment="/*" | let b:UlfEndComment="*/"
au BufRead,BufNewFile *.sql,*.lua          let b:UlfComment="--" | let b:UlfEndComment=""
au BufRead,BufNewFile *.tmpl               let b:UlfComment="##" | let b:UlfEndComment=""
au filetype vim                            let b:UlfComment='"'  | let b:UlfEndComment=""

if !hasmapto('<Plug>UlfcommCommentLines')
  map <unique> ö  <Plug>UlfcommCommentLines
endif
noremap <unique> <script> <Plug>UlfcommCommentLines  <SID>CommentLines
noremap <SID>CommentLines  :call <SID>CommentLines()<CR>

function s:CommentLines()
    exe ":s@^\\s*@\\0".b:UlfComment."@g"
    exe ":s@$@".b:UlfEndComment."@g"
    exe "+"
endfun


if !hasmapto('<Plug>UlfcommUnCommentLines')
  map <unique> Ö  <Plug>UlfcommUnCommentLines
endif
noremap <unique> <script> <Plug>UlfcommUnCommentLines  <SID>UnCommentLines
noremap <SID>UnCommentLines  :call <SID>UnCommentLines()<CR>

function s:UnCommentLines()
    exe ":s@\\(^\\s*\\)".b:UlfComment."@\\1@g"
    exe ":s@".b:UlfEndComment."$@@g"
    exe "+"
endfun
