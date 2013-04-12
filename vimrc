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
set textwidth=78
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


" ===========================================================================
" MiniBufExplorer
" ===========================================================================
" Make it possible to switch buffer in MiniBufExplorer without saving first.
set hidden
" To handle buffers easily I use the MiniBufExplorer plugin. Read the
" plugin for info on how to configure.
" Since the <C-TAB> is not mappable in the terminal I use these mappings to
" move between buffers:
map § :bnext
map ½ :bprevious


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
