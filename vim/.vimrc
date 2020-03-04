set number          "set linenumbers

set wrap            " word wrap
set linebreak       " only wrap at breaking characters
set nolist          " list disables linebreak
set showcmd         " show commands while they are being typed
set ignorecase      " case insensitive searching
set smartcase       " smart case searching
set background=dark " force dark background on terminal transparency
set cursorline
set completeopt=menu,menuone,preview,noselect,noinsert
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=1
hi clear SpellCap
hi SpellCap cterm=underline ctermfg=4
hi IncSearch cterm=underline ctermfg=0 ctermbg=5
hi link SearchLight IncSearch

set mouse=a         " allow proper scrolling with mouse wheel
set hlsearch        " hightlight search terms
set tabstop=4       " The width of a TAB

set shiftwidth=4    " Indent width

set softtabstop=4  " Sets the number of columns for a TAB

set expandtab       " Expand TABs to spaces
set autoindent
set modeline        " enable modeline

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
nnoremap H b
nnoremap L e
xnoremap H b
xnoremap L e

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

  " Use ag for FZF
  let $FZF_DEFAULT_COMMAND = 'ag -g ""'

  " Using Ag for global grep
  command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

  nnoremap ? :Ag<SPACE>

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

" Remapping the command line window
map q: :q

" yanking moves cursor to end of yanked text
vmap y ygv<Esc>

" leader stuff
" reloading .vimrc
noremap <leader>rr :source ~/.vimrc<CR>

" copy and pasting from system clipbard
noremap <leader>p "+p
noremap <leader>y "+y

" noremap <leader>ss :%s/\(\ \+$\)//g<CR><C-o>

let g:Tex_leader="\<Space>"

" collapsing with space
nnoremap <leader>a za

"syntax highlighting
" for Jenkinsfile
au BufNewFile,BufRead Jenkinsfile setf groovy

" ROS launch files
au BufNewFile,BufRead *.launch setf xml

" Auto close the quickfix window if it's the last window
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && &buftype == "quickfix"|q|endif
aug END

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

" Regular color scheme
Plug 'joshdick/onedark.vim'

"" Highlighting for transparent background
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
highlight VertSplit ctermbg=none

" editor config
Plug 'editorconfig/editorconfig-vim'

" QoL things
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'

" easy commenting
Plug 'tpope/vim-commentary'

" repeating plugin maps
Plug 'tpope/vim-repeat'

" text surrounding
Plug 'tpope/vim-surround'

" indent char
Plug 'yggdroot/indentline'

" Auto brackets
Plug 'raimondi/delimitMate'

" tags
Plug 'ludovicchabant/vim-gutentags'

" tmux navigation
Plug 'christoomey/vim-tmux-navigator'

" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" highlighting for current search
Plug 'peterrincker/vim-searchlight'

" better syntax
Plug 'sheerun/vim-polyglot'

" linting
Plug 'w0rp/ale'

" statusline
Plug 'rbong/vim-crystalline'

" code context
" Plug 'wellle/context.vim'
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
au FileType pandoc let b:delimitMate_nesting_quotes = ['`']
au FileType Markdown let b:delimitMate_nesting_quotes = ['`']

" config for Guentags
let g:gutentags_cache_dir = '~/.tags'
let g:gutentags_generate_on_empty_buffer = 1
let g:gutentags_define_advanced_commands = 1
let g:gutentags_ctags_exclude = ["*.min.js", "*.min.css", "build", "vendor", ".git", "node_modules", "*.vim/bundle/*"]

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

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Todo', 'rounded': v:true} }


"" Ale
let g:ale_linters = {
        \ 'python': [ 'flake8' ],
        \}

let g:ale_fixers = {
        \ '*': [ 'remove_trailing_lines', 'trim_whitespace' ],
        \ 'cpp': [ 'clang-format', 'remove_trailing_lines', 'trim_whitespace' ],
        \ 'python': [ 'yapf' ],
        \}
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_lint_on_text_changed = 'never'
let g:ale_linters_explicit = 1
let g:ale_set_quickfix = 0
let g:ale_sign_column_always = 0
let g:ale_open_list = 0
let g:ale_virtualenv_dir_names = ['.env', '.venv', 'env', 've-py3', 've', 'virtualenv', 'venv']
" let g:ale_echo_cursor = 0
" let g:ale_completion_enabled = 1

nmap <silent> <C-p> <Plug>(ale_previous_wrap)
nmap <silent> <C-n> <Plug>(ale_next_wrap)
nmap <leader>l :lop<CR>
nmap <leader>ss :ALEFix<CR>

" statusline========================
"" Clear the gutter color
highlight clear SignColumn

function! StatusLine(current)
  return (a:current ? crystalline#mode() . '%#Crystalline#' : '%#CrystallineInactive#')
        \ . ' %f%h%w%m%r '
        \ . (a:current ? '%#CrystallineFill# %{fugitive#head()} ' : '')
        \ . '%=' . (a:current ? '%#Crystalline# %{&paste?"PASTE ":""}%{&spell?"SPELL ":""}' . crystalline#mode_color() : '')
        \ . ' %{&ft}[%{&enc}][%{&ffs}] %l/%L %c%V %P '
endfunction

function! TabLine()
  let l:vimlabel = has("nvim") ?  " NVIM " : " VIM "
  return crystalline#bufferline(2, len(l:vimlabel), 1) . '%=%#CrystallineTab# ' . l:vimlabel
endfunction

let g:crystalline_statusline_fn = 'StatusLine'
let g:crystalline_tabline_fn = 'TabLine'
let g:crystalline_theme = 'onedark'

" set showtabline=2
set guioptions-=e
set laststatus=2

"" Colorscheme config
let g:onedark_termcolors=16
colorscheme onedark
" ====================Plugin Configs

" highlight if over the 90 char limit
" highlight ColorColumn ctermbg=magenta
" call matchadd('ColorColumn', '\%91v', 100)

" Fzf keybindings
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>f :FZF<CR>
nnoremap <leader>m :MRU<CR>
nnoremap <leader>t :Tags<CR>

" Fugitive keybindings
nnoremap gb :Gblame<CR>

" Write with sudo
cmap w!! w !sudo tee > /dev/null %

" Jump to last edited position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
