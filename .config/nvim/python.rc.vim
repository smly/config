" vim-python
let g:python3_host_prog = '/home_raw/marzio/anaconda/bin/python'

augroup vimrc-python
  autocmd!
  autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=89
      \ formatoptions+=croq softtabstop=4
      \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END

" black
let g:black_fast = 0
let g:black_linelength = 88
let g:black_skip_string_normalization = 0
let g:black_virtualenv = "~/.vim/black"

" jedi-vim
" let g:jedi#popup_on_dot = 0
" let g:jedi#goto_assignments_command = "<leader>g"
" let g:jedi#goto_definitions_command = "<leader>d"
" let g:jedi#documentation_command = "K"
" let g:jedi#usages_command = "<leader>n"
" let g:jedi#rename_command = "<leader>r"
" let g:jedi#show_call_signatures = "0"
" let g:jedi#completions_command = "<C-Space>"
" let g:jedi#smart_auto_mappings = 0

" syntastic
" let g:syntastic_python_checkers=['python', 'flake8']
" let g:syntastic_cpp_checkers=['gcc']
" let g:syntastic_cpp_compiler='gcc'
" let g:syntastic_cpp_compiler_options='-std=c++14'

" vim-airline
let g:airline#extensions#virtualenv#enabled = 1

" Syntax highlight
" Default highlight is better than polyglot
let g:polyglot_disabled = ['python']
let python_highlight_all = 1
