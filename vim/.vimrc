set number          "set linenumbers

set wrap            " word wrap
set linebreak       " only wrap at breaking characters
set nolist          " list disables linebreak
set showcmd         " show commands while they are being typed
set ignorecase      " case insensitive searching

set mouse=a         " allow proper scrolling with mouse wheel
set hlsearch        " hightlight search terms
set tabstop=4       " The width of a TAB is set to 2.
                  " Still it is a \t. It is just that
                  " Vim will interpret it to be having
                  " a width of 4.

set shiftwidth=4    " Indents will have a width of 2

set softtabstop=4  " Sets the number of columns for a TAB

set expandtab       " Expand TABs to spaces
set autoindent
set undofile        " Persistent undo
set undodir=~/.vim/undodir

set backup
set backupdir=~/.vim/backup,.
set directory=~/.vim/backup,.

map <Space> <Nop>
let g:mapleader="\<Space>"
let g:maplocalleader="\<Space>"

" braces, brackets, and parentheses oh my!
" inoremap {<cr> {<CR>}<ESC>ko<Tab>
" inoremap [<cr> [<CR>]<ESC>ko<Tab>
" inoremap (<cr> (<CR>)<ESC>ko<Tab>

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

" Ctrl Backspace to delete words
noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>
inoremap <C-w> <C-\><C-o>dB
inoremap <C-BS> <C-\><C-o>db

set backspace=indent,eol,start

" Remapping the command line window because
" I'm a terrible typist
map q: :q

" leader stuff
" reloading .vimrc
noremap <leader>rr :source ~/.vimrc<CR>

" copy and pasting from system clipbard
noremap <leader>p "+p
noremap <leader>y "+y

noremap <leader>ss :%s/\(\ \+$\)//g<CR><C-o>

let g:Tex_leader="\<Space>"

" collapsing with space
nnoremap <leader>a za

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
Plug 'tpope/vim-surround'

" unix commands in vim
Plug 'tpope/vim-eunuch'

" indent char
Plug 'yggdroot/indentline'

" Auto brackets
Plug 'raimondi/delimitMate'

" markdown previewing
Plug 'iamcco/markdown-preview.vim'

" LaTeX things
Plug 'lervag/vimtex'

" markdown pandoc
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-pandoc'

" tags
Plug 'ludovicchabant/vim-gutentags'
call plug#end()
" ===========================Plugins

" Plugin Configs====================
" config for indentline
let g:indentLine_color_term = 239
let g:indentLine_char='┊'
let g:indentLine_fileTypeExclude = ['markdown', 'json']

" config for delimitmate
let g:delimitMate_autoclose = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_expand_cr = 1
let g:delimitMate_matchpairs = '(:),[:],{:}'
au FileType pandoc let b:delimitMate_quotes = "\" '"
au FileType Markdown let b:delimitMate_quotes = "\" '"

" config for vimtex
let g:vimtex_compiler_latexmk = {'callback' : 0}
" let g:latex_view_general_viewer = 'zathura'
let g:vimtex_view_method = 'zathura'
let g:tex_conceal = ''

" config for vim-markdown
let g:tex_conceal = ""
let g:vim_markdown_math = 1

" Pandoc vim
" let g:pandoc#command#autoexec_on_writes = 1
" let g:pandoc#command#autoexec_command = "Pandoc pdf"
let g:pandoc#syntax#conceal#blacklist = ["codeblock_start","codeblock_delim","inlinecode", "quotes","list"]
let g:pandoc#syntax#conceal#cchar_overrides = {"atx":"#"}
let g:pandoc#syntax#style#use_definition_lists = 0
let g:pandoc#modules#disabled = ["folding"]
noremap <leader>- :Pandoc pdf<CR>

" config for Guentags
" let g:gutentags_cache_dir = '~/.tags'
let g:gutentags_generate_on_empty_buffer = 1
let g:gutentags_define_advanced_commands = 1
let g:gutentags_file_list_command = 'find . \( -name \*.h -o -name \*.cpp \)'
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
set statusline+=%#Black#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\
" ========================statusline
