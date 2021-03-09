"================nerdcommenter=============================
let g:NERDSpaceDelims = 1			          "空格
let g:NERDCompactSexyComs = 1		        "简约
let g:NERDCommentEmptyLines = 1		      "倒~空
let g:NERDTrimTrailingWhitespace = 1	  "收尾
"let g:NERDToggleCheckAllLines = 1	    "chack
"learder=\
"\-c-space 正反注释

"================goyo=============================
" :Goyo            "toggle Goyo
" :Goyo[demension]
" :Goyo!            "off
" let	go:goyo_margin_top = 2
" let	go:goyo_margin_bottom = 2



"================indentline=======================
let g:indentLine_char_list = ['|', '¦', '┆', '┊']"

"================javascript-highlight=================
" let javascript_enable_domhtmlcss = 1

"================emmet-html&css->deful        (C=ctrl-)=====================
" let g:user_emmet_install_global = 0
" autocmd FileType html,css EmmetInstall          "只在html,css作用
"
" let g:user_emmet_leader_key='C-y'
" autocmd filetype *html* imap <c-_> <c-y>/
" autocmd filetype *html* map <c-_> <c-y>/
"
let g:user_emmet_expandabbr_key = '<F2>'
let g:user_emmet_leader_key= '<C-e>'

" let g:user_emmet_mode='n'    "only enable normal mode functions.
" let g:user_emmet_mode='inv'  "enable all functions, which is equal to
" let g:user_emmet_mode='a'    "enable all function in all mode.

"map <F3> <C-\>
    "================emmet================

"============================vim-gitgutter
function! GitStatus()
 let [a,m,r] = GitGutterGetHunkSummary()
 return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}

"=============================graphviz
"=============================neomake
call neomake#configure#automake('w')            "保存校检
call neomake#configure#automake('nw', 750)      "切换到NORMAL模式，延迟750ms检查
"
"=============================MATCHU P
augroup matchup_matchparen_highlight
    autocmd!
    autocmd ColorScheme * hi MatchParen guifg=#c678dd gui=bold
    autocmd ColorScheme * hi MatchWord  guifg=#FFCB6B gui=italic
augroup END

let g:matchup_surround_enabled     = 1
let g:matchup_matchparen_deferred  = 1
let g:matchup_matchparen_offscreen = {}
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

"=============================latex {
let g:vimtex_fold_manual=1
let g:tex_flavor='latex'
    "Starting with Vim 7, the filetype of empty .tex files defaults to
    " 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
    " The following changes the default filetype back to 'tex':
let g:Tex_CustomTemplateDirectory="~/.config/nvim/gogo/laxModel/"

"=============================latex_live
let g:livepreview_previewer = 'zathura'
let g:livepreview_cursorhold_recompile = 0
let g:vimtex_fold_enabled = 1
let g:livepreview_engine = 'pdflatex'
"}
"
"==============================auto_save
let g:auto_save = 1             " enable AutoSave on Vim startup
let g:auto_save_events = ["InsertLeave", "TextChanged"]
let g:auto_save_silent = 1

"==============================Polyglot
let g:python_highlight_all           = 1
let g:python_highlight_indent_errors = 0
let g:python_highlight_space_errors  = 0

"==============================Markdown
let g:instant_markdown_slow = 1
let g:instant_markdown_autostart = 0            "':InstantMarkdownPreview' or 'InstantMarkdownStop'

"==============================Wiki
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_conceallevel = 0
let g:vimwiki_global_ext   = 0

"=========================================================
"==============================deoplete
"=========================================================
let g:deoplete#enable_at_startup = 1
" let g:deoplete#enable_smart_case = 1
    " 用户输入至少两个字符时再开始提示补全
call deoplete#custom#source('LanguageClient',
            \ 'min_pattern_length',
            \ 2)
    " 字符串中不补全
call deoplete#custom#source('_',
            \ 'disabled_syntaxes', ['String']
            \ )
    " 补全结束或离开插入模式时，关闭预览窗口
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

    ">deoplete-ternjs==========================
    let g:deoplete#sources#ternjs#types = 1
        " Whether to include the types of the completions in the result data. Default: 0
    let g:deoplete#sources#ternjs#filetypes = [
                    \ 'jsx',
                    \ 'javascript.jsx',
                    \ 'vue'
                    \ ]
    ">deoplete-Rust===========================
    let g:racer_cmd = "/home/user/.cargo/bin/racer"
    let g:racer_experimental_completer = 1
    ">deoplete-jedi==========================
    " let g:deoplete#sources#jedi#show_docstring 1
    ">echodoc=================================
    let g:echodoc_enable_at_startup = 1
    "

"==============================lsp
" source $HOME/.config/nvim/gogo/brain/nvimLSPonfig.lua

"==============================fzf
set rtp+=~/.fzf
"
"==============================clang-format
" autocmd FileType javascript ClangFormatAutoEnable          
" //autostart for javascript
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "javascript, typerscript"}
