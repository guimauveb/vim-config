"    ____      _ __        _
"   /  _/___  (_) /__   __(_)___ ___
"   / // __ \/ / __/ | / / / __ `__ \
" _/ // / / / / /__| |/ / / / / / / /
"/___/_/ /_/_/\__(_)___/_/_/ /_/ /_/

" Core settings
set encoding=utf-8
set termguicolors
" TODO - create a .vimrc for each project that will be read by exrc
set exrc
set relativenumber
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set backspace=indent,eol,start
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile
set incsearch
set smartcase
set shortmess=a
set scrolloff=8
set updatetime=50
" Status line
set laststatus=2
set noshowmode
" Term color
set t_Co=256
set background=dark
set mouse=a

syntax on
filetype plugin indent on
highlight ColorColumn ctermbg=0 guibg=lightgrey

" Plugins
call plug#begin('~/.config/nvim/plugged')

" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" Automatically install language servers
Plug 'williamboman/nvim-lsp-installer'

" Completion framework
Plug 'hrsh7th/nvim-compe'

" Snippet engine
"Plug 'hrsh7th/vim-vsnip'

" Fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" Colorscheme
Plug 'gruvbox-community/gruvbox'

Plug 'vim-utils/vim-man'
Plug 'lyuts/vim-rtags'

Plug 'mbbill/undotree'

" Git helper
Plug 'tpope/vim-fugitive'

" Colorschemes for pretty much all languages
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdtree' |
      \ Plug 'Xuyuanp/nerdtree-git-plugin'

" Language specific
Plug 'rust-lang/rust.vim'
Plug 'neovimhaskell/haskell-vim'

Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'nvie/vim-flake8'

Plug 'machakann/vim-swap',
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim'

" Custom status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'


call plug#end()

" Colorscheme
let g:gruvbox_contrast_dark = 'medium'
colorscheme gruvbox

" Lua modules
lua require("guimauve")

" Python highlighting
let g:python_version_2                          = 0
let b:python_version_2                          = 0
let g:python_highlight_builtins                 = 1
let g:python_highlight_builtin_objs             = 1
let g:python_highlight_builtin_types            = 1
let g:python_highlight_builtin_funcs            = 1
let g:python_highlight_builtin_funcs_kwarg      = 1
let g:python_highlight_exceptions               = 1
let g:python_highlight_string_formatting        = 1
let g:python_highlight_string_format            = 1
let g:python_highlight_string_templates         = 1
let g:python_highlight_indent_errors            = 1
let g:python_highlight_space_errors             = 0
let g:python_highlight_doctests                 = 1
let g:python_highlight_func_calls               = 1
let g:python_highlight_class_vars               = 1
let g:python_highlight_operators                = 1
let g:python_highlight_file_headers_as_comments = 0

" C++ highlighting
let g:cpp_attributes_highlight  = 1
let g:cpp_member_highlight      = 1

" Haskell
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

let g:haskell_indent_if = 3
let g:haskell_indent_case = 2
let g:haskell_indent_let = 4
let g:haskell_indent_where = 6
let g:haskell_indent_before_where = 2
let g:haskell_indent_after_bare_where = 2
let g:haskell_indent_do = 3
let g:haskell_indent_in = 1
let g:haskell_indent_guard = 2

let mapleader = " "
nmap <silent> <C-D> :NERDTreeToggle<CR>

nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gs :G<CR>

" Set AWS .config files to be interpreted as YAML files (which they are)
au BufNewFile,BufRead,BufReadPost *.config setlocal syntax=yaml

" Format Rust code on save
let g:rustfmt_autosave = 1

" Disable automatic '//' insertion when creating a new line after a single line comment.
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

" Make Vim recognize *.tsx as typescriptreact files
augroup SyntaxSettings
    autocmd!
    autocmd BufNewFile,BufRead *.tsx set filetype=typescriptreact
augroup END

" Removes trailing spaces (run on save)
" function TrimWhiteSpace()
"   silent! %s/\s*$//
"   ''
" endfunction

set list listchars=trail:.,extends:>
