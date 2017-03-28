source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

" цветовая схема и шрифт
colo twilight
set number
set guifont=Courier_New:h10:cRUSSIAN:qDRAFT

" VUNDLE
set nocompatible              " required
filetype off                  " required

set rtp+=$HOME/vimfiles/bundle/Vundle.vim/
call vundle#begin('$HOME/vimfiles/bundle/')

Plugin 'gmarik/Vundle.vim'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set langmenu=en_US
let $LANG = 'en_US'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

set wildmenu
set wcm=<Tab>
menu Encoding.windows-1251  :set encoding=cp1251<CR>
menu Encoding.utf-8         :set encoding=utf8 <CR>
map <F8> :emenu Encoding.<TAB>
map <F2> :NERDTreeToggle<CR>

"autopen NERDTree and focus cursor in new document
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
let g:NERDTreeWinPos = "right"
cd C:/_WWWORK
"=====================================================
" General settings
"=====================================================
set backspace=indent,eol,start
aunmenu Help.
aunmenu Window.
let no_buffers_menu=1
set mousemodel=popup

set ruler
set completeopt-=preview
set gcr=a:blinkon0
if has("gui_running")
  set cursorline
endif
"set ttyfas

tab sball
set switchbuf=useopen

" clipboard
set clipboard=unnamedplus
set paste
set go+=a

" отключаем пищалку и мигание
set visualbell t_vb= 
set novisualbell       

set enc=utf-8	     " utf-8 по дефолту в файлах
set ls=2             " всегда показываем статусбар
set ignorecase
set smartcase
set incsearch	     " инкреминтируемый поиск
set hlsearch	     " подсветка результатов поиска
set nu	             " показывать номера строк
set scrolloff=5	     " 5 строк при скролле за раз

" отключаем бэкапы и своп-файлы
set nobackup 	     " no backup files
set nowritebackup    " only in case you don't want a backup file while editing
set noswapfile 	     " no swap files

" прячем панельки
"set guioptions-=m   " меню
set guioptions-=T    " тулбар
"set guioptions-=r   "  скроллбары

" настройка на Tab
set smarttab
set tabstop=8

"  при переходе за границу в 80 символов в Ruby/Python/js/C/C++ подсвечиваем на темном фоне текст
augroup vimrc_autocmds
    autocmd!
    autocmd FileType ruby,python,javascript,c,cpp highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType ruby,python,javascript,c,cpp match Excess /\%80v.*/
    autocmd FileType ruby,python,javascript,c,cpp set nowrap ts=4 sts=4 sw=4 expandtab smarttab list 
    	let g:jsx_ext_required = 0
augroup END

" указываем каталог с настройками SnipMate
let g:snippets_dir = "~/.vim/vim-snippets/snippets"

" настройки Vim-Airline
set laststatus=2
let g:airline_theme='dark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endi

set encoding=utf-8

autocmd FileType python nnoremap <buffer> <F5> :exec '!python' shellescape(@%, 1)<cr>

" Pathogen
call pathogen#infect()
"execute pathogen#infect()
call pathogen#helptags() " generate helptags for everything in ‘runtimepath’
syntax on
filetype plugin indent on
