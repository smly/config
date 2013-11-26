""""""""""""""
"""""" General
set history=700
let base16colorspace=256
set background=dark

"filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

set incsearch

" Only check case if the searched word contains a capital character.
set ignorecase
set smartcase

set smartindent

set showmatch matchtime=1

set wildmode=list:longest

" Ignore files
set wildignore=
" C
set wildignore+=*.o,*.d,*.so
" Java
set wildignore+=*.class
" LaTeX
set wildignore+=*.aux,*.log,*.out,*.toc,*.pdf
" Python
set wildignore+=*.pyc

set history=1000
set undolevels=1000

" Wrap text after 79 chars.
set textwidth=79


" Visualize the line the cursor is currently in.
if exists('+cursorline')
  set cursorline
endif

"""""""""""""
"""""" bundle

set nocompatible               " be iMproved
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle/'))
endif
" originalrepos on github
NeoBundle 'chriskempson/base16-vim'
"NeoBundle 'haruyama/vim-matchopen'
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'VimClojure'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Lokaltog/vim-powerline'
""NeoBundle 'https://bitbucket.org/kovisoft/slimv'
NeoBundle 'kongo2002/fsharp-vim'
"NeoBundle 'xolox/vim-colorscheme-switcher'

"""""" go
set rtp+=$GOROOT/misc/vim
set completeopt=menu,preview

filetype plugin indent on     " required!
filetype indent on
syntax on
let g:Powerline_symbols='fancy'

""""" indentation
set tabstop=2
set shiftwidth=2
set expandtab

if has('autocmd')
  augroup python
    autocmd BufReadPre,FileReadPre      *.py set tabstop=4
    autocmd BufReadPre,FileReadPre      *.py set expandtab
  augroup END

  augroup ruby
    autocmd BufReadPre,FileReadPre      *.py set tabstop=2
    autocmd BufReadPre,FileReadPre      *.py set expandtab
  augroup END

  augroup go
    autocmd BufReadPre,FileReadPre      *.go set tabstop=4
  augroup END
endif

"""""""""""""""""""""""""
"""""" vim user interface

set so=7
set wildmenu
set number

" make stuff more readable
set fcs=vert:│,fold:\ 
set fillchars+=stl:\ ,stlnc:\ 
set listchars=tab:·\ ,trail:░,extends:»,precedes:«
set list

"""""""""""""""""""""""
"""""" Colors and Fonts

" Enable syntax highlight
"syntax enable


set t_Co=256
set background=dark

try
    colorscheme distinguished
    "colorscheme vimbrant
    "colorscheme base16-railscasts
catch
endtry

"highlight clear SignColumn
"highlight VertSplit    ctermbg=236
"highlight ColorColumn  ctermbg=237
"highlight LineNr       ctermbg=236 ctermfg=240
"highlight CursorLineNr ctermbg=236 ctermfg=240
"highlight CursorLine   ctermbg=236
"highlight StatusLineNC ctermbg=238 ctermfg=0
"highlight StatusLine   ctermbg=240 ctermfg=12
"highlight IncSearch    ctermbg=0   ctermfg=3
"highlight Search       ctermbg=0   ctermfg=9
"highlight Visual       ctermbg=3   ctermfg=0
"highlight Pmenu        ctermbg=240 ctermfg=12
"highlight PmenuSel     ctermbg=0   ctermfg=3
"highlight SpellBad     ctermbg=0   ctermfg=1
"
"hi ColorColumn ctermbg=7
"hi ColorColumn guibg=Gray
"
"hi LineNr        cterm=none      ctermfg=darkgrey    ctermbg=none
"hi VertSplit     cterm=none      ctermfg=darkgreen   ctermbg=none

""""" Spell checking

map <leader>ss :setlocal spell!<cr>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

""""""""""""""""""""""""""""""""""""""""""""""
""""" Moving around, tabs, windows and buffers

map j gj
map k gk

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>
map <leader>ba :1,1000 bd!<cr>

"""""""""""""""""
""""" status line

" always show the status line
set laststatus=2
