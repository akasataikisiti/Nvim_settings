"#####表示設定##############
set number "行番号を設定する
"set title "編集中のファイル名を表示する
set showmatch "『』入力時の対応する括弧を表示
set shiftwidth=2 "自動シフトの幅"
set expandtab "タブのスペース展開"
set tabstop=2 "インデントをスペース２つ分に設定

set cursorline
:highlight Cursorline cterm=bold ctermbg=black "カーソル位置見やすく
set nowrap "折り返さない
" set inccommand=split
set inccommand=nosplit
"python2無効
let g:loaded_python_provider = 0

" nodeのパスを通す(brew使用してnをインストールしてそのうえにnodeをインストールした)
let g:node_host_prog = "/usr/local/lib/node_modules/neovim/bin/cli.js"
syntax enable
"########swpファイル、バックアップファイル、undoファイルを出力させない。
set noswapfile
set nobackup
set noundofile
"######diffで空白の違いを無視
set diffopt=iwhite
"##########検索設定############
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set hlsearch  "マッチ箇所をハイライト
"##########環境設定################
"下にあらたに変えてみた問題無かったらそれで行く
" set vb t_vb=  "ビープ音ならないようにする"
set belloff=all
"マウス使えるようにする
set mouse=a

"##########wildmenuを有効にする（同じ階層のファイルを開く時tab選択ができるようになる。）
"よくわからんけど要らない気がするからコメントアウトする
" set wildmenu
"##########本読んで追加#########
" <Leader>evの向いている先はvimとneovimで変えているので注意
nnoremap <Leader>ev :e ~/.config/nvim/init.vim
nnoremap <Leader>cv :e ~/cheatsheets/vim.txt
nnoremap <Leader>m  :MRU
"#####垂直分割差分比較
nnoremap :vd :vertical diffsplit

"####レジスタ使用しない削除機能
vnoremap <leader>d "_d
nnoremap <leader>d "_d
nnoremap <leader>D "_D
nnoremap x "_x

"########ウィンドウ操作マッピング
map sh <C-w>h
map sk <C-w>k
map sj <C-w>j
map sl <C-w>l
map sr <C-w>r
map sR <C-w>R
map so <C-w><C-o>
"カーソル下のウィンドウを次のウィンドウと交換
map so <C-w><C-x>
"水平分割を垂直分割に直す
map sH <c-w>t<c-w>H
"垂直分割を水平分割に直す
map sK <c-w>t<c-w>K
nnoremap <Space> <C-w>w
nmap s+ <C-w>+
nmap s- <C-w>-
nmap s> <C-w>>
nmap s< <C-w><
nmap s= <C-w>=
"カーソル下のファイルを開く
"縦割り
nmap sf :vertical wincmd f<CR> <c-w>r
"新規タブ
nmap sF <c-w>gf
"Moving text
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
vnoremap <C-h> "zdh"zPgvhoho
vnoremap <C-l> "zdl"zPgvlolo
"vim-airlineタブの移動
nnoremap :bp :bprevious<CR>
nnoremap :bn :bnext<CR>
"
"tabが一つだけだったら新しいタブを開く
nnoremap gt :call TabnewOrGoNext()<CR>
function! TabnewOrGoNext()
  if 1 == tabpagenr('$')
    execute ":tabedit"
  else
    execute ":tabnext"
  endif
endfunction

