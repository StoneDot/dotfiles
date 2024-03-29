set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'leafgarland/typescript-vim'
Plugin 'Quramy/tsuquyomi'
Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-textobj-entire'
Plugin 'scrooloose/nerdtree'
Plugin 'sgur/vim-textobj-parameter'
Plugin 'L9'
Plugin 'FuzzyFinder'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'prettier/vim-prettier'
Plugin 'challenger-deep-theme/vim', { 'name': 'challenger-deep' }
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'junegunn/fzf', { 'rtp': 'plugin' }
Plugin 'junegunn/fzf.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'rust-lang/rust.vim'
" Plugin 'neoclide/coc.nvim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Enable package
packadd! matchit


" General setting
" True Color を有効化
if has('nvim') || has('termguicolors')
  set termguicolors
endif
" 文字コードをUFT-8に設定
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
" 見た目系
" 行番号を表示
set number
" 現在の行を強調表示
set cursorline
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" Backspaceでスペース等も消せるように
set backspace=2
" シンタックスハイライトを有効化
syntax on


" Tab系
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=2
" 行頭でのTab文字の表示幅
set shiftwidth=2


" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
" Insert Mode で Emacs風に移動できるように
imap <C-f> <Right>
imap <C-b> <Left>
" カラーテーマの設定
colorscheme challenger_deep
" Indent のカラーリング
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#191829 ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#3b3959 ctermbg=4
hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey

" NERDTree
let NERDTreeShowHidden = 1
" C-e で NERDTree へ移動
nnoremap <silent><C-e> :NERDTreeFocusToggle<CR>
" スタート時には NERDTree を表示しない
" let g:nerdtree_tabs_open_on_console_startup=1

" FuzzyFinder
let g:fuf_modesDisable = []
let g:fuf_mrufile_maxItem = 1000
let g:fuf_mrucmd_maxItem = 400
let g:fuf_mrufile_exclude = '\v\~$|\.(bak|sw[po])$|^(\/\/|\\\\|\/mnt\/)'
nnoremap <C-j>f :FufFile<CR>
nnoremap <C-j>r :FufMruFile<CR>
nnoremap <C-j>b :FufBuffer<CR>

" Mouse
if has('mouse')
  set mouse=a
  if has('mouse_sgr')
    set ttymouse=sgr
  elseif v:version > 703 || v:version is 703 && has('patch632')
    set ttymouse=sgr
  else
    set ttymouse=xterm2
  endif
endif

" Fzf
nnoremap <silent> sf :GFiles<CR>
nnoremap <silent> sF :GFiles?<CR>
nnoremap <silent> sb :Buffers<CR>
nnoremap <silent> sl :BLines<CR>
nnoremap <silent> sh :History<CR>
nnoremap <silent> sm :Mark<CR>

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif


" TypeScript
autocmd BufRead,BufNewFile *.ts set filetype=typescript

" Rust
" auto fromat
let g:rustfmt_autosave = 1

" netrw
let g:netrw_liststyle=1
let g:netrw_sizestyle="H"
let g:netrw_timefmt="%Y/%m/%d(%a) %H:%M:%S"
let g:netrw_preview=1
