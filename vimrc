" Put here to get pathogen work (copied from
"   https://github.com/scrooloose/syntastic)
" This needs to be among the first things to called in vimrc.
execute pathogen#infect()


" ===========================================================================
" Some general things
" ===========================================================================
" Turn filetype detection, plugins and indent on
filetype plugin indent on

" Wrapping and tabs. These are mostly needed for programming stuff but
" we set it on this general vimrc to make it global since I like it!
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set softtabstop=4
set autoindent

" briefly jump to the matching bracket
set showmatch

" always show statusline
set laststatus=2

" highlight previous search pattern
set hlsearch

" display incomplete commands
set showcmd

" do incremental searching
set incsearch

" set lenght of historyfile (.viminfo), defaults to 20
set history=1000

" Disable audio and visual error bells
set noerrorbells visualbell t_vb=

" Vim5 and later versions support syntax highlighting.
if has("syntax")
    syntax on
endif


" ===========================================================================
" MiniBufExplorer
" ===========================================================================
" Make it possible to switch buffer in MiniBufExplorer without saving first.
set hidden
" To handle buffers easily I use the MiniBufExplorer plugin. Read the
" plugin for info on how to configure.
" Since the <C-TAB> is not mappable in the terminal I use these mappings to
" move between buffers:
map § :bnext<CR>
map ½ :bprevious<CR>

" To avoid autoscrolling when switching buffers (I did not have this problem
" before but now I have it and its anoying /Ulf 2013-04-25). From
"   http://vim.wikia.com/wiki/Avoid_scrolling_when_switch_buffers
au BufLeave * if !&diff | let b:winview = winsaveview() | endif
au BufEnter * if exists('b:winview') && !&diff | call winrestview(b:winview) | endif


" ===========================================================================
" Help
" ===========================================================================
" Jump to (help) tag and back
map ä <c-]>
map Ä <c-t>


" ===========================================================================
" Formatting
" ===========================================================================
" To make paragraph formatting use shorter key-sequence
map Q gwap


" ===========================================================================
" Diff
" ===========================================================================
" How will vimdiff will work and look
set diffopt=filler,context:1
if &diff
  colorscheme pablo
endif


" ===========================================================================
" Folding
" ===========================================================================
" Folding stuff from:
"   http://stackoverflow.com/questions/357785/
set foldmethod=indent
set foldlevelstart=99
nnoremap <space> za


" ===========================================================================
" Trailing whitespace
" ===========================================================================
" I do not like to have a lot of trailing whitespace at the end of lines.
" Highlight it to make it obvious and easy to remove!
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/


" ===========================================================================
" Line numbering
" ===========================================================================
" The function cycles between 3 states:
"   * No line numbering at all
"   * Line numbers starts from 1 at the first line in the file
"   * Relative numbering where 0 is at the cursor
"
" The cycling is mapped to the F11-key in normal mode.
function! g:ToggleLineNumbering()
    if &number
        setlocal relativenumber
    elseif &relativenumber
        setlocal norelativenumber!
    else
        setlocal number
    endif
endfunction
nnoremap <F11> :call g:ToggleLineNumbering()<CR>


" ===========================================================================
" Syntastic
" ===========================================================================
" Make Syntastic only check the file on <F6>. It takes an annoyingly long time
" to do the flake8 check at write so its disabled by default.
let g:syntastic_mode_map = { 'mode': 'passive' }
nnoremap <F6> :SyntasticToggleMode<CR>


" ===========================================================================
" Gundo
" ===========================================================================
" Configure the Gundo plugin and map <F5> to toggel it.
nnoremap <F5> :GundoToggle<CR>
" Put the preview window below the main textarea
let g:gundo_preview_bottom = 1



" ===========================================================================
" Textwidth
" ===========================================================================
" If textwidth is not set (could be set by ftplugin/ or syntax/ files for
" example) then set it.
function! g:ToggleTextWidth()
    if &textwidth == 0
        setlocal textwidth=78
    endif
endfunction