"垂直分割での差分比較キーマップ
nnoremap :vd :vertical diffsplit
"ターミナルを垂直分割で開くショートカット
nnoremap :vt :vert ter
"###Tagbarの呪文をキーマッピング
nnoremap <Leader>t  :TagbarOpenAutoClose<CR>
nnoremap <Leader>T  :echo tagbar#currenttag('[%s]', 'No tags')<CR>
"###UndoTree呼び出し、閉じる
nnoremap tu  :UndotreeToggle<cr>
" インサートモード中に<C-s>でセーブして改行してインサートモードに入る
imap <C-s> <C-[>:w<CR>o
"###相対行表示の切り替え
" nnoremap <F3> :<C-u>setlocal relativenumber!<CR>
"###各種拡張子ファイルが更新されたら自動でctagsファイルを更新
autocmd BufWritePost *.py,*.js silent! !ctags -R &

"HTMLタグの上のカーソル移動を効率化させる拡張スクリプトを有効化
source $VIMRUNTIME/macros/matchit.vim
"Yankした時にWindowsのクリップボードに共有。
augroup Yank
  au!
  autocmd TextYankPost * :call system('clip.exe',@")
augroup END
"ステータスラインにgithubの状態を追加
" set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P
"Yankしたものをubuntuのクリップボードと共有する。
set clipboard+=unnamed
"translatevim用の設定
let g:translate_source = "en"
let g:translate_target = "ja"
let g:translate_winsize = 10
vnoremap <F3> :Translate<CR>
vnoremap <F4> :Translate!<CR>
"タブ空白、改行の可視化
set list
set listchars=tab:>.,trail:_,eol:↲,extends:>,precedes:<,nbsp:%

"全角スペースをハイライト表示
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme       * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
    call ZenkakuSpace()
endif
"Vimhelpの日本語化
set helplang=ja,en
"##############vim-plugでプラグインを管理#############
call plug#begin()
Plug 'phaazon/hop.nvim'
Plug 'yegappan/mru'
Plug 'tpope/vim-commentary'
" Plug 'mileszs/ack.vim'
Plug 'preservim/tagbar'
Plug 'mbbill/undotree'
Plug 'neoclide/coc.nvim',{'branch': 'release'}
Plug 'alvan/vim-closetag'
Plug 'sirver/ultisnips'
Plug 'mlaursen/vim-react-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'honza/vim-snippets'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'skanehira/vsession'
Plug 'tpope/vim-fugitive'
Plug 'vimwiki/vimwiki'
Plug 'skanehira/translate.vim'
Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
Plug 'tomasr/molokai'
Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'} "vscodeのliveserver的なもの 
Plug 'https://github.com/adelarsq/vim-matchit'
Plug 'vim-jp/vimdoc-ja'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'thinca/vim-prettyprint'
Plug 'nekowasabi/nvimdoc-ja'
Plug 'ap/vim-css-color'
Plug 'Yggdroot/indentLine'
Plug 'kshenoy/vim-signature'
if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/defx.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'kristijanhusak/defx-icons'
Plug 'ryanoasis/vim-devicons'
Plug 'kristijanhusak/defx-git'
Plug 'puremourning/vimspector'

"#onlynvim
if has('nvim')
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
  Plug 'nvim-telescope/telescope-project.nvim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim'
  Plug 'fannheyward/telescope-coc.nvim'
  Plug 'karb94/neoscroll.nvim'
  "#onlynvim
  " neovim用のlua開発 -開始
  Plug 'tjdevries/nlua.nvim'
  " neovim用のlua開発 -終わり
  Plug 'skanehira/preview-uml.vim'
endif
call plug#end()

"#########ack.vimを動かさせるために以下の記述が必要だった。
" let g:ackprg = "/home/kosuke/bin/ack -s -H --nocolor --nogroup --column"

"########coc.nvimで勝手に拡張をインストールさせる。
let g:coc_global_extensions = [
      \  'coc-lists'
      \, 'coc-json'
      \, 'coc-marketplace'
      \, 'coc-html'
      \, 'coc-css'
      \, 'coc-tsserver'
      \, 'coc-snippets'
      \, 'coc-prettier'
      \ ]
"#######UltiSnipsのスニペットファイル（自作の)置き場の定義
" for Neovim
let g:UltiSnipsSnippetsDir=expand("$HOME/.config/nvim/UltiSnips")
"########UltiSnipsの起動とリスト表示
" let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-l>"
let g:UltiSnipsEditSplit="vertical"
"######vim-closetagをphpファイルでも有効にする。
let g:closetag_filenames = '*.html,*.php'
"######vim-airlineの設定
let g:airline#extensions#tabline#enabled = 1 " タブラインを表示
"######カレントウィンドウを新規タブで開きなおす
nnoremap :tt :tab ba<CR>
"vim-fugitiveのコマンド省略形
nnoremap <leader>ga :Git add %:p
nnoremap <leader>gco :Git commit
"FzfGBranchesだけfzf-checkoutの機能
nnoremap <leader>gch :FzfGBranches
nnoremap <leader>gs :Git
nnoremap <leader>gp :Git push
nnoremap <leader>gd :Gdiff
nnoremap <leader>gv :Gvdiff
"ほぼ記憶用
nnoremap <leader>gl :Git log<CR>
nnoremap <leader>gcl :Gclog<CR>
nnoremap <leader>gb :Git blame<CR>

"#####vimwikiを正常動作させるのに必要らしい(2022/06/23追記：要らないので消す。)
" set nocompatible
" filetype plugin on
" autocmd FileType *.wiki syntax enable

"####coc-nvim(coc-prettier)でprettierを使用する。為の記述
command! -nargs=0 Prettier :CocCommand prettier.formatFile
"####coc-nevimのcoc-cssをscssファイルに適用させる
autocmd FileType scss setl iskeyword+=@-@
"###nvimでskanehira/vsessionを動かすためにfzfと連携させる記述
let g:vsession_use_fzf = 1
"###fzf-checkoutの設定
let g:fzf_command_prefix = 'Fzf'
let g:fzf_checkout_git_options = '--sort=-committerdate'
"terminalモードを使いやすく
:tnoremap <c-[> <C-\><C-n>
command! -nargs=* Ut split | wincmd j | resize 20 | terminal <args>
command! -nargs=* T vsplit | wincmd l | terminal <args>
autocmd TermOpen * startinsert

"######カラースキーム反映に必要
set t_Co=256
"#####カラースキーム追加
set background=dark
" colorscheme hybrid

"####hop.nvim使うのに必要
lua<<EOF
require'hop'.setup()
EOF

nnoremap ;f :HopChar1<CR>
nnoremap ;l :HopLine<CR>

"karb94/neoscroll.nvim用
lua require('neoscroll').setup()
"vimspector用
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
