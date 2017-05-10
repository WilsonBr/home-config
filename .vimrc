" --------------------------- VUNDLE
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'xolox/vim-misc.git'
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround.git'
Plugin 'bkad/CamelCaseMotion.git'
Plugin 'ctrlpvim/ctrlp.vim.git'
Plugin 'tomasr/molokai.git'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdcommenter.git'
Plugin 'epeli/slimux.git'
Plugin 'scrooloose/syntastic.git'
Plugin 'vim-scripts/taglist.vim.git'
Plugin 'nacitar/terminalkeys.vim.git'
Plugin 'xolox/vim-easytags.git'
Plugin 'tpope/vim-endwise.git'
Plugin 'tpope/vim-eunuch.git'
Plugin 'terryma/vim-expand-region.git'
Plugin 'drmikehenry/vim-fixkey.git'
Plugin 'tpope/vim-git.git'
Plugin 'airblade/vim-gitgutter.git'
Plugin 'michaeljsmith/vim-indent-object.git'
Plugin 'kurkale6ka/vim-pairs.git'
Plugin 'tpope/vim-repeat.git'
Plugin 'tpope/vim-rails'
Plugin 'vim-ruby/vim-ruby'
Plugin 'honza/vim-snippets.git'
Plugin 'bling/vim-airline'
Plugin 'majutsushi/tagbar'
Plugin 'edkolev/tmuxline.vim'
Plugin 'justinmk/vim-syntax-extra.git'
Plugin 'vim-scripts/matchit.zip.git'
Plugin 'pangloss/vim-javascript'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'othree/html5-syntax.vim'
Plugin 'othree/html5.vim'
Plugin 'moll/vim-node'

" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

Plugin 'jiangmiao/auto-pairs.git'

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

" ---------------------------------------------------- WILSON
" --- Leader
" swap backslash with comma (used as <Leader> key in shortcuts)
let mapleader=','
noremap \ ,

" --- Buffer
set hidden " lets you switch buffers without saving
set nostartofline " preserves cursor when switching

" switch to adjacent buffer in current window
nnoremap <C-PageUp> :bprev<Return>
nnoremap <C-PageDown> :bnext<Return>

" close current buffer while retaining window
nnoremap <Leader>$ :execute 'bnext<Bar>bdelete' bufnr('%')<Return>

" reload current buffer while discarding changes
nnoremap <Leader>7 :edit!<Return>

" --- Motion
" retain relative cursor position when paging
nnoremap <PageUp> <C-U>
nnoremap <PageDown> <C-D>

" store relative line number jumps in jumplist
" while treating wrapped lines like real lines
" but don't do this if going up/down by 1 line
" NOTE: m' stores current position in jumplist
" NOTE: thanks to osse and bairui in #vim IRC!
nnoremap <silent> k :<C-U>execute 'normal!' (v:count > 1 ? "m'".v:count.'k' : 'gk')<Return>
nnoremap <silent> j :<C-U>execute 'normal!' (v:count > 1 ? "m'".v:count.'j' : 'gj')<Return>

" apply these tricks to up and down arrow keys
nmap <Up> k
nmap <Down> j

" --- Clipboard
" copy to primary selection
noremap <Leader>y "*y

" copy to clipboard selection
noremap <Leader>Y "+y

" paste from primary selection
noremap <Leader>p "*p

" paste from clipboard selection
noremap <Leader>P "+p

" be consistent with C and D which reach the end of line
nnoremap Y y$

" --- Color
" delegate colorscheme configuration to config/color/<colorscheme>.vim files
autocmd ColorScheme * execute 'runtime config/color/'. g:colors_name .'.vim'


if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" --- Command
set shell=/bin/sh " use Bourne shell for command substitution
set history=9999  " remember this many commands & searches
set confirm       " ask user before aborting an action
set wildmenu      " tab-completion menu for command mode
set wildmode=list:longest,full

