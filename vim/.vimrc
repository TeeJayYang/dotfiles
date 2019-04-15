set number          "set linenumbers

set wrap            " word wrap
set linebreak       " only wrap at breaking characters
set nolist          " list disables linebreak
set showcmd         " show commands while they are being typed
set ignorecase      " case insensitive searching
set background=dark " force dark background on terminal transparency

set mouse=a         " allow proper scrolling with mouse wheel
set hlsearch        " hightlight search terms
set tabstop=2       " The width of a TAB

set shiftwidth=2    " Indent width

set softtabstop=2  " Sets the number of columns for a TAB

set expandtab       " Expand TABs to spaces 
set autoindent

set undofile        " Persistent undo
set undodir=~/.vim/undo//
set backup
set backupdir=~/.vim/backup//
set directory=~/.vim/swp//
"
" Create necessary directories
if exists('*mkdir')
  for s:dir in [ '/.vim/backup', '/.vim/swp', '/.vim/undo', '/.vim/tags', '/.vim/viminfo' ]
    if !isdirectory($HOME.s:dir)
      call mkdir($HOME.s:dir, 'p')
    endif
  endfor
endif

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
nnoremap H ^
nnoremap L $
xnoremap H ^
xnoremap L $

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
xnoremap U Ugv
xnoremap ~ ~gv

" inc/decrementing numbers in visual mode statys in visual mode
xnoremap <C-a> <C-a>gv
xnoremap <C-x> <C-x>gv

" Grep for word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" use ag for vim grep
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Ctrl Backspace to delete words
noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>
inoremap <C-w> <C-\><C-o>dB
inoremap <C-BS> <C-\><C-o>db

set backspace=indent,eol,start

" Remapping the command line window because
" I'm a terrible typist
map q: :q

" yanking moves cursor to end of yanked text
vmap y ygv<Esc>

" leader stuff
" reloading .vimrc
noremap <leader>rr :source ~/.vimrc<CR>

" copy and pasting from system clipbard
noremap <leader>p "+p
noremap <leader>y "+y

noremap <leader>ss :%s/\(\ \+$\)//g<CR><C-o>:noh<CR>

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

" LaTeX things
Plug 'lervag/vimtex'

" markdown pandoc
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-pandoc'

" tags
Plug 'ludovicchabant/vim-gutentags'

" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" ============= Document Writing ============
"
" markdown previewing
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}

" markdown qol
Plug 'reedes/vim-pencil'

" better syntax
Plug 'sheerun/vim-polyglot'

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

" config for vim-pencil
let g:pencil#textwidth = 150
map <F11> :PencilToggle <CR>

" config for markdown-preview
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'relative'
    \ }

" Pandoc vim
" let g:pandoc#command#autoexec_on_writes = 1
" let g:pandoc#command#autoexec_command = "Pandoc pdf"
"
" let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
" let g:pandoc#filetypes#pandoc_markdown = 0

let g:pandoc#syntax#conceal#blacklist = ["codeblock_start","codeblock_delim","inlinecode", "quotes","list", "ellipses"]
let g:pandoc#syntax#conceal#cchar_overrides = {"atx":"#"}
let g:pandoc#syntax#style#use_definition_lists = 0
let g:pandoc#modules#disabled = ["folding"]
noremap <leader>- :Pandoc pdf<CR>

" config for Guentags
" let g:gutentags_cache_dir = '~/.tags'
let g:gutentags_generate_on_empty_buffer = 1
let g:gutentags_define_advanced_commands = 1
let g:gutentags_file_list_command = 'find . \( -name \*.h -o -name \*.cpp -o -name \*.c -o -name \*.java \)'

" config for vim-commentary
au FileType cpp setl cms=//\ %s
au FileType c setl cms=//\ %s

"" Config for Fzf
function! s:tags_sink(lines) abort
  if empty(a:lines)
    return
  endif
  let l:cmd = get({
        \ 'ctrl-t': 'tabedit',
        \ 'ctrl-x': 'split',
        \ 'ctrl-v': 'vsplit',
        \ }, remove(a:lines, 0), 'e')
  let l:query = a:lines[0]
  let l:parts = split(l:query, '\t\zs')
  let l:excmd = matchstr(l:parts[2:], '^.*\ze;"\t')
  execute 'silent ' l:cmd l:parts[1][:-2]
  let [l:magic, &magic] = [&magic, 0]
  execute l:excmd
  let &magic = l:magic
endfunction

command! Tags call fzf#run(fzf#wrap({
      \ 'source':  'cat '.join(map(tagfiles(), 'fnamemodify(v:val, ":S")')).
      \            '| grep -v -a ^!',
      \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index --expect=ctrl-x,ctrl-v',
      \ 'down': '40%',
      \ 'sink*':    function('s:tags_sink'),
      \ }))
command! Buffers call fzf#run(fzf#wrap({
      \ 'source': filter(map(range(1, bufnr('$')), 'bufname(v:val)'), 'len(v:val)'),
      \ }))
command! MRU call fzf#run(fzf#wrap({
      \ 'source': v:oldfiles,
      \ }))

"" Config for Polyglot
let g:polyglot_disabled = ['latex']
" ====================Plugin Configs


" statusline========================
highlight statusLineNC ctermfg=8 ctermbg=2
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

" highlight if over the 90 char limit
" highlight ColorColumn ctermbg=magenta
" call matchadd('ColorColumn', '\%91v', 100)

" Fzf keybindings
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>f :FZF<CR>
nnoremap <leader>m :MRU<CR>
nnoremap <leader>t :Tags<CR>

" Write with sudo
cmap w!! w !sudo tee > /dev/null %

" Jump to last edited position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
