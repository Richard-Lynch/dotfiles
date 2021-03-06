":? list shortcus
":pc preview close
"ctrl-a increment number

source ~/.vim/settings-syntastic.vim
"pretty sure pathogen isnt working
execute pathogen#infect()
call pathogen#helptags() " Load the help tags for all plugins

syntax on
filetype plugin indent on

" fixes issue where esc + arrow will display letters etc
set nocp

"---CtrlP----
"this runtime makes ctrlp work
set runtimepath^=~/.vim/bundle/ctrlp.vim
"maps
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_show_hidden = 1

set tags=./tags;

"colorscheme distinguished
"autocmd BufEnter * colorscheme default
"autocmd BufEnter *.php colorscheme Tomorrow-Night
"autocmd BufEnter *.py colorscheme Tomorrow


"----VimCompeltesMe----
"use ctags -R in root of project to link tags, then use <C-]> to go to tag
set encoding=utf-8

"----NERDtree----
"Toggle nerd
map <C-n> :NERDTreeToggle<CR>

augroup nerdGroup
    au!
    "start nerd when opened with no file
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    
    "close auto
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END
let NERDTreeQuitOnOpen = 1
"arrows
"let g:NERDTreeDirArrowExpandable = '>'
"let g:NERDTreeDirArrowCollapsible = '!'
let NERDTreeMinimalUI = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeShowHidden=1
let NERDTreeDirArrows = 1

"----Tabs------
"next tab
"map  <C-l> :tabn<CR>
"map  <C-h> :tabp<CR>
"map  <A-n> :tabnew<CR>


"Information on the following setting can be found with
":help set
set tabstop=4
set expandtab
set autoindent 
set smartindent
set shiftwidth=4  "this is the level of autoindent, adjust to taste
set number
set relativenumber
set backspace=indent,eol,start
set visualbell
" Uncomment below to make screen not flash on error
set vb t_vb=""
set laststatus=2
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set ignorecase      "ignore case
set smartcase       "dont ignore upper case

set wildmenu        "show visual cmd options
set wildmode=list:longest,full
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

set cursorline	" highlight current active line
"add some more memory etc
set hidden
set history=1000

"reload buff after 500ms cursorhold
set autoread
set updatetime=500
augroup curs
    au!
    au CursorHold * silent! checktime
augroup END
"set mouse=a

" Move normally between wrapped lines
nmap j gj
nmap k gk

" Enable folding - dont really use, pain in the a
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
"nnoremap <space> za

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set nobackup		" keep a backup file (restore to previous version)
  set nowritebackup	" overwrite file
  set undofile		" keep an undo file (undo changes after closing)
  
  "set where to store backups
  set backupdir=~/.vim/.backups//
  "set where to store swap files
  set dir=~/.vim/.swaps//
  "set where to store undo files
  set undodir=~/.vim/.undo//
endif

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif

fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun
call SetupCommandAlias("W","w")
call SetupCommandAlias("Q","q")
call SetupCommandAlias("Wq","wq")
call SetupCommandAlias("WQ","wq")

"-----maps-----
let mapleader=" "
"space + r refreshes vimrc
map <Leader>r :source /home13/rlynch79/.vimrc<CR>:nohlsearch<CR>

"nnoremap <silent> <Leader>v :NERDTreeFind<CR>

"map <Leader>q :qa<CR>:!tk
map <Leader>s :call CurtineIncSw()<CR>

"s wap to nerdtree with space + w

"map <leader>w :<C-L>w w<CR>

"cancel a search with escape - breaks everything
"nnoremap <silent> <Esc> :nohlsearch<CR>

"reopen last closed file by pressing space space
nnoremap <Leader><Leader> :e#<CR>
" appends ; at end of line
nnoremap <Leader>: m`A;<Esc>``
" prepends //
"nnoremap <Leader>c m`0i//<Esc>``
"nnoremap <Leader>C :s/\/\///<CR>

" Commenting blocks of code.
augroup filestypes_comments
autocmd!
    autocmd FileType c,cpp,java,scala       let b:comment_leader = '// '
    autocmd FileType sh,ruby,python,tmux,make    let b:comment_leader = '# '
    autocmd FileType conf,fstab             let b:comment_leader = '# '
    autocmd FileType tex                    let b:comment_leader = '% '
    autocmd FileType mail                   let b:comment_leader = '> '
    autocmd FileType vim                    let b:comment_leader = '" '
