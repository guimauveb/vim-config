"default settings
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

set colorcolumn=116
highlight ColorColumn ctermbg=0 guibg=lightgrey
" hi MatchParen cterm=bold ctermbg=blue guibg=lightblue


"plugins
call plug#begin('~/.vim/plugged')

"Plug 'morhetz/gruvbox'
" fork supposed to fix haskell highlighting problem
Plug 'dkasak/gruvbox'
Plug 'jremmen/vim-ripgrep'
Plug 'vim-utils/vim-man'
Plug 'dense-analysis/ale'
Plug 'bfrg/vim-cpp-modern'
Plug 'lyuts/vim-rtags'
Plug 'mbbill/undotree'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'tpope/vim-fugitive'
Plug 'neovimhaskell/haskell-vim'
Plug 'vim-python/python-syntax'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'
Plug 'maxmellon/vim-jsx-pretty'

call plug#end()

set runtimepath^=~/.vim/bundle/ctrlp.vim

"term color
set t_Co=256
set background=dark

"colorscheme
let g:gruvbox_contrast_dark = 'medium' 
colorscheme gruvbox

"status line
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

" set AWS .config files to be interpreted as YAML files (which they are)
au BufNewFile,BufRead,BufReadPost *.config setlocal syntax=yaml

" set Haskell file to use 2 spaces wide tab
au BufNewFile,BufRead,BufReadPost *.hs setlocal shiftwidth=2 softtabstop=2 expandtab

" Disable automatic '//' insertion when creating a new line after a single line comment in C, C++, JS, TS.
au FileType h,hpp,hxx,c,cpp,cxx,js,ts setlocal comments-=:// comments+=f://

" Formatters
au FileType javascript setlocal formatprg=prettier
au FileType javascript.jsx setlocal formatprg=prettier
au FileType typescript setlocal formatprg=prettier\ --parser\ typescript
au FileType html setlocal formatprg=js-beautify\ --type\ html
au FileType scss setlocal formatprg=prettier\ --parser\ css
au FileType css setlocal formatprg=prettier\ --parser\ css

" C++ highlighting
let g:cpp_attributes_highlight  = 1
let g:cpp_member_highlight      = 1

" Haskell highlighting
let g:stylish_haskell_command = "~/.vim/plugged/vim-stylish-haskell/ftplugin/haskell/stylish-haskell.vim"

let g:haskell_enable_quantification             = 1 " to enable highlighting of `forall`
let g:haskell_enable_recursivedo                = 1 " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax                = 1 " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms           = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles                  = 1 " to enable highlighting of type roles
let g:haskell_enable_static_pointers            = 1 " to enable highlighting of `static`
let g:haskell_backpack                          = 1 " to enable highlighting of backpack keywords
let g:haskell_classic_highlighting              = 1

let g:haskell_indent_if                         = 3
let g:haskell_indent_case                       = 2
let g:haskell_indent_let                        = 4
let g:haskell_indent_where                      = 6
let g:haskell_indent_before_where               = 2
let g:haskell_indent_after_bare_where           = 2
let g:haskell_indent_do                         = 3
let g:haskell_indent_in                         = 1
let g:haskell_indent_guard                      = 2

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
let g:python_highlight_file_headers_as_comments	= 0

" Colorful style for jsx files
let g:vim_jsx_pretty_colorful_config = 1

" Mapped keys
nmap <silent> <C-D> :NERDTreeToggle<CR>


