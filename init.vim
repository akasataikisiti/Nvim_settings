"#####表示設定##############
set number "行番号を設定する
"set title "編集中のファイル名を表示する
set showmatch "『』入力時の対応する括弧を表示
set shiftwidth=2 "自動シフトの幅"
set expandtab "タブのスペース展開"
set tabstop=2 "インデントをスペース４つ分に設定

"########swpファイル、バックアップファイル、undoファイルを出力させない。
set noswapfile
set nobackup
set noundofile
"##########検索設定############
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set hlsearch  "マッチ箇所をハイライト
"##########環境設定################
set vb t_vb=  "ビープ音ならないようにする"

"##########wildmenuを有効にする（同じ階層のファイルを開く時tab選択ができるようになる。）
set wildmenu
"##########本読んで追加#########
" <Leader>evの向いている先はvimとneovimで変えているので注意
nnoremap <Leader>ev :e ~/.config/nvim/init.vim
nnoremap <Leader>cv :e ~/dotfiles/cheatsheets/vim.txt
nnoremap <Leader>m  :MRU
"#####垂直分割差分比較
nnoremap :vd :vertical diffsplit

"####レジスタ使用しない削除機能
nnoremap <leader>d "_d
nnoremap x "_x

"########ウィンドウ操作マッピング
map sh <C-w>h
map sk <C-w>k
map sj <C-w>j
map sl <C-w>l
map sr <C-w>r
map sR <C-w>R
map so <C-w><C-o>
"水平分割を垂直分割に直す
map sH <c-w>t<c-w>H
"垂直分割を水平分割に直す
map sK <c-w>t<c-w>K
map <Space> <C-w>w
nmap s+ <C-w>+
nmap s- <C-w>-
nmap s> <C-w>>
nmap s< <C-w><
"カーソル下のファイルを開く
"縦割り
nmap sf :vertical wincmd f<CR> <c-w>r
"新規タブ
nmap sF <c-w>gf
"Moving text
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
"vim-airlineタブの移動
nnoremap :bp :bprevious<CR>
nnoremap :bn :bnext<CR>
"垂直分割での差分比較キーマップ
nnoremap :vd :vertical diffsplit
"ターミナルを垂直分割で開くショートカット
nnoremap :vt :vert ter
"###Tagbarの呪文をキーマッピング
nnoremap <Leader>t  :TagbarOpenAutoClose<CR>
nnoremap <Leader>T  :echo tagbar#currenttag('[%s]', 'No tags')<CR>
"###UndoTree呼び出し、閉じる
nnoremap <F5>  :UndotreeToggle<cr>
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
Plug 'jiangmiao/auto-pairs'
Plug 'honza/vim-snippets'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'skanehira/vsession'
Plug 'tpope/vim-fugitive'
Plug 'vimwiki/vimwiki'
Plug 'skanehira/translate.vim'
Plug 'vim-scripts/ScrollColors'
Plug 'flazz/vim-colorschemes'
Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'} "vscodeのliveserver的なもの 
Plug 'https://github.com/adelarsq/vim-matchit'
Plug 'vim-jp/vimdoc-ja'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'thinca/vim-prettyprint'
Plug 'thinca/vim-quickrun'
Plug 'nekowasabi/nvimdoc-ja'
if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/defx.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'kristijanhusak/defx-icons'
Plug 'ryanoasis/vim-devicons'
"#onlynvim
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-telescope/telescope-project.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
"#onlynvim
" Plug 'vim-vdebug/vdebug'
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
      \, 'coc-solargraph'
      \, 'coc-python'
      \, 'coc-snippets'
      \, 'coc-vetur'
      \ ]
"#######UltiSnipsのスニペットファイル置き場の定義
let g:UltiSnipsSnippetsDir=expand("$HOME/dotfiles/.vim/UltiSnips")
"########UltiSnipsの起動とリスト表示
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-l>"
let g:UltiSnipsEditSplit="vertical"
"######vim-closetagをphpファイルでも有効にする。
let g:closetag_filenames = '*.html,*.php'
"######vim-airlineの設定
let g:airline#extensions#tabline#enabled = 1 " タブラインを表示
"######カレントウィンドウを新規タブで開きなおす
  nnoremap :tt :tab ba
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
nnoremap <leader>gl :Git log
nnoremap <leader>gcl :Gclog
nnoremap <leader>gb :Gblame

"#####vimwikiを正常動作させるのに必要らしい
set nocompatible
filetype plugin on
syntax on
"####coc-nvim(coc-prettier)でprettierを使用する。為の記述
command! -nargs=0 Prettier :CocCommand prettier.formatFile
"###nvimでskanehira/vsessionを動かすためにfzfと連携させる記述
let g:vsession_use_fzf = 1
"###fzf-checkoutの設定
let g:fzf_command_prefix = 'Fzf'
let g:fzf_checkout_git_options = '--sort=-committerdate'
"terminalモードを使いやすく
:tnoremap <c-[> <C-\><C-n>
command! -nargs=* Ut split | wincmd j | resize 20 | terminal <args>
autocmd TermOpen * startinsert

"nvimにてcoc.nvimとかが出したpopupwindowのスクロール用
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

"treesitter用の設定
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {
      'lua',
    }
  },
  indent = {
    enable = true, -- これを設定することでtree-sitterによるインデントを有効にできます
  }
}
EOF
"######カラースキーム反映に必要
set t_Co=256
"#####カラースキーム追加
set background=dark
colorscheme hybrid

"####hop.nvim使うのに必要
lua<<EOF
require'hop'.setup()
EOF

nnoremap ;c :HopChar1<CR>
nnoremap ;l :HopLine<CR>

"vdebug用
" let g:vdebug_options= {
" \    "port" : 9000,
" \    "server" : '',
" \    "timeout" : 20,
" \    "on_close" : 'detach',
" \    "break_on_open" : 1,
" \    "ide_key" : '',
" \    "path_maps" : {},
" \    "debug_window_level" : 0,
" \    "debug_file_level" : 0,
" \    "debug_file" : "",
" \    "watch_window_style" : 'expanded',
" \    "marker_default" : '⬦',
" \    "marker_closed_tree" : '▸',
" \    "marker_open_tree" : '▾'
" \}
" let g:vdebug_options['path_maps'] = {"/": "/mnt/d/work/NucleusCMS"}
