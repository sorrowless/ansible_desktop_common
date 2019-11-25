set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'junegunn/fzf'
Plugin 'pbogut/fzf-mru.vim'
" Open NerdTree by C-n
Plugin 'scrooloose/nerdtree'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'scrooloose/syntastic'
Plugin 'christoomey/vim-system-copy'
Plugin 'Yggdroot/indentLine'
Plugin 'tpope/vim-fugitive'
Plugin 'junegunn/gv.vim'
Plugin 'roxma/vim-paste-easy'
" To be able to transcode ansible inline-vault
Plugin 'rm-you/vim-vault-inline'
" Python suggestions for function names
Plugin 'davidhalter/jedi-vim'
" Tab autocompletion
Plugin 'ervandew/supertab'
" Easy comment with gC
Plugin 'tomtom/tcomment_vim'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'aserebryakov/vim-todo-lists'
Plugin 'MicahElliott/Rocannon'
Plugin 'dhruvasagar/vim-zoom'
nmap ,v :VaultEncryptionToggle<CR>

call vundle#end()            " required
filetype plugin indent on    " required

" IndentLine plugin settings
let g:indentLine_char = '▏'
let g:indentLine_setConceal = 0
let g:indentLine_concealcursor = 'c'

" Status line settings
set laststatus=2                             " Disable by default
set statusline=
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " filename
set statusline+=%h%m%r%w                     " status flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type
set statusline+=%=                           " right align remainder
set statusline+=0x%-8B                       " character value
set statusline+=%-14(%l,%c%V%)               " line, character
set statusline+=%<%P
set statusline+=\ %{zoom#statusline()}         " zoom status

" NerdTree plugin settings
map <C-n> :NERDTreeToggle<CR>

" NerdTree syntax highlight
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

" syntastic plugin settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_loc_list_height = 3
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_auto_jump = 2


" fzf plugin settings
map <C-p> :FZF<cr>

" jedi-vim plugin settings
let g:jedi#use_tabs_not_buffers = 1  " allow use tabs for goto jumps
autocmd FileType python setlocal completeopt-=preview

" No compatible with vi
"set nocompatible

" help with backspace
set backspace=indent,eol,start

" Use spaces instead of tabs
set expandtab

" 1 tab == 4 spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2

" Be smart when using tabs ;)
set smarttab

" Wrap lines explicitly
"set wrap
" and set a newline after 80 characters
"set tw=80
" and linebreak only at characters in breakat
"set linebreak

set autoindent " ai - Auto indent - copy indentation from previous line
set smartindent " si - Smart indent - insert one more indent in some cases

set encoding=utf-8

set ruler

" Search like in browsers
set incsearch

" Highlight search results
set hlsearch

" Ignore case when searching
set ignorecase

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

set wildmenu
set wildmode=longest:full

" Show current mode
set showmode

" Show current typed command
set showcmd

" Set to auto read when a file is changed from the outside
set autoread

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

syntax on " highlight syntax
"colorscheme desert
" PaperColor theme settings
let backtime = system('date +%H')
if backtime > 17 || backtime < 8
  set background=dark
else
  set background=light
endif
let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default.dark': {
  \       'transparent_background': 1,
  \       'allow_bold': 1,
  \     },
  \     'default.light': {
  \       'transparent_background': 1,
  \       'allow_bold': 1,
  \     }
  \   }
  \ }

"filetype on
filetype plugin on
filetype indent on

imap ii <Esc>

" Delete trailing white space on save, useful for Python and Puppet
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.pp :call DeleteTrailingWS()

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" That's amazin feature to enable BOTH number and relativenumber. Also it
" automagically set relative to absolute when lost focus to other tab. Got
" this from https://jeffkreeftmeijer.com/vim-number/
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Show current cursor position
set cursorline

" Remember cursor position
augroup resCur
  autocmd!
  autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END

" Keep some lines when scrolling
set scrolloff=5

set foldenable " включить фолдинг
"set foldmethod=syntax " определять блоки на основе синтаксиса файла
set foldmethod=indent " определять блоки на основе отступов
"set foldcolumn=3 " показать полосу для управления сворачиванием
set foldlevel=1 " Первый уровень вложенности открыт, остальные закрыты
"set foldopen=all " автоматическое открытие сверток при заходе в них

" Auto remove trailing spaces
autocmd BufWritePre * :%s/\s\+$//e

" highlight symbols after 80
set t_Co=256
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
highlight OverLength ctermbg=239 ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" add line that show you 80 chars border
set colorcolumn=80
" it will work only if your terminal supports 256 colors properly
highlight ColorColumn ctermbg=233

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving and quit
nmap <leader>w :w!<cr>

" Fast quit
nmap <leader>q :q!<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Syntasic warnings hide
nmap <leader>l :lclose<cr>

" set W to be 'sudo w'
command! W :execute ':silent w !sudo tee % > /dev/null' | :edit!

" Wq is ok
command! Wq wq

" Show EOL chars
set list
"set listchars=eol:↵
set listchars=tab:▸\ ,eol:¬
" highlight eol char
highlight NonText ctermfg=236

" Indent on bounds of tabstops
set shiftround

" Use non-default diff algorithms
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic

" Disable Rocannon Ansible color scheme
let g:rocannon_bypass_colorscheme = 1

colorscheme PaperColor

" tabs-related hotkeys
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>
nnoremap <silent> <Esc>h :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <Esc>l :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>
