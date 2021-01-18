" Default settings
set encoding=utf-8
syntax on
filetype plugin indent on

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

set colorcolumn=116
highlight ColorColumn ctermbg=0 guibg=lightgrey

" Plugins
call plug#begin('~/.vim/plugged')

" gruvbox fork supposed to fix haskell highlighting problem
Plug 'dkasak/gruvbox'
Plug 'jremmen/vim-ripgrep'
Plug 'vim-utils/vim-man'
Plug 'dense-analysis/ale'
Plug 'lyuts/vim-rtags'
Plug 'mbbill/undotree'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'tpope/vim-fugitive'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdtree' |
      \ Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'nbouscal/vim-stylish-haskell'

call plug#end()

" Ctlrp path
set runtimepath^=~/.vim/bundle/ctrlp.vim

" Term color
set t_Co=256
set background=dark

" Colorscheme
let g:gruvbox_contrast_dark = 'medium'
colorscheme gruvbox

" Status line
set laststatus=2
set noshowmode

let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \},
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"-R":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ }
      \}

" Set AWS .config files to be interpreted as YAML files (which they are)
au BufNewFile,BufRead,BufReadPost *.config setlocal syntax=yaml

" Disable automatic '//' insertion when creating a new line after a single line comment in C, C++.
au FileType h,hpp,hxx,c,cpp,cxx setlocal comments-=:// comments+=f://

" Make Vim recognize *.tsx as typescriptreact files
augroup SyntaxSettings
    autocmd!
    autocmd BufNewFile,BufRead *.tsx set filetype=typescriptreact
augroup END

" Set ALE fixers
let g:ale_fixers = {
      \ 'javascript': ['eslint', 'prettier'],
      \ 'typescript': ['eslint', 'prettier'],
      \ 'typescriptreact': ['eslint', 'prettier'],
      \ }

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

" Open NERDTree with Ctrl+D
nmap <silent> <C-D> :NERDTreeToggle<CR>

" Run Black on save
autocmd BufWritePre *.py execute ':silent!Black'

" Removes trailing spaces (run on save)
function TrimWhiteSpace()
  silent! %s/\s*$//
  ''
endfunction

set list listchars=trail:.,extends:>
autocmd BufWritePre * call TrimWhiteSpace()

" Make sure Ctrl+P find all files
let g:ctrlp_user_command =
  \ ['.git', 'cd %s && git ls-files -co --exclude-standard']