augroup END
"   (remap) (set_mark) (search for comment at start of line) (search for start of line) (clear search) (move back to mark) (correct offset) 
noremap <Leader>c m`:s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>``ll
noremap <Leader>C m`:s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>``hh
vnoremap <Leader>c m`:s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>gv
vnoremap <Leader>C m`:s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>gv

" Tabbling blocks of code. 
" let b:tab_leader = '    '
" was <Leader><Tab>
vnoremap < <gv
vnoremap > >gv
" noremap > m`:s/^/<C-R>=escape(b:tab_leader,'\/')<CR>/<CR>:nohlsearch<CR>``llll
" noremap < m`:s/^\V<C-R>=escape(b:tab_leader,'\/')<CR>//e<CR>:nohlsearch<CR>``hhhh
" vnoremap > m`:s/^/<C-R>=escape(b:tab_leader,'\/')<CR>/<CR>:nohlsearch<CR>``llllgv
" vnoremap < m`:s/^\V<C-R>=escape(b:tab_leader,'\/')<CR>//e<CR>:nohlsearch<CR>``hhhhgv

" function Comment()
""    if (&filetype =='python')
"    let b:comment_leader = '#'
""        nnoremap <Leader>c m`0ib:comment_leader<Esc>``i
"    nnoremap <Leader>c :s/^/\=escape(b:comment_leader, '\/')/<CR>:noh<CR>
"    nnoremap <Leader>C :s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:noh<CR>
""        :s/V<C-R>=escape(b:comment_leader, '\/')<CR>//<CR>:noh<CR>
""        nnoremap <Leader>c :s/^\(\)
""    elseif (&filetype == 'c' || &filetype == 'cpp')
""        nnoremap <Leader>c m`0i//<Esc>``
""        nnoremap <Leader>C :s/\/\///<CR>
"    endif
"endfunction
"autocmd BufNewFile,BufRead * :call Comment()

":'<,'>s/foo/bar/g replaces foo with bar in current selection
"
"
nnoremap <Leader>d :DiffOrig<CR>
nnoremap <Leader>D :diffoff!<CR>:on<CR>

"insert brackets/quotes around word
nnoremap <Leader>" bi"<Esc>ea"<Esc>
nnoremap <Leader>' bi'<Esc>ea'<Esc>
nnoremap <Leader>{ bi{<Esc>ea}<Esc>
nnoremap <Leader>[ bi[<Esc>ea]<Esc>
nnoremap <Leader>( bi(<Esc>ea)<Esc>

"insert brackets/quotes around selection
vnoremap <Leader>" di"<Esc>pli"<Esc>
vnoremap <Leader>' di'<Esc>pli'<Esc>
vnoremap <Leader>{ di{<Esc>pli}<Esc>
vnoremap <Leader>[ di[<Esc>pli]<Esc>
vnoremap <Leader>( di(<Esc>pli)<Esc>

"save and quit fast
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>W :wq<CR>

" remap top and botton of screen to start and end of line
nnoremap H ^
nnoremap L $

"remap command line option
nnoremap ; :

"CTRL+L cancel highlight and redraw screen
nnoremap <C-l> :nohl<CR><C-l>

" Copy to buffer
" noremap <Leader>y :.w! ~/.vimbuffer<CR>
" noremap <Leader>p :.w! ~/.vimbuffer<CR>
" Past from buffer
" noremap <Leader>p :r ~/.vimbuffer<CR>
"set clipboard=unnamedplus
"
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

"show matching parenthesis
set showmatch
set matchtime=10        "time to flash matching

set termguicolors

colorscheme wwdc16
set t_ut=       "diable background color erase

"When editing a file, make screen display the name of the file you are editing
"function! SetTitle()
"  if $TERM =~ "^screen"
"      let l:title = 'vi: ' . expand('%:t')
"
"          if (l:title != 'vi: __Tag_List__')
"                let l:truncTitle = strpart(l:title, 0, 15)
"                      silent exe '!echo -e -n "\033k' . l:truncTitle .
"                      '\033\\"'
"                          endif
"                            endif
"                            endfunction
"
"                            " Run it every time we change buffers
"                            autocmd BufEnter,BufFilePost * call SetTitle()
"
"
"au BufNewFile,BufRead *.py
"    \ set tabstop=4
"    \ set softtabstop=4
"    \ set shiftwidth=4
"    \ set textwidth=79
"    \ set expandtab
"    \ set autoindent
"    \ set fileformat=unix
