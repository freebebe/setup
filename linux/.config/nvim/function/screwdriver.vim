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
" let g:neomake_open_list = 2
"
" call neomake#configure#automake('w')            "保存校检
" call neomake#configure#automake('nw', 750)      "切换到NORMAL模式，延迟750ms检查
"
"following battery to uses different more
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
let g:Tex_CustomTemplateDirectory="$HOME/.config/nvim/gogo/laxModel/"

"=============================latex_live
let g:livepreview_previewer = 'zathura'
let g:livepreview_cursorhold_recompile = 0
let g:vimtex_fold_enabled = 1
let g:livepreview_engine = 'pdflatex'
"
"==============================auto_save
let g:auto_save = 1             " enable AutoSave on Vim startup
let g:auto_save_events = ["InsertLeave", "TextChanged"]
let g:auto_save_silent = 1

"==============================Markdown
" let g:instant_markdown_slow = 1
" let g:instant_markdown_autostart = 0            "':InstantMarkdownPreview' or 'InstantMarkdownStop'

"==============================Wiki
let g:vimwiki_list = [{'path': '$HOME/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_conceallevel = 0
let g:vimwiki_global_ext   = 0

"=========================================================
"==============================deoplete
"=========================================================
if has('nvim')
                " Enable truecolors
    set termguicolors
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=0
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
    " call deoplete#custom#option({
    "             \ 'max_list': 20,
    "             \ 'auto_complete_delay': 50,
    "             \ 'smart_case': v:true,
    "             \ })
    "
    " call deoplete#custom#var('file', {
    "             \ 'enable_buffer_path': v:true,
    "             \ })

                " 补全结束或离开插入模式时，关闭预览窗口
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

        " ">deoplete-ternjs==========================
        let g:tern_request_timeout = 1
        let g:tern_show_signature_in_pum = '0'  " This do disable full signature type on autocomplete
        " let g:deoplete#sources#ternjs#types = 1
                " Whether to include the types of the completions in the result data. Default: 0
                " Make ternjs close automatically
        autocmd CompleteDone * pclose!
        "Add extra filetypes
        let g:tern#filetypes = [
                    \ 'jsx',
                    \ 'javascript.jsx',
                    \ 'vue',
                    \ 'javascript',
                    \ 'js'
                    \ ]
        let g:deoplete#sources#ternjs#filetypes = [
                        \ 'js',
                        \ 'javascript.js',
                        \ 'jsx',
                        \ 'javascript.jsx',
                        \ 'vue'
                        \ ]
        ">deoplete-Rust===========================
        let g:racer_cmd = "$HOME/.cargo/bin/racer"
        let g:racer_experimental_completer = 1
        ">deoplete-jedi==========================
                " let g:deoplete#sources#jedi#show_docstring 1
        ">echodoc=================================
        let g:echodoc_enable_at_startup = 1
        set noshowmode
        "set cmdheight=2
        let g:echodoc#enable_at_startup = 1
        " enable ncm2 for all buffers
        " IMPORTANT: :help Ncm2PopupOpen for more information
        set completeopt=noinsert,menuone,noselect
                " Necessary for deoplete and other python plugins
            " let g:python_host_prog = '/home/' . g:current_user . '/.pyenv/versions/neovim2/bin/python'
            " let g:python3_host_prog = '/home/' . g:current_user . '/.pyenv/versions/neovim3/bin/python'
        elseif !has('nvim')
                " Things that neovim removed
            set nocompatible " be iMproved
            set ttymouse=xterm2
            set term=screen-256color
endif
    "
" Tmuxcomplete use the default completition manager
let g:tmuxcomplete#trigger = ''
" Shamelessly copied over, not working here.
" https://github.com/lervag/vimtex/blob/f66a54695e5eb2454266746701575db452b3224f/autoload/vimtex/re.vim
let g:vimtex#re#deoplete = '\\(?:'
            \ .  '\w*cite\w*(?:\s*\[[^]]*\]){0,2}\s*{[^}]*'
            \ . '|(text|block)cquote\*?(?:\s*\[[^]]*\]){0,2}\s*{[^}]*'
            \ . '|(for|hy)\w*cquote\*?{[^}]*}(?:\s*\[[^]]*\]){0,2}\s*{[^}]*'
            \ . '|\w*ref(?:\s*\{[^}]*|range\s*\{[^,}]*(?:}{)?)'
            \ . '|hyperref\s*\[[^]]*'
            \ . '|includegraphics\*?(?:\s*\[[^]]*\]){0,2}\s*\{[^}]*'
            \ . '|(?:include(?:only)?|input)\s*\{[^}]*'
            \ . '|\w*(gls|Gls|GLS)(pl)?\w*(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
            \ . '|includepdf(\s*\[[^]]*\])?\s*\{[^}]*'
            \ . '|includestandalone(\s*\[[^]]*\])?\s*\{[^}]*'
            \ . '|usepackage(\s*\[[^]]*\])?\s*\{[^}]*'
            \ . '|documentclass(\s*\[[^]]*\])?\s*\{[^}]*'
            \ . '|\w*'
            \ .')'
" Doesn't work out of the box... https://github.com/vim-pandoc/vim-pandoc/issues/185
" http://www.galiglobal.com/blog/2017/20170226-Vim-as-Java-IDE-again.html
call deoplete#custom#var('omni', 'input_patterns', {
            \ 'tex' : g:vimtex#re#deoplete,
            \ 'r' : ['[^. *\t]\.\w*', '\h\w*::\w*', '\h\w*\$\w*'],
            \ 'rmd' : ['[^. *\t]\.\w*', '\h\w*::\w*', '\h\w*\$\w*', '@\w*'],
            \ 'java' : ['[^. *\t]\.\w*'],
            \ 'pandoc': ['@\w*'],
            \})

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
            \ "Standard" : "javascript, typerscript, html, css, scss, less, python"}

"==============================vim-closetag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
let g:closetag_filetypes = 'html,xhtml,phtml'
let g:closetag_xhtml_filetypes = 'xhtml,jsx'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

"==============================utilsnips
" From ncm2-utilsnips, and also for utilsnips
" c-j c-k for moving in snippet, in practice <TAB> works
let g:UltiSnipsExpandTrigger        = "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger   = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger  = "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0

