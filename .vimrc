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
set clipboard^=unnamedplus

" タブ入力を複数の空白入力に置き換える
set expandtab
" 画面上でタブ文字が占める幅
set tabstop=4
" 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set softtabstop=4
" 改行時に前の行のインデントを継続する
set autoindent
" 改行時に前の行の構文をチェックし次の行のインデントを増減する
set smartindent
" smartindentで増減する幅
set shiftwidth=4

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
source $VIMRUNTIME/macros/matchit.vim

" tabによるコマンドモードの補完
set wildmenu
" 保存するコマンド履歴の数  "
set history=5000

" .swpファイルを作らない
set noswapfile

" マウスホイールによるスクロールを有効にする
set mouse=a

" ################################################################# "
"  dein plugin manager
" ################################################################# "

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

" ################################################################# "
"  setting for plugins
" ################################################################# "

"色を付ける
syntax on
colorscheme molokai

