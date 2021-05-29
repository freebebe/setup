"______________________________________________________________________________
"                                                                       Neomake
scriptencoding utf-8

" ______________________________________________________________________________
"										following battery to uses different more
function! MyOnBattery()
    if has('macunix')
        return match(system('pmset -g batt'), ,"Now drawing from 'Battery Power'") != -1
    elseif has('unix')
        return readfile('/sys/class/power_supply/AC/online') == ['0']
    endif
    return 0
endfunction

if MyOnBattery()
  call neomake#configure#automake('w')
else
  call neomake#configure#automake('nw', 1000)
endif

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
