au BufWrite * :Autoformat   " autoformat files on save (install pep8 in terminal for python and for js install js-beautify)



set nocompatible
syntax on

set showcmd
set shortmess+=I
set number
set relativenumber
set laststatus=2
set backspace=indent,eol,start
set hidden
set ignorecase
set smartcase
set incsearch
set hls		" highlight search

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
set mouse+=a

" Try to prevent bad habits like using the arrow keys for movement.
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>

" opening a new window split down/right
set splitbelow
set splitright

" map leader key to space (default was \)
let mapleader = " "

" switching between split windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


" organise all swap files in one place, note since swap files are not in same directory of file, it will not warn if a file is already open in other buffer
set directory^=$HOME/.vim/temp//


" ---- Plugins -----

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'	" for git
Plug 'tpope/vim-commentary'	" for commenting a line or block
Plug 'tpope/vim-obsession'	" storing vim sessions
Plug 'preservim/nerdtree'	" file explorer
Plug 'jeetsukumaran/vim-buffergator'	" buffers explorer
Plug 'morhetz/gruvbox'		" gruvbox theme
Plug 'ctrlpvim/ctrlp.vim'	" file, buffer finder
Plug 'vim-airline/vim-airline'	" statusline theme
Plug 'vim-airline/vim-airline-themes'	" statusline theme
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-python'
Plug 'davidhalter/jedi-vim'
Plug 'Chiel92/vim-autoformat'
Plug 'mLaursen/vim-react-snippets'
Plug 'airblade/vim-gitgutter'
Plug 'mattn/emmet-vim'
Plug 'dense-analysis/ale'




" Initialize plugin system
call plug#end()


" vim-commentary
autocmd FileType apache setlocal commentstring=#\ %s	" for supporting multiple languages

" vim-obsession- adding to statusline
set statusline+=%{ObsessionStatus()}


"nerdtree remap
nnoremap <Leader>n : NERDTreeToggle<CR>


"buffergator
let g:buffergator_suppress_keymaps = 1
nnoremap <Leader>b :BuffergatorToggle<CR>


"gruvbox
autocmd vimenter * colorscheme gruvbox
set background=dark
let g:gruvbox_bold=1
let g:gruvbox_contrast_dark = 'hard'


" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_show_hidden = 1


"airline
let g:airline#extensions#tabline#enabled = 1
" let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
" let g:airline_right_sep = '◀'



"-----------ale

let g:ale_linters = {'python3' : ['flake8', 'pydocstyle', 'bandit', 'mypy', 'autopep8']}
" let g:ale_fixers = {'*': [], 'python':['black', 'isort']}
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace', 'add_blank_lines_for_python_control_statements', 'reorder-python-imports'], 'python3': ['black', 'isort', 'autopep8', 'yapf']}
let b:ale_fixers = {'javascript': ['prettier',]}





"coc
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<Tab>" :
			\ coc#refresh()


" coc config
let g:coc_global_extensions = [
			\ 'coc-snippets',
			\ 'coc-pairs',
			\ 'coc-prettier',
			\ 'coc-tsserver',
			\ 'coc-json',
			\ 'coc-eslint',
			\ ]

" coc snippets   - press enter to select a suggestion whether a snippet or keyword , use tab to navigate
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() :
			\"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"



" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" for running python code in current buffer
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>




" to avoid commenting when moving to a new line with o/O from a commented line
au FileType * set fo-=c fo-=r fo-=o

