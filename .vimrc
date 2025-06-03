" ################################################################# "
"  General
" ################################################################# "

" 参考:
"   https://qiita.com/kooooooooooooooooohe/items/fb106e0a0f0969b4ee38
set encoding=utf-8
scriptencoding utf-8
" 上記はマルチバイト文字を使う前に宣言する
"   set encoding: vimの内部文字コード
"   scriptencoding: vimスクリプト内で使用する文字コード

" 常にステータスラインを表示する
set laststatus=2

" 保存時の文字コード
set fileencoding=utf-8
" 読み込み時の文字コードの自動判別、左側が優先される
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
" 改行コードの自動判別、左側が優先される
set fileformats=unix,dos,mac
" □や○文字が崩れる問題を解決
set ambiwidth=double
" 行番号の表示
set number
" insertモードでもバックスペースが効くようにする
set backspace=indent,eol,start
"クリップボードにコピーする ("+y)
if system('uname -s') == "Darwin\n"
  " MAC
  set clipboard=unnamed "OSX
elseif system('uname -s') == "Linux\n"
  if system('uname -r') =~ "microsoft"
    " WSL + Windows Terminal
    " 特に設定しなくても、ctrl+shift+c、ctrl+shift+vでコピペできる
  else
    " Linux
    set clipboard=unnamedplus
  endif
endif


" カーソルキーのFix
set nocompatible

" インデントの設定
" Reference
"   https://stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim
filetype plugin indent on " ファイルタイプ検出、ファイルタイププラグイン、インデントプラグイン有効化
set tabstop=4     " タブを4スペースに変換(vimデフォルトは8)
set shiftwidth=4  " インデントの見た目のスペース数を4に設定
set expandtab     " Tabキーで4スペースを挿入

" インクリメンタルサーチ
"set incsearch
" 検索パターンに大文字小文字を区別しない
set ignorecase
" 検索パターンに大文字を含んでいたら大文字小文字を区別する
set smartcase
" 検索結果をハイライト"
set hlsearch

" ノーマルモードでESC ESCでハイライトを消す
nnoremap <ESC><ESC> :nohl<CR>

" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-

" カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set whichwrap=b,s,h,l,<,>,[,],~

" カーソルラインをハイライト"
set cursorline

" 前回編集時のカーソル位置記憶
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END

" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

" tagsジャンプの時に複数ある時は一覧表示
"nnoremap <C-]> g<C-]>
"nnoremap <C-h> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>
"nnoremap <C-k> :split<CR> :exe("tjump ".expand('<cword>'))<CR>

" GNU global (gtags)
" Gtagsのインデックスファイル内をgrep
map <C-g> :Gtags -g <C-r><C-w><CR>
" そのCファイルの関数一覧
map <C-l> :Gtags -f %<CR>
" 関数名の一部からの関数一覧
map <C-c> :Gtags -c %<CR>
" カーソル以下の定義を探す
map <C-j> :Gtags <C-r><C-w><CR>
" カーソル以下のコール元を探す
map <C-k> :Gtags -r <C-r><C-w><CR>
" 次の検索結果
map <C-n> :cn<CR>
" 前の検索結果
map <C-p> :cp<CR>
" フォーカスがあたっていないウィンドウを閉じる
map <C-x> <ESC><C-w><C-w><C-w>q

" 括弧の対応関係を一瞬表示する
set showmatch
" "shift + %"で<div class="aa"> ... </div>みたいなタグでも飛べるように拡張する
if filereadable("$VIMRUNTIME/macros/matchit.vim")
    source $VIMRUNTIME/macros/matchit.vim
endif

" tabによるコマンドモードの補完
set wildmenu
" 保存するコマンド履歴の数  "
set history=5000

" .swpファイルを作らない
set noswapfile

" マウスホイールによるスクロールを有効にする
if has('mouse')
    set mouse=a
endif


" ################################################################# "
"  dein plugin manager for Vim 8
" ################################################################# "