" accept common typing mistakes caused by the Shift key
cnoreabbrev QA qa
cnoreabbrev Qa qa
cnoreabbrev qA qa
cnoreabbrev WQ wq
cnoreabbrev Wq wq
cnoreabbrev wQ wq

" I'm so used to typing in "man" to look up documentation
cnoreabbrev man help

"--- Complete
" enable i_CTRL-X_CTRL-O completion using syntax highlighting definitions
set omnifunc=syntaxcomplete#Complete

" --- Diff
nnoremap <Leader>dq :diffoff<Return>
nnoremap <Leader>du :diffupdate<Return>
nnoremap <Leader>dt :diffthis<Return>
nnoremap <Leader>dT :DiffOrig<Return>
nnoremap <Leader>dl :diffget //2<Bar>diffupdate<Return>
nnoremap <Leader>dr :diffget //3<Bar>diffupdate<Return>

"--- Fold
set foldenable
set foldmethod=indent " indentation defines folds
set foldlevelstart=99 " close folds below this depth, initially

" go to adjacent folds
nnoremap <C-Up> zk
nnoremap <C-Down> zj
nnoremap <C-Left> [[
nnoremap <C-Right> ]]

" open and close folds
nnoremap <A-Down> zo
nnoremap <A-S-Down> zO
nnoremap <A-Up> zc
nnoremap <A-S-Up> zC

" change the foldlevel
nnoremap <A-Left> zm
nnoremap <A-S-Left> zM
nnoremap <A-Right> zr
nnoremap <A-S-Right> zR

" close all folds and then open current fold just enough to reveal cursor
nnoremap <Leader>z zM zv

" --- Format
set autoindent       " automatically indent new lines
set formatoptions+=o " continue comment marker in new lines
set textwidth=0     " hard-wrap long lines as you type them
set tabstop=8        " render TABs using this many spaces
set expandtab        " insert spaces when TAB is pressed
set softtabstop=2    " ... this many spaces
set shiftwidth=2     " indentation amount for < and > commands

" - Use 4 spaces indent for python
autocmd Filetype python setlocal ts=4 sw=4 sts=0 expandtab

" repeat last character to the maximum width of current line
nnoremap <Leader>i. :execute 's/.$/'. repeat('&', &textwidth+1) .'/'<Return>
      \:execute 's/\%>'. &textwidth .'v.//g'<Return>

" insert or update section separator at end of current line
nmap <Leader>i- A-<Esc><Leader>i.

