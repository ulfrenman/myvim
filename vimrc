" Put here to get pathogen work (copied from
"   https://github.com/scrooloose/syntastic)
execute pathogen#infect()

" Make it possible to switch buffer in MiniBufExplorer without saving first.
set hidden
" To handle buffers easily I use the MiniBufExplorer plugin. Read the
" plugin for info on how to configure.
" Since the <C-TAB> is not mappable in the terminal I use thise mappings:
map § :bn
map ½ :bp
