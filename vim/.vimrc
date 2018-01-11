set number          "set linenumbers
set paste           "makes sure that pasting things doesn't break everything

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
set smartindent

"braces, brackets, and parentheses oh my!
inoremap {<cr> {<cr>}<c-o><s-o>
inoremap [<cr> [<cr>]<c-o><s-o>
inoremap (<cr> (<cr>)<c-o><s-o>

"collapsing with space
nnoremap <space> za

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
call plug#begin('~/.vim/plugged')

" markdown previewing
Plug 'iamcco/markdown-preview.vim'

call plug#end()
" ===========================Plugins

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

" function Oneline() 
"   ggVG100<:%s/\n//g^M
" endfunc

