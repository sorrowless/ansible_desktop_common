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

" Open files faster with C-f
Plugin 'junegunn/fzf'
" Open previously opened files faster with C-p
Plugin 'pbogut/fzf-mru.vim'
" Open NerdTree by C-n
Plugin 'scrooloose/nerdtree'
" Syntax highlight in nerdtree
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
"Syntax checking for some file types
Plugin 'scrooloose/syntastic'
" Copy to clipboard by pressing cp and paste by presssing cv
" Example - press cpi' to copy text inside '' quotes
Plugin 'christoomey/vim-system-copy'
" Enable indentation by <Leader>ig
Plugin 'nathanaelkane/vim-indent-guides'
" Work with git easier
Plugin 'tpope/vim-fugitive'
" Work with git history. Really helps, can be used only with git-fugitive
" Call by <Leader>g
Plugin 'junegunn/gv.vim'
" Set paste automatically
Plugin 'roxma/vim-paste-easy'
" Python suggestions for function names
Plugin 'davidhalter/jedi-vim'
" Tab autocompletion
Plugin 'ervandew/supertab'
" Easy comment with gc. Select lines and run gc, or type gcc on current line
Plugin 'tomtom/tcomment_vim'
" Theme I personally prefer
Plugin 'NLKNguyen/papercolor-theme'
" Easy creation of todo lists
Plugin 'aserebryakov/vim-todo-lists'
" Highlight yank
Plugin 'machakann/vim-highlightedyank'
" EasyMotion
Plugin 'easymotion/vim-easymotion'
" Better git merge conflicts handling
Plugin 'samoshkin/vim-mergetool'
" Prettify yaml
Plugin 'prettier/vim-prettier'
let g:prettier#config#bracket_spacing = 'false'
let g:prettier#config#print_width = '160'

" Highlight duration
let g:highlightedyank_highlight_duration = 1000

call vundle#end()            " required
filetype plugin indent on    " required

" EasyMotion config
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
map s <Plug>(easymotion-sl)

" samoshkin/vim-mergetool configuration
let g:mergetool_layout = 'mr'
let g:mergetool_prefer_revision = 'local'

" vim gv plugin config
nmap <Leader>g :GV!<cr>

" Vim indent guides plugin settings
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=232
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=233

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

" NerdTree plugin settings
map <C-n> :NERDTreeToggle<CR>

" NerdTree syntax highlight
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeShowHidden=1

" Let user netrw from time to time
" Look at https://shapeshed.com/vim-netrw/ to see useful settings
map <C-o> :Vexplore<CR>
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 3
let g:netrw_winsize = 20
let g:netrw_altv = 1

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
map <C-f> :FZF<cr>
" fzf-mru plugin settings
map <C-p> :FZFMru<cr>

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
" let backtime = system('date +%H')
" if backtime > 17 || backtime < 8
"   set background=dark
" else
"   set background=light
" endif
set background=dark
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
" set diffopt+=algorithm:patience
" set diffopt+=indent-heuristic

" Disable Rocannon Ansible color scheme
let g:rocannon_bypass_colorscheme = 1

colorscheme PaperColor

" tabs-related hotkeys
noremap <C-h> :tabprevious<CR>
noremap <C-l> :tabnext<CR>
inoremap <C-h> <Esc>:tabprevious<CR>
inoremap <C-l> <Esc>:tabnext<CR>
nnoremap <silent> <Esc>h :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <Esc>l :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

" map space to fold
nnoremap <space> za
vnoremap <space> zf

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif
