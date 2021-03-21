"________________________________________________________________________
"                                                           deoplete.nvim
"
"============================================ basic
"--------------------------------------------------
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

" <TAB>: completion.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#manual_complete()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<C-h>"

inoremap <silent><expr><C-g>       deoplete#manual_complete('tabnine')
inoremap <silent><expr><C-e>       deoplete#cancel_popup()
inoremap <silent><expr><C-l>       deoplete#complete_common_string()

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return pumvisible() ? deoplete#close_popup()."\<CR>" : "\<CR>"
endfunction

" cpsm test
" call deoplete#custom#source('_', 'matchers', ['matcher_cpsm'])
" call deoplete#custom#source('_', 'sorters', [])

call deoplete#custom#source('_', 'matchers',
      \ ['matcher_fuzzy', 'matcher_length'])
call deoplete#custom#source('denite', 'matchers',
      \ ['matcher_full_fuzzy', 'matcher_length'])
" call deoplete#custom#source('eskk,tabnine', 'matchers', [])
call deoplete#custom#source('eskk', 'matchers', [])
" call deoplete#custom#source('buffer', 'mark', '')
" call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
" call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment', 'String'])
" call deoplete#custom#source('buffer', 'mark', '*')

call deoplete#custom#option('ignore_sources', {
      \ '_': ['tabnine'],
      \ })

call deoplete#custom#source('tabnine', 'rank', 600)
call deoplete#custom#source('tabnine', 'min_pattern_length', 2)
" call deoplete#custom#source('tabnine', 'is_volatile', v:false)
call deoplete#custom#var('tabnine', {
      \ 'line_limit': 300,
      \ 'max_num_results': 10,
      \ })

call deoplete#custom#source('zsh', 'filetypes', ['zsh', 'sh'])
call deoplete#custom#source('nextword', 'filetypes',
      \ ['markdown', 'help', 'gitcommit', 'text'])

call deoplete#custom#source('_', 'converters', [
      \ 'converter_remove_overlap',
      \ 'converter_case',
      \ 'matcher_length',
      \ 'converter_truncate_abbr',
      \ 'converter_truncate_info',
      \ 'converter_truncate_menu',
      \ ])
call deoplete#custom#source('tabnine', 'converters', [
      \ 'converter_remove_overlap',
      \ 'converter_truncate_info',
      \ ])
call deoplete#custom#source('eskk', 'converters', [])

" call deoplete#custom#source('buffer', 'min_pattern_length', 9999)
" call deoplete#custom#source('clang', 'input_pattern', '\.\w*|\.->\w*|\w+::\w*')
" call deoplete#custom#source('clang', 'max_pattern_length', -1)

call deoplete#custom#option('keyword_patterns', {
      \ '_': '[a-zA-Z_]\k*\(?',
      \ 'tex': '[^\w|\s][a-zA-Z_]\w*',
      \ })

" inoremap <silent><expr> <C-t> deoplete#manual_complete('file')

call deoplete#custom#option({
      \ 'auto_preview': v:true,
      \ 'camel_case': v:true,
      \ 'nofile_complete_filetypes': ['denite-filter', 'zsh'],
      \ 'num_processes': 4,
      \ 'refresh_always': v:false,
      \ 'refresh_backspace': v:false,
      \ 'skip_multibyte': v:true,
      \ })

" call deoplete#custom#option('profile', v:true)
" call deoplete#enable_logging('DEBUG', 'deoplete.log')
" call deoplete#custom#source('clang', 'debug_enabled', 1)

call deoplete#custom#option('candidate_marks',
      \ ['A', 'S', 'D', 'F', 'G'])
inoremap <expr>A       pumvisible() ? deoplete#insert_candidate(0) : 'A'
inoremap <expr>S       pumvisible() ? deoplete#insert_candidate(1) : 'S'
inoremap <expr>D       pumvisible() ? deoplete#insert_candidate(2) : 'D'
inoremap <expr>F       pumvisible() ? deoplete#insert_candidate(3) : 'F'
inoremap <expr>G       pumvisible() ? deoplete#insert_candidate(4) : 'G'

" autocmd MyAutoCmd BufEnter * call s:tabnine_check()
"----------------------------
function! s:tabnine_check() abort
  if finddir('.git') !=# ''
    return
  endif

  " Disable tabnine ource
"----------------------------
  call deoplete#custom#buffer_option('ignore_sources', ['tabnine'])
endfunction
call s:tabnine_check()

"_______________________________________________________________________________
"                                                                           Plug

"===================================== ternjs
"-----------------------------------------------------
let g:deoplete#sources#ternjs#types = 1
    " Whether to include the types of the completions in the result data. Default: 0
let g:deoplete#sources#ternjs#filetypes = [
                \ 'jsx',
                \ 'javascript.jsx',
                \ 'vue'
                \ ]
">=================================== Rust
let g:racer_cmd = "/home/user/.cargo/bin/racer"
let g:racer_experimental_completer = 1
