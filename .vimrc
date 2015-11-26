""
"" Basic Setup
""
set nocompatible      " Use vim, no vi defaults
filetype off

" Setup Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" Some javascript plugins
Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'nathanaelkane/vim-indent-guides'

Plugin 'Raimondi/delimitMate'    " Automate matching delimiters
Plugin 'scrooloose/syntastic'   " For linting
Plugin 'digitaltoad/vim-jade.git'
Plugin 'fatih/vim-go'

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

let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-" ,"trimming empty <", "is not recognized!", "discarding unexpected"]
let g:syntastic_javascript_checkers=['eslint'] " angular elements 

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
