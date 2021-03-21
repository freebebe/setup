"______________________________________________________________________________
"                                                                       Neomake
let g:neomake_open_list = 0
let g:neomake_verbose = 1
let g:airline#extensions#neomake#enabled = 0

"______________________________________________________________________________
"                                                               JAVASCRIPT / JSX
let g:neomake_jsx_enabled_makers = ['eslint']
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_javascript_eslint_exe = './node_modules/.bin/eslint'

"______________________________________________________________________________
"                                                               YAML / ANSIBLE
let g:neomake_yaml_enabled_makers = ['yamllint']
let g:neomake_ansible_enabled_makers = ['yamllint']
" let g:neomake_ansible_yamllint_maker = neomake#makers#ft#yaml#yamllint()

"______________________________________________________________________________
"                                                                           cpp
let g:neomake_cpp_enable_markers=['clang, javascript']
let g:neomake_cpp_clang_args = ["-std=c++11", "-pedantic", "-Wextra", "-Wall", "-O2", "-fsanitize=undefined", "-Wno-sign-compare"]

"______________________________________________________________________________
"                                                               neomake errors
highlight link NeomakeError DiffDelete
highlight link NeomakeWarning Question
highlight NeomakeErrorSign ctermfg=red

" vim: set ts=2 sw=2 tw=80 noet :" Neomake
"
"______________________________________________________________________________
"																				following battery to uses different more
" function! MyOnBattery()
"     if has('macunix')
"         return match(system('pmset -g batt'), ,"Now drawing from 'Battery Power'") != -1
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
