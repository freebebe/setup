"================goyo
"-------------------------------------------------------
" :Goyo            "toggle Goyo
" :Goyo[demension]
" :Goyo!            "off
" let	go:goyo_margin_top = 2
" let	go:goyo_margin_bottom = 2

"================indentline
"-------------------------------------------------------
let g:indentLine_char_list = ['|', '¦', '┆', '┊']"

"================javascript-highlight
"-------------------------------------------------------
" let javascript_enable_domhtmlcss = 1

"================emmet-html&css->deful        
"       (C=ctrl-)
"-------------------------------------------------------
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
"================ emmet
"----------------------------------------------

"============================= vim-gitgutter
"----------------------------------------------
function! GitStatus()
    let [a,m,r] = GitGutterGetHunkSummary()
    return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}

"============================= graphviz
"----------------------------------------------
"============================= neomake
"----------------------------------------------
" let g:neomake_open_list = 2
" let g:neomake_verbose = 0
"
" call neomake#configure#automake('w')            "保存校检
" call neomake#configure#automake('nw', 750)      "切换到NORMAL模式，延迟750ms检查

" following battery to uses different more
" function! MyOnBattery()
"     if has('macunix')
"         return match(system('pmset -g batt'), "Now drawing from 'Battery Power'") != -1
"     elseif has('unix')
"         return readfile('/sys/class/power_supply/AC/online') == ['0']
"     endif
"     return 0
" endfunction
"
" if MyOnBattery()
"   call neomake#configure#automake('w')
" else
"   call neomake#configure#automake('nw', 1000)
" endif
"
" let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
"============================= MATCHU P
"----------------------------------------------
augroup matchup_matchparen_highlight
    autocmd!
    autocmd ColorScheme * hi MatchParen guifg=#c678dd gui=bold
    autocmd ColorScheme * hi MatchWord  guifg=#FFCB6B gui=italic
augroup END

let g:matchup_surround_enabled     = 1
let g:matchup_matchparen_deferred  = 1
let g:matchup_matchparen_offscreen = {}
"============================= surround
"----------------------------------------------
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

"============================= ack
"----------------------------------------------
let g:ackprg = 'ag --nogroup --nocolor --column'
"let g:ackprg = 'ag --vimgrep'  (相同作用)

"============================= latex {
"----------------------------------------------
let g:vimtex_fold_manual=1
let g:tex_flavor='latex'
    "Starting with Vim 7, the filetype of empty .tex files defaults to
    " 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
    " The following changes the default filetype back to 'tex':
let g:Tex_CustomTemplateDirectory="$HOME/.config/nvim/gogo/laxModel/"

"============================= latex_live
"----------------------------------------------
let g:livepreview_previewer = 'zathura'
let g:livepreview_cursorhold_recompile = 0
let g:vimtex_fold_enabled = 1
let g:livepreview_engine = 'pdflatex'
"
"============================== auto_save
"----------------------------------------------
let g:auto_save = 1             " enable AutoSave on Vim startup
let g:auto_save_events = ["InsertLeave", "TextChanged"]
let g:auto_save_silent = 1

"============================== Markdown
"----------------------------------------------
" let g:instant_markdown_slow = 1
" let g:instant_markdown_autostart = 0            "':InstantMarkdownPreview' or 'InstantMarkdownStop'

"============================== Wiki
"----------------------------------------------
let g:vimwiki_list = [{'path': '$HOME/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_conceallevel = 0
let g:vimwiki_global_ext   = 0

"============================== fzf
"----------------------------------------------
set rtp+=~/.fzf
"
"============================== clang-format
"----------------------------------------------
" autocmd FileType javascript ClangFormatAutoEnable          
" //autostart for javascript
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "javascript, typerscript, html, css, scss, less, python"}

"============================== vim-closetag
"----------------------------------------------
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
let g:closetag_filetypes = 'html,xhtml,phtml'
let g:closetag_xhtml_filetypes = 'xhtml,jsx'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

"============================== utilsnips
"----------------------------------------------
" From ncm2-utilsnips, and also for utilsnips
" c-j c-k for moving in snippet, in practice <TAB> works
let g:UltiSnipsExpandTrigger        = "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger   = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger  = "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0

"=========================================================
"============================== deoplete
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
    " Use ALE and also some plugin 'foobar' as completion sources for all code.
call deoplete#custom#option('sources', {
            \ '_': ['ale', 'foobar'],
            \})
    " 补全结束或离开插入模式时，关闭预览窗口
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

    "============================== Newer version of neocomplete 
    "------------------------------------------------------------
    " let g:deoplete_enable_camel_case_completion = 1
    " let g:deoplete_enable_underbar_completion   = 1
    " let g:deoplete_enable_smart_case            = 1
    " let g:deoplete#enable_fuzzy_completion      = 1
    "
    " " default # of completions is 100, that's crazy
    " " let g:deoplete#max_list                     = 10
    "
    " " words less than 2 letters long aren't worth completing
    " let g:deoplete#auto_completion_start_length = 2
    "
    " " This makes sure we use neocomplcache completefunc instead of
    " " the one in rails.vim, otherwise this plugin will crap out
    " let g:deoplete_force_overwrite_completefunc = 1

    "============================== deoplete-ternjs
    "-----------------------------------------------
    let g:deoplete#sources#ternjs#types = 1
        " Whether to include the types of the completions in the result data. Default: 0
    let g:deoplete#sources#ternjs#filetypes = [
                    \ 'jsx',
                    \ 'javascript.jsx',
                    \ 'vue'
                    \ ]
