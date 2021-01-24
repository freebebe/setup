function! s:open_invoke(command, candle) abort
  let l:curr_winid = win_getid()
  call a:candle.close()
  let l:next_winid = l:curr_winid == a:candle.winid ? a:candle.prev_winid : l:curr_winid

  let l:item = a:candle.get_action_items()[0]
  call vimrc#open(a:command, l:item, win_id2win(l:next_winid))
endfunction
call candle#action#register({
\   'name': 'edit',
\   'accept': function('candle#action#location#accept_single'),
\   'invoke': function('s:open_invoke', ['edit']),
\ })
call candle#action#register({
\   'name': 'split',
\   'accept': function('candle#action#location#accept_single'),
\   'invoke': function('s:open_invoke', ['split']),
\ })
call candle#action#register({
\   'name': 'vsplit',
\   'accept': function('candle#action#location#accept_single'),
\   'invoke': function('s:open_invoke', ['vsplit']),
\ })
