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
set undodir=~/.vim/undodir
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
call plug#begin('~/.vim/plugged')

" gruvbox fork supposed to fix haskell highlighting problem
Plug 'dkasak/gruvbox'
Plug 'dense-analysis/ale'
Plug 'vim-utils/vim-man'
Plug 'lyuts/vim-rtags'
Plug 'mbbill/undotree'
Plug 'tpope/vim-fugitive'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdtree' |
      \ Plug 'Xuyuanp/nerdtree-git-plugin'
" vim-prettier echoes the current line on :write on the commit following this one:
"   4dfd561 Merge pull request #279 from yzia2000/273-fix-tsx-ft
" TODO - signal the issue
Plug 'neovimhaskell/haskell-vim'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'nvie/vim-flake8'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'machakann/vim-swap',
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neovimhaskell/haskell-vim'

call plug#end()

" Colorscheme
let g:gruvbox_contrast_dark = 'medium'
colorscheme gruvbox

" Lua modules
lua require("guimauve")

" ALE configuration
let g:airline#extensions#tabline#enabled = 1
let g:ale_fixers = {
      \ 'javascript': ['eslint', 'prettier'],
      \ 'typescript': ['eslint', 'prettier'],
      \ 'typescriptreact': ['eslint', 'prettier'],
      \ 'rust': ['rustfmt'],
      \ }
let g:ale_linters = {'rust': ['analyzer']}

" Enable auto-fix on save for ESLint
let g:ale_fix_on_save = 1
let g:ale_typescript_prettier_use_local_config = 1

" Enable prettier auto-formatting on save (doesn't require '@format' mention)
let g:prettier#autoformat_require_pragma = 0

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

" Disable automatic '//' insertion when creating a new line after a single line comment in C, C++.
au FileType h,hpp,hxx,c,cpp,cxx setlocal comments-=:// comments+=f://

" Make Vim recognize *.tsx as typescriptreact files
augroup SyntaxSettings
    autocmd!
    autocmd BufNewFile,BufRead *.tsx set filetype=typescriptreact
augroup END

" Run Black on save
autocmd BufWritePre *.py execute ':silent!Black'

" Removes trailing spaces (run on save)
function TrimWhiteSpace()
  silent! %s/\s*$//
  ''
endfunction

set list listchars=trail:.,extends:>
autocmd BufWritePre * call TrimWhiteSpace()

