"_______________________________________________________________________________
"                                                       plugin configuration {{{

let g:deoplete#enable_at_startup=1
let g:deoplete#custom#option=({
    \ 'auto_complete_delay': 200,
    \ 'enable_smart_case': 1,
    \ 'smart_case': v:true,
    \ })

" --------------------------- 用户输入至少两个字符时再开始提示补全
call deoplete#custom#source('LanguageClient',
            \ 'min_pattern_length',
            \ 2)
" --------------------------- 字符串中不补全
call deoplete#custom#source('_',
            \ 'disabled_syntaxes', ['String']
            \ )

" --------------------------- 补全结束或离开插入模式时，关闭预览窗口
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" --------------------------- Full fuzzy matching matcher.
" --------------------------- It accepts partial fuzzy matches like YouCompleteMe.
call deoplete#custom#source('_', 'matchers',
      \ ['matcher_fuzzy', 'matcher_length'])
call deoplete#custom#source('denite', 'matchers',
      \ ['matcher_full_fuzzy', 'matcher_length'])

" }}}___________________________________________________________________________

"_______________________________________________________________________________
"                                                                       Plug {{{

"---------------------------- ternjs {{
let g:deoplete#sources#ternjs#types = 1
    " Whether to include the types of the completions in the result data. Default: 0
let g:deoplete#sources#ternjs#filetypes = [
                \ 'jsx',
                \ 'javascript.jsx',
                \ 'vue',
                \ '...'
                \ ]
"}}-----------------------------------
"---------------------------- Rust {{
" let g:racer_cmd = "/home/user/.cargo/bin/racer"
" let g:racer_experimental_completer = 1
"}}----------------------------------

"}}}_______________________________________________________________________________
