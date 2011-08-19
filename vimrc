" Modeline and Notes {
"   vim: set foldmarker={,} foldlevel=0 foldmethod=marker:
"   max@neuropunks.org
" }

" Core configs {
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
    
    " ignore case unless we have explicit upper case in search string
    set ignorecase
    set smartcase
    
    set viewoptions=folds,options,cursor,unix,slash
    set virtualedit=onemore " allow for cursor beyond last character
    " set spell
    set history=1000
    " set cursorline                  " highlight current line
    set incsearch
    set gdefault                    " the /g flag on :s substitutions by default
    set foldenable                  " auto fold code
    "set scrolljump=5                " lines to scroll when cursor leaves screen
    set wildmenu                    " show list instead of just completing
    set wildmode=list:longest,full  " comand <Tab> completion, list matches, then longest common part, then all.
" }

" Setting up the directories {                                                                                                                                                                                                       
    "set backupdir=$HOME/.vimbackup//  " but not when they clog .
    "set directory=$HOME/.vimswap//  " Same for swap files
    "set viewdir=$HOME/.vimviews//   " same for view files

    "" Creating directories if they don't exist
    "silent execute '!mkdir -p $HOME/.vimbackup'
    "silent execute '!mkdir -p $HOME/.vimswap'
    "silent execute '!mkdir -p $HOME/.vimviews'
    "au BufWinLeave * silent! mkview  "make vim save view (state) (folds, cursor, etc)
    "au BufWinEnter * silent! loadview "make vim load view (state) (folds, cursor, etc)
" }

" Press Space to turn off highlighting and clear any message already displayed.
:noremap <silent> <Space> :silent noh<Bar>echo<CR>

" shift key fixes
cmap W w                                                                                                                                                                                                                             
cmap WQ wq
cmap wQ wq
cmap Q q
cmap Tabe tabe

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

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

au BufNewFile,BufRead *.yaml,*.yml so ~/.vim/syntax/yaml.vim
au BufNewFile,BufRead *.php so ~/.vim/syntax/php.vim
au BufNewFile,BufRead *.py so ~/.vim/syntax/python.vim
au FileType xhtml,xml so ~/.vim/ftplugin/html_autoclosetag.vim
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

" from @spf13 vimrc
" Plugins {
    " git/svn/cvs integration: http://www.vim.org/scripts/script.php?script_id=90
    " VCSCommand {                                                                                                                                                                                                                       
        let b:VCSCommandMapPrefix=',v'
        let b:VCSCommandVCSType='git'
        ""let mapleader = "-"
    " } 

    " php+vim http://github.com/spf13/PIV
    " PIV {                                                                                                                                                                                                                              
        let g:DisableAutoPHPFolding = 0
    " }

    " insert-model completion with tab: http://www.vim.org/scripts/script.php?script_id=182
    " Supertab {                                                                                                                                                                                                                         
        "let g:SuperTabDefaultCompletionType = "context"
        let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
    " }

    " shows location of marks: http://www.vim.org/scripts/script.php?script_id=152
    " ShowMarks {
        let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        " Don't leave on by default, use :ShowMarksOn to enable
        let g:showmarks_enable = 0
        " For marks a-z
        highlight ShowMarksHLl gui=bold guibg=LightBlue guifg=Blue
        " For marks A-Z
        highlight ShowMarksHLu gui=bold guibg=LightRed guifg=DarkRed
        " For all other marks
        highlight ShowMarksHLo gui=bold guibg=LightYellow guifg=DarkYellow
        " For multiple marks on the same line.
        highlight ShowMarksHLm gui=bold guibg=LightGreen guifg=DarkGreen
    " }

    " Ctags {                                                                                                                                                                                                                            
        " set tags=./tags;/,~/.vimtags
    " }

    " http://www.vim.org/scripts/script.php?script_id=3114
    " EasyTags {
        " let g:easytags_cmd = '/usr/local/bin/ctags'
    " }

    " provides insert mode auto-completion for quotes, parens, brackets, etc: http://github.com/Raimondi/delimitMate
    " Delimitmate {                                                                                                                                                                                                                      
        au FileType * let b:delimitMate_autoclose = 1

        " If using html auto complete (complete closing tag)
        au FileType xml,html,xhtml let b:delimitMate_matchpairs = "(:),[:],{:}"
    " }

    " auto-close html/xml tags: http://www.vim.org/scripts/script.php?script_id=2591
    " AutoCloseTag {                                                                                                                                                                                                                     
        " Make it so AutoCloseTag works for xml and xhtml files as well
        au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
    " }

    " textmate snips port: http://github.com/msanders/snipmate.vim
    " SnipMate {
        " Setting the author var                                                                                                                                                                                                         
        " let g:snips_author = ''
        " Shortcut for reloading snippets, useful when developing
        nnoremap ,smr <esc>:exec ReloadAllSnippets()<cr>
    " }

    " OmniComplete {
        "if has("autocmd") && exists("+omnifunc")
            "autocmd Filetype *
                "\if &omnifunc == "" |
                "\setlocal omnifunc=syntaxcomplete#Complete |
                "\endif
        "endif

        " Popup menu hightLight Group
        "highlight Pmenu    ctermbg=13  guibg=DarkBlue
        highlight PmenuSel  ctermbg=7   guibg=DarkBlue      guifg=LightBlue
        "highlight PmenuSbar ctermbg=7  guibg=DarkGray
        "highlight PmenuThumb           guibg=Black

        hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
        hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
        hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

        " some convenient mappings
        inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
        inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
        inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
        inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
        inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
        inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

        " automatically open and close the popup menu / preview window
        au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
        set completeopt=menu,longest,preview
    " }

    " some configs for NerdTree: http://github.com/scrooloose/nerdtree
    " and NerdCommenter: http://github.com/scrooloose/nerdcommenter.git
    " Misc {
        :map <C-F10> <Esc>:vsp<CR>:VTree<CR>
        " map Control + F10 to Vtree

        let g:checksyntax_auto = 0

        "comment out line(s) in visual mode                                                                                                                                                                                              
        vmap  o  :call NERDComment(1, 'toggle')<CR>
        let g:NERDShutUp=1

        let b:match_ignorecase = 1
    " }
" }
