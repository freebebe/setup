"______________________________________________________________________________
"																            goyo
" :Goyo            "toggle Goyo
" :Goyo[demension]
" :Goyo!            "off
" let	go:goyo_margin_top = 2
" let	go:goyo_margin_bottom = 2

"______________________________________________________________________________
"																    indentline
let g:indentLine_char_list = ['|', '¦', '┆', '┊']"

"_______________________________________________________________________________
"															javascript-highlight
" let javascript_enable_domhtmlcss = 1

"_______________________________________________________________________________
"															emmet-html&css->deful        
"                                                                       (C=ctrl-)

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

"_______________________________________________________________________________
"																	        emmet

"_______________________________________________________________________________
"																	vim-gitgutter
function! GitStatus()
    let [a,m,r] = GitGutterGetHunkSummary()
    return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}

"_______________________________________________________________________________
"																		graphviz

"_______________________________________________________________________________
"																		neomake
" let g:neomake_open_list = 2
" let g:neomake_verbose = 0
"
"======================================When writing a buffer.                                                                                                                                                                   
"-----------------------------------------------------------
call neomake#configure#automake('w')                                                                                                                                                       
" When writing a buffer, and on normal mode changes (after 750ms).                                                                                                                         
call neomake#configure#automake('nw', 750)                                                                                                                                                 
" When reading a buffer (after 1s), and when writing.                                                                                                                                      
call neomake#configure#automake('rw', 1000)   


"_______________________________________________________________________________
"                                                                     MATCHU P

augroup matchup_matchparen_highlight
    autocmd!
    autocmd ColorScheme * hi MatchParen guifg=#c678dd gui=bold
    autocmd ColorScheme * hi MatchWord  guifg=#FFCB6B gui=italic
augroup END

let g:matchup_surround_enabled     = 1
let g:matchup_matchparen_deferred  = 1
let g:matchup_matchparen_offscreen = {}

"_______________________________________________________________________________
"                                                                     surround

"                                           可视模式
"|-----------------------------------------------------------------------------|
"|    | 命令            | 说明 + 示例                                          |
"|---:|:----------------|:-----------------------------------------------------|
"|    | S               | 选中的括起来                                         |
"| 例 | 选中world: S(   | Hello world! => Hello (world)!                       |
"|---:|:----------------|:-----------------------------------------------------|
"|    | gS              | 选中的括起来，括号内文本做新一行                     |
"| 例 | 选中world: gS{  | Hello world! => Hello { world }!                     |
"|-----------------------------------------------------------------------------|

"_______________________________________________________________________________
"                                                                           ack

let g:ackprg = 'ag --nogroup --nocolor --column'
"let g:ackprg = 'ag --vimgrep'  (相同作用)

"_______________________________________________________________________________
"                                                                          latex

let g:vimtex_fold_manual=1
let g:tex_flavor='latex'
    "Starting with Vim 7, the filetype of empty .tex files defaults to
    " 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
    " The following changes the default filetype back to 'tex':
let g:Tex_CustomTemplateDirectory="$HOME/.config/nvim/gogo/laxModel/"

"_______________________________________________________________________________
"                                                                     latex_live

let g:livepreview_previewer = 'zathura'
let g:livepreview_cursorhold_recompile = 0
let g:vimtex_fold_enabled = 1
let g:livepreview_engine = 'pdflatex'
"
"_______________________________________________________________________________
"                                                                       auto_save

let g:auto_save = 1                             " enable AutoSave on Vim startup
let g:auto_save_events = ["InsertLeave", "TextChanged"]
let g:auto_save_silent = 1

"_______________________________________________________________________________
"                                                                       Markdown

" let g:instant_markdown_slow = 1
" let g:instant_markdown_autostart = 0              "':InstantMarkdownPreview' 
"                                                                           or 
"                                                       'InstantMarkdownStop'

"_______________________________________________________________________________
"                                                                           Wiki

" let g:vimwiki_list = [{'path': '$HOME/vimwiki/',
"                       \ 'syntax': 'markdown', 'ext': '.md'}]
" let g:vimwiki_conceallevel = 0
" let g:vimwiki_global_ext   = 0

"_______________________________________________________________________________
"																			fzf
set rtp+=~/.fzf

"_______________________________________________________________________________
"                                                                  clang-format

" autocmd FileType javascript ClangFormatAutoEnable          
" //autostart for javascript
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "javascript, typerscript, html, css, scss, less, python"}

"_______________________________________________________________________________
"                                                                   vim-closetag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
let g:closetag_filetypes = 'html,xhtml,phtml'
let g:closetag_xhtml_filetypes = 'xhtml,jsx'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

"_______________________________________________________________________________
"                                                                       utilsnips
" From ncm2-utilsnips, and also for utilsnips
" c-j c-k for moving in snippet, in practice <TAB> works
let g:UltiSnipsExpandTrigger        = "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger   = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger  = "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0

"_______________________________________________________________________________
"																		deoplete

"_______________________________________________________________________________
"                                                                           ale

let g:ale_linters = {'javacript': [], 'vue': [], 'css': [], 'typerscript': []}
" let g:ale_fixers = {'ruby': ['rubocop']}
let g:ale_lint_delay = 1000

"_______________________________________________________________________________
"                                                                       neomake
"
" neomake errors {{{
  highlight link NeomakeError DiffDelete
  highlight link NeomakeWarning Question
  highlight NeomakeErrorSign cterm=none ctermbg=none ctermfg=red
"}}}
