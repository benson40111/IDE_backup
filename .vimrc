set nocompatible              " 去除VI一致性,必須
filetype off                  " 必須

" 設置包括vundle和初始化相關的runtime path
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" 另一種選擇, 指定一個vundle安裝插件的路徑
"call vundle#begin('~/some/path/here')

" 讓vundle管理插件版本,必須
Plugin 'VundleVim/Vundle.vim'

" 以下範例用來支持不同格式的插件安裝.
" 請將安裝插件的命令放在vundle#begin和vundle#end之間.
" Github上的插件
" 格式為 Plugin '用戶名/插件倉庫名'
Plugin 'tpope/vim-fugitive'
" 來自 http://vim-scripts.org/vim/scripts.html 的插件
" Plugin '插件名稱' 實際上是 Plugin 'vim-scripts/插件倉庫名' 只是此處的用戶名可以省略
Plugin 'L9'
" 由Git支持但不再github上的插件倉庫 Plugin 'git clone 後面的地址'
Plugin 'git://git.wincent.com/command-t.git'
" 正確指定路徑用以設置runtimepath. 以下範例插件在sparkup/vim目錄下
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'bling/vim-airline'
Plugin 'edkolev/promptline.vim'
Plugin 'molokai'
Plugin 'davidhalter/jedi-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Valloric/YouCompleteMe'
Plugin 'edkolev/tmuxline.vim'
" 你的所有插件需要在下面這行之前
call vundle#end()            " 必須
filetype plugin indent on    " 必須 加載vim自帶和插件相應的語法和文件類型相關腳本
" 忽視插件改變縮進,可以使用以下替代:
"filetype plugin on
"
" 簡要幫助文檔
" :PluginList       - 列出所有已配置的插件
" :PluginInstall    - 安裝插件,追加 `!` 用以更新或使用 :PluginUpdate
" :PluginSearch foo - 搜索 foo ; 追加 `!` 清除本地緩存
" :PluginClean      - 清除未使用插件,需要確認; 追加 `!` 自動批准移除未使用插件
"
" 查閱 :h vundle 獲取更多細節和wiki以及FAQ
" 將你自己對非插件片段放在這行之後
"
"UI_Setting
set tabstop=4
set shiftwidth=4
set history=1000
set backspace=2
set laststatus=2
set mouse=a
set number
"Vim_Encoding_Setting
set encoding=utf-8  
set termencoding=utf-8
"Vim_Env_Setting
set showmatch
set cursorline
syntax on
"Vim_Colorscheme
colorscheme molokai
set t_Co=256
hi Normal  ctermfg=252 ctermbg=None
"Func_Python_Env
function! s:python_custom()
    let python_highlight_all = 1
	function! s:man(keyword)
       		execute '!pydoc ' . a:keyword
     	endfunction
        command! -nargs=1 Man call s:man()
        cnoremap K :!pydoc 
	setlocal omnifunc=jedi#completions
   function! s:pypy_run()
       execute 'w '
       execute 'w' '!python3 % ' 'cw'
       execute 'cw '
   endfunction
  command! C call s:pypy_run() 
  map <F5> :C<CR>

endfunction
"jedi_setting
set completeopt=longest,menuone
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_on_dot = 0 
"Check_FileType
if has("autocmd")
	autocmd Filetype python call s:python_custom()
endif
"YoucompleteME
let g:ycm_complete_in_comments=1
let g:ycm_confirm_extra_conf=0
let g:ycm_collect_identifiers_from_tags_files=1
inoremap <leader>; <C-x><C-o>
set completeopt-=preview
let g:ycm_min_num_of_chars_for_completion=1
let g:ycm_cache_omnifunc=0
let g:ycm_seed_identifiers_with_syntax=1
"airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'powerlineish'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#syntastic#enabled = 1
let g:promptline_preset = {
        \'a' : [ promptline#slices#user() ],
        \'b' : [ promptline#slices#cwd() ],
        \'c' : [ promptline#slices#vcs_branch()]}
let g:airline_section_a = airline#section#create([''])
let g:airline_section_b = airline#section#create(['MisakaVim'])
let g:airline_section_c = airline#section#create(['%f','(','filetype',')'])
let g:airline_section_x = airline#section#create(['ffenc'])
let g:airline_section_y = airline#section#create([''])
let g:airline_section_z = airline#section#create_right(['Line:%l','Row:%c'])
set nofoldenable
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['pyflakes']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
"IndentGuides
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
nmap <F4> <Plug>IndentGuidesToggle
nmap <F3> :NERDTreeToggle <CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&b:NERDTreeType == "primary") | q | endif
