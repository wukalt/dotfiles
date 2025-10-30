set nocompatible
filetype on
filetype plugin on
filetype indent on
syntax on
set background=dark
set number
set cursorline
set cursorcolumn
set shiftwidth=4
set tabstop=4
set history=700
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

call plug#begin('~/.vim/plugged')
  Plug 'dense-analysis/ale'

  Plug 'preservim/nerdtree'
  
  Plug 'romainl/Apprentice'

  Plug 'jiangmiao/auto-pairs'

  Plug 'vim-airline/vim-airline'

  Plug 'ryanoasis/vim-devicons'

  Plug 'davidhalter/jedi-vim'

  Plug 'rust-lang/rust.vim'

  Plug 'ervandew/supertab'
  
  Plug 'ctrlpvim/ctrlp.vim'

  Plug 'prabirshrestha/vim-lsp'

  Plug 'scheakur/vim-scheakur'

  Plug 'vim-airline/vim-airline-themes'

  Plug 'cocopon/iceberg.vim'

call plug#end()

nnoremap <leader>\ ``
nnoremap <silent> <leader>p :%w !lp<CR>
inoremap jj <Esc>
nnoremap <space> :
nnoremap o o<esc>
nnoremap O O<esc>
nnoremap n nzz
nnoremap N Nzz

nnoremap Y y$

nnoremap <f5> :w <CR>:!clear <CR>:!cargo run <CR>

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w>>
noremap <c-right> <c-w><

nnoremap <F3> :NERDTreeToggle<cr>

let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']

augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab

if version >= 703
    set undodir=~/.vim/backup
    set undofile
    set undoreload=10000
endif

augroup cursor_off
    autocmd!
    autocmd WinLeave * set nocursorline nocursorcolumn
    autocmd WinEnter * set cursorline cursorcolumn
augroup END


set statusline=
set statusline+=\ %F\ %M\ %Y\ %R
set statusline+=%=
set laststatus=2

let g:rust_clip_command = 'xclip -selection clipboard'

if executable('rust-analyzer')
  au User lsp_setup call lsp#register_server({
        \   'name': 'Rust Language Server',
        \   'cmd': {server_info->['rust-analyzer']},
        \   'whitelist': ['rust'],
        \ })
endif

let g:airline_theme='simple'
colorscheme iceberg
