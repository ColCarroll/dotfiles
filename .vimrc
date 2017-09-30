""
"" Basic Setup
""
set nocompatible      " Use vim, no vi defaults
filetype off

" Setup Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'ctrlpvim/ctrlp.vim'               " Fuzzy file search
Plugin 'vim-airline/vim-airline'          " Pretty bar on the bottom
Plugin 'vim-airline/vim-airline-themes'
Plugin 'mileszs/ack.vim'                  " ctrl+F to search
Plugin 'w0rp/ale'                         " Python linting
Plugin 'Raimondi/delimitMate'             " Automate matching delimiters
Plugin 'jmcantrell/vim-virtualenv'

call vundle#end()
filetype plugin indent on
autocmd BufRead,BufNewFile *.es6 setfiletype javascript

" End Vundle setup

set number            " Show line numbers
set ruler             " Show line and column number
set t_Co=256          " 256 colors!
syntax enable         " Turn on syntax highlighting allowing local overrides
set background=dark
set encoding=utf-8    " Set default encoding to UTF-8
set autoindent

""
"" netrw
""
let g:netrw_banner = 0 " netrw file explorer does not need a banner
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4 " open new files in old window
let g:netrw_altv = 1
let g:netrw_winsize = 15
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :Vexplore
augroup END

""
"" Whitespace
""

autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
set nowrap                        " don't wrap lines
set tabstop=4                   " a tab is two spaces
set shiftwidth=4                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set list                          " Show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode
autocmd BufWritePre *.py :%s/\s\+$//e " deletes whitespace on save

if exists("g:enable_mvim_shift_arrow")
  let macvim_hig_shift_movement = 1 " mvim shift-arrow-keys
endif

" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
                                  " off and the line continues beyond the left of the screen

""
"" Searching
""
set hlsearch    " highlight matches
set incsearch   " incremental searching

""
"" Wild settings
""

" set wildmode=list:longest,list:full

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem

" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" Ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*

" Ignore rails temporary asset caches
set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*

" Disable temp and backup files
set wildignore+=*.swp,*~,._*

""
"" Backup and swap files
""

set backupdir^=~/.vim/_backup//    " where to put backup files.
set directory^=~/.vim/_temp//      " where to put swap files.

""
"" CtrlP settings
""

" Ignore gitignored files
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

""
"" Powerline settings
""

let g:Powerline_symbols = 'fancy'

""
"" Use ag for code search
""

let g:ackprg = 'ag --vimgrep'
nmap <C-F> :Ack<space>

""
"" Set up automatic linter
""

let g:ale_lint_delay = 3000
let g:ale_python_pylint_executable = 'python -m pylint'


""
"" Highlight over 100 characters long
""

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%100v.\+/
