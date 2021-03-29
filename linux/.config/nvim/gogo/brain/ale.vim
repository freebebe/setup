"_______________________________________________________________________________
"                                                                        ALE{{{
" " from: https://github.com/fohte/rubocop-daemon
  function! AleFixResetView()
    let l:save = winsaveview()
    exec(':ALEFix')
    call winrestview(l:save)
  endfunction
"
"   " let g:ale_ruby_rubocop_executable       = 'rubocop-daemon-wrapper'
"   " let g:ale_ruby_rubocop_auto_correct_all = 1
  let g:ale_javascript_eslint_executable  = 'eslint_d'
  let g:ale_javascript_eslint_use_global  = 1
"
"   let g:ale_linters = {
"     \   'javascript': ['eslint']
"     \}
" "
"   let g:ale_fixers = {
"     \   '*': ['remove_trailing_lines', 'trim_whitespace'],
"     \   'javascript': ['eslint']
"     \}

  let g:ale_fix_on_save        = 0
  " let g:ale_linters_explicit   = 1
  let g:ale_sign_column_always = 1
  let g:ale_sign_error         = '!!'
  let g:ale_sign_warning       = '~>'
  " let g:ale_sign_highlight_linenrs = 1
"-------------------------------------------NEW
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 0
let g:ale_completion_enabled = 0
let g:ale_fix_on_save = 0
let g:ale_set_balloons = 0

let g:ale_vim_vint_show_style_issues = 0
let g:ale_sh_shfmt_options = '-i 4'
let s:ale_fixers = {
    \   'javascript': ['eslint', 'prettier'],
    \   'typescript': ['tslint', 'prettier'],
    \   'css': ['prettier'],
    \   'c': ['clang-format'],
    \   'cpp': ['clang-format'],
    \   'python': ['yapf'],
    \   'rust': ['rustfmt'],
    \   'json': ['fixjson'],
    \   'sh': ['shfmt'],
    \ }

let g:ale_linters = {
    \   'python': ['pylint', 'mypy'],
    \   'typescript': ['tslint', 'tsserver'],
    \ }
let g:ale_fixers = s:ale_fixers
function! s:toggle_ale_fix(bang) abort
    if a:bang
        if empty(g:ale_fixers)
            let g:ale_fixers = s:ale_fixers
            echo 'Enabled ALE fixer (global)'
        else
            let g:ale_fixers = {}
            echo 'Disabled ALE fixer (global)'
        endif
        return
    endif
    if !exists('b:ale_fix_on_save') || !b:ale_fix_on_save
        let b:ale_fix_on_save = 1
        echo 'Enabled ALE fixer'
    else
        let b:ale_fix_on_save = 0
        echo 'Disabled ALE fixer'
    endif
endfunction
command! -nargs=0 -bar -bang ALEToggleFix call <SID>toggle_ale_fix(<bang>0)

"}}}____________________________________________________________________________
