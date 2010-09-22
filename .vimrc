set nocompatible
set showcmd
set expandtab
set tabstop=4
set shiftwidth=4
set background=light
set novisualbell
set noerrorbells
set ruler
set bs=indent,eol,start
set paste
set autoindent
set hlsearch
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2                        " always show the status line
set smartindent
set nobackup

set viminfo='20,\"50    " read/write a .viminfo file, don't store more
                        " than 50 lines of registers
set history=50          " keep 50 lines of command line history

" ignore case unless we have explicit upper case in search string
set ignorecase
set smartcase

" Press Space to turn off highlighting and clear any message already displayed.
:noremap <silent> <Space> :silent noh<Bar>echo<CR>

map ,p :set paste<CR>

map ,i :set autoindent<CR>

map ,t  :tabedit .<CR> 

map ,q :q!<CR>

map ,w :x<CR>

map ,pp :!php -l %<CR>

" Commenting Perl-Style
vmap  ,pc       :s/^/#<space>/<CR>:nohlsearch<CR>
vmap  ,pu       :s/^#<space>//<CR>

" Commenting SQL-Style
vmap  ,sc       :s/^/-- <space>/<CR>:nohlsearch<CR>
vmap  ,su       :s/^-- <space>//<CR>

" Commenting Lisp-Style
vmap  ,lc       :s/^/;;<space>/<CR>:nohlsearch<CR>
vmap  ,lu       :s/^;;<space>//<CR>

" C-Style
vmap  ,cc       :<esc>'<O<Tab><Left><Left>/*<esc>'>o<Tab><Left>*/<esc>gv
vmap  ,cu       :<esc>'<dd'>dd
"

" include phpdocblock
inoremap ,d     ^[:call PhpDocSingle()<CR>i
nnoremap ,d     :call PhpDocSingle()<CR>
vnoremap ,d     :call PhpDocRange()<CR>

" Map <CTRL>-H to search phpm for the function name currently under the cursor (insert mode only)
"inoremap <C-H> <ESC>:!phpm <C-R>=expand("<cword>")<CR><CR>

" The completion dictionary is provided by Rasmus:
" http://lerdorf.com/funclist.txt
setlocal dictionary-=~/.vim/funclist.txt dictionary+=~/.vim/funclist.txt
" Use the dictionary completion
setlocal complete-=k complete+=k


au BufNewFile,BufRead *.yaml,*.yml so ~/.vim/yaml.vim
au BufNewFile,BufRead *.php so ~/.vim/php-doc.vim
au BufNewFile,BufRead *.py so ~/.vim/python.vim
syntax on


" Only do this part when compiled with support for autocommands
if has("autocmd")
  " In text files, always limit the width of text to 78 characters
  autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
endif

