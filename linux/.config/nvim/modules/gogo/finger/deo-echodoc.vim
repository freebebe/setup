let g:echodoc#events = ['CompleteDone']             " default
let g:echodoc#type = 'signature'                    " echo, signature, virtual, floating
let g:echodoc#highlight_identifier = 'Identifier'   " default
let g:echodoc#highlight_arguments = 'Special'       " default
let g:echodoc#highlight_trailing = 'Type'           " default
let g:echodoc_max_blank_lines = 3                   " hidden params
highlight link EchoDocFloat HoverFloat
