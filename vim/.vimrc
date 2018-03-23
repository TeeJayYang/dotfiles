set number          "set linenumbers

set wrap            " word wrap
set linebreak       " only wrap at breaking characters
set nolist          " list disables linebreak

set mouse=a         " allow proper scrolling with mouse wheel
set hlsearch        " hightlight search terms
set tabstop=2       " The width of a TAB is set to 2.
                  " Still it is a \t. It is just that
                  " Vim will interpret it to be having
                  " a width of 4.

set shiftwidth=2    " Indents will have a width of 2

set softtabstop=2   " Sets the number of columns for a TAB

set expandtab       " Expand TABs to spaces
set autoindent

" braces, brackets, and parentheses oh my!
inoremap {<cr> {<CR>}<ESC>ko<Tab>
inoremap [<cr> [<CR>]<ESC>ko<Tab>
inoremap (<cr> (<CR>)<ESC>ko<Tab>

" more intuitive line navigation
nnoremap j gj
nnoremap k gk
xnoremap j gj
xnoremap k gk

" vim window navigation 
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright

" indenting in visual mode stays in visual mode
xnoremap > >gv
xnoremap < <gv

" switching case in visual mode stays in visual mode
xnoremap u ugv
xnoremap U ugv
xnoremap ~ ~gv

" collapsing with space
" nnoremap <space> za

"syntax highlighting
" for Jenkinsfile
au BufNewFile,BufRead Jenkinsfile setf groovy

" Plugins===========================
""" Plugins
"" Download vim-plug if it does not exist
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup vimplug_group
    autocmd!
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup END
endif
call plug#begin('~/.vim/bundle')
" color scheme
" dynamic colorscheme
" Plug 'dylanaraps/wal.vim'
" colorscheme wal

"" Highlighting for transparent background
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
highlight VertSplit ctermbg=none

" QoL things
Plug 'tpope/vim-sensible'

" easy commenting
Plug 'tpope/vim-commentary'

" repeating plugin maps
Plug 'tpope/vim-repeat'

" text surrounding
" Plug 'tpope/vim-surround'

" backet mappings
" Plug 'tpope/vim-unimpaired'

" unix commands in vim
Plug 'tpope/vim-eunuch'

" indent char
Plug 'yggdroot/indentline'

" Auto brackets
" Plug 'raimondi/delimitMate'

" markdown previewing
Plug 'iamcco/markdown-preview.vim'

call plug#end()
" ===========================Plugins

" Plugin Configs====================
" config for indentline
let g:indentLine_color_term = 239
let g:indentLine_char='┊'
let g:indentLine_fileTypeExclude = ['markdown', 'json']

" config for delimitmate
" let g:delimitMate_autoclose = 1
" let g:delimitMate_expand_space = 1
" let g:delimitMate_expand_cr = 1
" let g:delimitMate_matchpairs = '(:),[:],{:}'
" ====================Plugin Configs


" statusline========================
highlight statusLineDark ctermfg=12 ctermbg=0
highlight statusLineLight ctermfg=15 ctermbg=10
highlight statusLineAccent ctermfg=15 ctermbg=160
set laststatus=2

function! CurrentGitStatus()
  let gitoutput = split(system('git status --porcelain -b '.shellescape(expand('%')).' 2>/dev/null'),'\n')
  if len(gitoutput) > 0
    let b:gitstatus = strpart(get(gitoutput,0,''),3) . '/' . strpart(get(gitoutput,1,'  '),0,2)
  else
    let b:gitstatus = ''
  endif
endfunc

autocmd BufEnter,BufWritePost * call CurrentGitStatus()

function! StatusLinePasteMode() abort
	let l:paste_status = &paste
	if l:paste_status == 1
		return '[P]'
	endif
	return ''
endfunction

set statusline=
set statusline+=%#statusLineAccent#
set statusline+=%{StatusLinePasteMode()}
set statusline+=%#statusLineDark#
set statusline+=\ %(<%{b:gitstatus}>%)
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m\
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ 
" ========================statusline
