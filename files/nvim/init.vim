" Is not needed anymore, NeoVim is always nocompatible
" Look at :h compatible
"set nocompatible

" Is on by default, but may be needed by some plugins. Set it to on and
" remove if needed in future
filetype on

" Neovim stores all the configs in $XDG_CONFIG_HOME/nvim, so in normal
" linux system it will be ~/.config/nvim
"
" Let's use simple snippet to autoload vim-plug manager automatically in case
" it doesn't exist on nvim start
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent !curl
    \ -fLo ${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim
    \ --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
"
" Now try to actually load all these plugins
call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'
"
" Make sure you use single quotes
" Shorthand notation; fetches https://github.com/junegunn/fzf
" Open files faster with C-f
Plug 'junegunn/fzf'
" Open previously opened files faster with C-p
Plug 'pbogut/fzf-mru.vim'
" Open NerdTree by C-n
Plug 'scrooloose/nerdtree'
"Syntax checking for some file types
Plug 'scrooloose/syntastic'
" Copy to clipboard by pressing cp and paste by presssing cv
" Example - press cpi' to copy text inside '' quotes
Plug 'christoomey/vim-system-copy'
" Enable indentation by <Leader>ig
Plug 'nathanaelkane/vim-indent-guides'
" Work with git easier
Plug 'tpope/vim-fugitive'
" Work with git history. Really helps, can be used only with git-fugitive
" Call by <Leader>g
Plug 'junegunn/gv.vim'
" Set paste automatically
Plug 'roxma/vim-paste-easy'
" Tab autocompletion
Plug 'ervandew/supertab'
" Easy comment with gc. Select lines and run gc, or type gcc on current line
Plug 'tomtom/tcomment_vim'
" Theme I personally prefer
Plug 'NLKNguyen/papercolor-theme'
" Easy creation of todo lists
Plug 'aserebryakov/vim-todo-lists'
" Highlight yank
Plug 'machakann/vim-highlightedyank'
" EasyMotion
Plug 'easymotion/vim-easymotion'
" Outline class functions
Plug 'preservim/tagbar'
" Prettify yaml
Plug 'prettier/vim-prettier'
let g:prettier#config#bracket_spacing = 'false'
let g:prettier#config#print_width = '160'
if has('nvim')
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'dense-analysis/ale'

  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'

  " For vsnip users.
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'

  " For luasnip users.
  " Plug 'L3MON4D3/LuaSnip'
  " Plug 'saadparwaiz1/cmp_luasnip'

  " For ultisnips users.
  " Plug 'SirVer/ultisnips'
  " Plug 'quangnguyen30192/cmp-nvim-ultisnips'

  " For snippy users.
  " Plug 'dcampos/nvim-snippy'
  " Plug 'dcampos/cmp-snippy'
else
  " Python suggestions for function names
  Plug 'davidhalter/jedi-vim'
  let g:jedi#use_tabs_not_buffers = 1  " allow use tabs for goto jumps
  autocmd FileType python setlocal completeopt-=preview
endif
" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting

" Ensure cursor will look like vertical split in the shell. Other way nvim
" will reformat it to be a box
set guicursor=

" Highlight duration
let g:highlightedyank_highlight_duration = 1000

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" EasyMotion config
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
map s <Plug>(easymotion-sl)

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

" Tagbar plugin settings
autocmd VimEnter *.py TagbarToggle
let g:tagbar_compact = 1
let g:tagbar_sort = 0

" Ale plugin settings
" I'm personally use python and bash, so recommend to install
" pylint, shellcheck, ansible-lint, hadolint, gitlint, markdownlint
let g:ale_sign_column_always = 1
let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰', '│', '─']

" fzf plugin settings
map <C-f> :FZF<cr>
" fzf-mru plugin settings
map <C-p> :FZFMru<cr>

" help with backspace
set backspace=indent,eol,start
set autoindent " ai - Auto indent - copy indentation from previous line
set smartindent " si - Smart indent - insert one more indent in some cases
set encoding=utf-8
set wildmenu
set wildmode=longest:full

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Use spaces instead of tabs
set expandtab

" 1 tab == 4 spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2

" Be smart when using tabs ;)
set smarttab

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

" Show current mode
set showmode

" Show current typed command
set showcmd

" Set to auto read when a file is changed from the outside
set autoread

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
set scrolloff=3

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

lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "bash", "c", "lua", "vim", "python", "markdown", "ini",  "help", "query", "yaml", "diff", "git_rebase", "gitcommit", "dockerfile" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['pylsp'].setup {
    capabilities = capabilities
  }
EOF
