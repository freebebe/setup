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
    call deoplete#custom#option({
                \ 'max_list': 20,
                \ 'auto_complete_delay': 50,
                \ 'smart_case': v:true,
                \ })

    call deoplete#custom#var('file', {
                \ 'enable_buffer_path': v:true,
                \ })

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

