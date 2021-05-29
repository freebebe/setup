"------------------------------------------------------\
"--------------------vim-plug---------------------------|
"--------------------:let-------------------------------|
"------------------------------------------------------/

"================Nerdtree==================
"启动时自动打开
"autocmd vimenter * NERDTree       

"打开一个目录同时TREE打开，关闭文件时TREE自动关闭
autocmd StdinReadPre * let s:std_in=1
autocmd vimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"打开的同时链接其历史记录(open tree automatically when vim starts up on
"opening a directory)
autocmd StdinReadPre * let s:std_in=1
autocmd vimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

"close vim if the only windows left open is a nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"F2启动/关闭
map <F9> :NERDTreeToggle<CR>   

"位设
" let g:NERDTreeWinPos='right'

"行号
let g:NERDTreeShowLineNumbers=1

"================nerdcommenter=============================
let g:NERDSpaceDelims = 1			"空格
let g:NERDCompactSexyComs = 1		"简约
let g:NERDCommentEmptyLines = 1		"倒~空
let g:NERDTrimTrailingWhitespace = 1	"收尾
"let g:NERDToggleCheckAllLines = 1	"chack
"learder=\
"\-c-space 正反注释

"================wiki============================
set nocompatible            "kill-vim一致性
    filetype plugin on
    syntax on

"================goyo=============================
" :Goyo            "toggle Goyo
" :Goyo[demension]
" :Goyo!            "off
" let	go:goyo_margin_top = 2
" let	go:goyo_margin_bottom = 2

"================indentline=======================
let g:indentLine_char_list = ['|', '¦', '┆', '┊']"

"================javascript-highlight=================
let javascript_enable_domhtmlcss = 1

"================emmet-html&css->deful        (C=ctrl-)=====================
" let g:user_emmet_install_global = 0
" autocmd FileType html,css EmmetInstall      只在html,css作用  
"
" let g:user_emmet_leader_key='C-y'
" autocmd filetype *html* imap <c-_> <c-y>/
" autocmd filetype *html* map <c-_> <c-y>/
"
let g:user_emmet_expandabbr_key = '<F2>'
let g:user_emmet_leader_key= '<C-e>'
    "================emmet================
"map <F3> <C-\>

"================ctrlp=====================
" Use Silver Searcher for CtrlP plugin (if available) Fallback to git ls-files for fast listing. Because we use fast strategies, disable caching.
let g:ctrlp_use_caching = 0
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git',
    \ 'cd %s && git ls-files . -co --exclude-standard',
    \ 'find %s -type f' ]

" Make sure pasting in visual mode doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()
endif

"================ctrlp-plug-python=====================
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }


"===============YCM=====================
" let g:ycm_clangd_binary_path = 
       "~/Progm-plug/clang+llvm"
" " YCM 补全菜单配色
" " 菜单
" " highlight Pmenu ctermfg=2 ctermbg=3 guifg=#005f87 guibg=#EEE8D5
" " 选中项
" " highlight PmenuSel ctermfg=2 ctermbg=3 guifg=#AFD700 guibg=#106900
" "IDE同化
" set completeopt=longest,menu
" " 补全功能在注释中同样有效
" let g:ycm_complete_in_comments=0
" " 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示
" let g:ycm_confirm_extra_conf=0
" " 开启 YCM 标签补全引擎
" let g:ycm_collect_identifiers_from_tags_files=1
" " 引入 C++ 标准库tags
" set tags+=/data/misc/software/misc./vim/stdcpp.tags
" " YCM 集成 OmniCppComplete 补全引擎，设置其快捷键
" inoremap <leader>; <C-x><C-o>
" " 补全内容不以分割子窗口形式出现，只显示补全列表
" set completeopt-=preview
" " 从第一个键入字符就开始罗列匹配项
" let g:ycm_min_num_of_chars_for_completion=2
" " 禁止缓存匹配项，每次都重新生成匹配项
" let g:ycm_cache_omnifunc=0
" " 语法关键字补全
" let g:ycm_seed_identifiers_with_syntax=1
" " 禁用语法
" " let g:ycm_filepath_blacklist = {}
" "语法白名单
" let g:ycm_filepath_whitelist = {'html': 1, 'jsx': 1, 'xml': 1, 'css': 1}
" "电动是巴拿
" let g:ycm_auto_trigger=1
" let g:ycm_semantic_triggers = {
    " \   'css': [ 're!^', 're!^\s+', ': ' ],
    " \   'scss': [ 're!^', 're!^\s+', ': ' ],
    " \ }
        " " let g:ycm_semantic_triggers = {
        " " \'c' : ['->', '    ', '.', ' ', '(', '[', '&'],
        " " \'cpp,objcpp' : ['->', '.', ' ', '(', '[', '&', '::'],
        " " \'perl' : ['->', '::', ' '],
        " " \'php' : ['->', '::', '.'],
        " " \'cs,java,javascript,d,vim,python,perl6,scala,vb,elixir,go' : ['.'],
        " " \'ruby' : ['.', '::'],
        " " \'lua' : ['.', ':'],
        " " \'scss,css': [ 're!^\s{2,4}', 're!:\s+' ],
        " " \'html': ['<', '"', '</', ' '],
        " " \'javascript': ['.', 're!(?=[a-zA-Z]{3,4})'],
        " " \}
" endif

"============================vim-gitgutter
function! GitStatus()
 let [a,m,r] = GitGutterGetHunkSummary()
 return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}

"============================markdown
let g:vim_markdown_math = 0
let g:vim_markdown_auto_insert_bullets = 0

"=============================graphviz
"=============================surround
"可视模式
"-----------------------------------------------------------------------------------------------|
"|    | 命令            | 说明 + 示例                                                           |
"|---:|:----------------|:----------------------------------------------------------------------|
"|    | S               | 选中的括起来                                                          |
"| 例 | 选中world: S(   | Hello world! => Hello (world)!                                        |
"|---:|:----------------|:----------------------------------------------------------------------|
"|    | gS              | 选中的括起来，括号内文本做新一行                                      |
"| 例 | 选中world: gS{  | Hello world! => Hello { world }!                                      |
"|-----------------------------------------------------------------------------------------------|

"=============================ack
let g:ackprg = 'ag --nogroup --nocolor --column'
"let g:ackprg = 'ag --vimgrep'  (相同作用)

"=============================latex_live
let g:livepreview_previewer = 'zathura'
let g:livepreview_cursorhold_recompile = 0
let g:vimtex_fold_enabled = 1
let g:livepreview_engine = 'pdflatex'
"
"==============================auto_save
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_events = ["InsertLeave", "TextChanged"]
let g:auto_save_silent = 1

"==============================Polyglot
let g:python_highlight_all           = 1
let g:python_highlight_indent_errors = 0
let g:python_highlight_space_errors  = 0

"==============================Markdown
let g:mkdp_preview_options = {'content_editable': v:true}
let g:vim_markdown_math    = 1
nnoremap <leader>o :MarkdownPreview<CR>

"==============================Wiki
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_conceallevel = 0
let g:vimwiki_global_ext   = 0