" format current line as a top-level heading in markdown (uses `z marker)
nmap <Leader>i1 mzyypVr=:.+1g/^=\+/d<Return>`z

" format current line as a second-level heading in markdown (uses `z marker)
nmap <Leader>i2 mzyypVr-:.+1g/^-\+/d<Return>`z

" --- GUI
set guicursor+=a:blinkwait0 " disable cursor blink in gvim
set guioptions-=r           " disable right scrollbar
set guioptions-=L           " disable left scrollbar
set guifont=Tamzen\ 11,Tamsyn\ 11,Monospace\ 9

" --- Quit
nnoremap <C-Q> :qa<Return>

" --- RXVT
" masquerade rxvt as xterm so that arrow keys work correctly in insert mode
if &term =~ 'rxvt'
  execute 'set term=' . substitute(&term, '\vrxvt(-unicode)?', 'xterm', '')
endif

" --- Save
set nobackup writebackup " backup current file, deleted afterwards

" remove trailing spaces before saving text files
" http://vim.wikia.com/wiki/Remove_trailing_spaces
autocmd BufWritePre * :call StripTrailingWhitespace()
function! StripTrailingWhitespace()
  if !&binary && &filetype != 'diff'
    let l:cursor = winsaveview()
    if &filetype == 'mail'
      " preserve space after e-mail signature separator
      silent g/\(^--\)\@<!\s\+$/s///
    else
      silent g/\s\+$/s///
    endif
    call winrestview(l:cursor)
  endif
endfunction

nnoremap <C-S> :write<Return>
"nnoremap <C-S-S> :saveas<Space>

" --- Scroll
nnoremap <C-Left> zh
nnoremap <C-Right> zl
nnoremap <S-C-Left> zH
nnoremap <S-C-Right> zL

" --- Search
set hlsearch   " highlight search results
set ignorecase " make searching case insensitive
set smartcase  " ... unless the query has capital letters

" make <C-L> (redraw screen) also turn off
" search highlighting until the next search
" http://vim.wikia.com/wiki/Example_vimrc
nnoremap <C-L> :nohlsearch<Return><C-L>

" find merge conflict markers
nnoremap <Leader>c/ /\v^[<=>]{7}( <Bar>$)/<Return>

" --- Toggle
nnoremap <Leader>t/ :setlocal hlsearch!<Return>
nnoremap <Leader>tl :setlocal list!<Return>
nnoremap <Leader>tn :setlocal number!<Return>
nnoremap <Leader>tN :setlocal relativenumber!<Return>
nnoremap <Leader>tp :setlocal paste!<Return>
nnoremap <Leader>ts :setlocal spell!<Return>
nnoremap <Leader>tz :setlocal foldenable!<Return>
nnoremap <Leader>tc :setlocal cursorline!<Return>
nnoremap <Leader>tC :setlocal cursorcolumn!<Return>

" disable "2 spaces equals 1 tab" indentation style
nnoremap <Leader>t<Tab> :setlocal noexpandtab softtabstop=8 shiftwidth=8<Return>

" --- UI
set number                     " show line numbers
set relativenumber             " ... relative to cursor
set novisualbell               " don't flash the screen
set laststatus=2               " always show status line
set list                       " display otherwise invisible characters
set listchars=tab:\\_,extends:>,precedes:<,nbsp:%
set fillchars=vert:│,fold:\    " nicer VertSplit and fold-line characters
set timeout timeoutlen=500     " allow fast o/u press after ESC in insert mode
set ttimeout ttimeoutlen=50

" --- Visual
" visually select the text that was last edited or pasted
nnoremap gV `[v`]

" visually select a search result
nnoremap g/ //e<Return>v??<Return>

" --- Window
set splitright " focus new window after vertical splitting
set splitbelow " focus new window after horizontal splitting

" focus adjacent window
nnoremap <A-PageUp> <C-W>W
nnoremap <A-PageDown> <C-W>w

" split current window
nnoremap <Leader>2 <C-W>s
nnoremap <Leader>3 <C-W>v

" collapse other windows
nnoremap <Leader>0 <C-W><Bar><C-W>_

" all windows equal size
nnoremap <Leader>9 <C-W>=
" ... also on vim resize
autocmd VimResized * execute "normal \<C-W>=\<C-L>"

" close other windows
nnoremap <Leader>1 <C-W>o

" close current window
nnoremap <Leader>4 <C-W>c

" Save current buffer using [ctrl-s]
:inoremap <c-s> <Esc>:Update<CR>
:inoremap <c-s> <c-o>:Update<CR>
:map <leader>c :bd<CR>

" Expand the current buffer path when '%%' is typed on command mode
cabbr <expr> %% expand('%:p:h')

" Backspace behavior
set backspace=indent,eol,start

" Open CtrlP search box on buffer mode
let g:ctrlp_cmd = 'CtrlPBuffer'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = { 'dir':  '\v[\/](\.git|node_modules|tmp)$' }

" terminals that I typically use have a dark background color
syntax on
let g:solarized_termcolors=256
set t_Co=256
"set background=dark
set background=light
colorscheme solarized

let g:rehash256 = 1
set cursorline
:hi MatchParen ctermbg=blue guibg=lightblue

"set colorcolumn=0

set nobackup
set noswapfile

"vim airline settings
let g:airline_powerline_fonts = 1
let g:airline_theme='molokai'
set encoding=utf-8

nmap <F8> :TagbarToggle<CR>

" Use html filetype for .vur files
au BufNewFile,BufRead *.vue set filetype=html