if v:version >= 800
  " dein.vimインストール時に指定したディレクトリをセット
  let s:dein_dir = expand('~/.cache/dein')
  
  " dein.vimの実体があるディレクトリをセット
  let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
  
  " dein.vim がなければ github から落としてくる
  if &runtimepath !~# '/dein.vim'
      if !isdirectory(s:dein_repo_dir)
          execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
      endif
      execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
  endif
  
  " 設定開始
  if dein#load_state(s:dein_dir)
      call dein#begin(s:dein_dir)
  
      " プラグインリストを収めた TOML ファイル
      " 予め TOML ファイル（後述）を用意しておく
      let g:rc_dir    = expand('~/.vim/')
      let s:toml      = g:rc_dir . '/dein.toml'
      let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
  
      " TOML を読み込み、キャッシュしておく
      call dein#load_toml(s:toml,      {'lazy': 0})
      call dein#load_toml(s:lazy_toml, {'lazy': 1})
  
      " 設定終了
      call dein#end()
      call dein#save_state()
  endif
  
  " もし、未インストールものものがあったらインストール
  if dein#check_install()
      call dein#install()
  endif

  "色を付ける
  syntax on
  colorscheme molokai

" ################################################################# "
"  dein plugin manager for Vim 7.4
" ################################################################# "

elseif v:version >= 704

  let s:vimdir = $HOME . '/.cache'
  if has('vim_starting')
    if ! isdirectory(s:vimdir)
      call system('mkdir ' . s:vimdir)
    endif
  endif

  let s:dein_enabled  = 0
  let s:git = system('which git')
  if strlen(s:git) != 0
    " Set dein paths
    let s:dein_dir = s:vimdir . '/dein'
    let s:git_server = 'github.com'
    let s:dein_repo_name = 'Shougo/dein.vim'
    let s:dein_repo = 'https://' . s:git_server . '/' . s:dein_repo_name
    let s:dein_github = s:dein_dir . '/repos/' . s:git_server
    let s:dein_repo_dir = s:dein_github . '/' . s:dein_repo_name

    " Check dein has been installed or not.
    if !isdirectory(s:dein_repo_dir)
      let s:is_clone = confirm('Prepare dein?', 'Yes\nNo', 2)
      if s:is_clone == 1
        let s:dein_enabled = 1
        echo 'dein is not installed, install now '
        echo 'git clone ' . s:dein_repo . ' ' . s:dein_repo_dir
        call system('git clone ' . s:dein_repo . ' ' . s:dein_repo_dir)
        if v:version == 704
          call system('cd ' . s:dein_repo_dir . ' && git checkout -b 1.5 1.5' )
        endif
      endif
    else
      let s:dein_enabled = 1
    endif
  endif

  if s:dein_enabled
    " Plugins or settings related to dein
    let &runtimepath = &runtimepath . ',' . s:dein_repo_dir
    let g:dein#install_process_timeout =  600
  
    " 設定開始
    if dein#load_state(s:dein_dir)
        call dein#begin(s:dein_dir)
    
        " プラグインリストを収めた TOML ファイル
        " 予め TOML ファイル（後述）を用意しておく
        let g:rc_dir    = expand('~/.vim/')
        let s:toml      = g:rc_dir . '/dein.toml'
        let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
    
        " TOML を読み込み、キャッシュしておく
        call dein#load_toml(s:toml,      {'lazy': 0})
        call dein#load_toml(s:lazy_toml, {'lazy': 1})
    
        " 設定終了
        call dein#end()
        call dein#save_state()
    endif
    
    " もし、未インストールものものがあったらインストール
    if dein#check_install()
        call dein#install()
    endif

    "色を付ける
    syntax on
    colorscheme molokai
  endif
endif

" ################################################################# "
"  setting for plugins
" ################################################################# "


" Background Transparency for Alacritty on mac osx using vim
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE

" shift+vの選択範囲を明るく見やすくする (for ChromeOS)
highlight Visual cterm=NONE ctermbg=237 ctermfg=NONE
