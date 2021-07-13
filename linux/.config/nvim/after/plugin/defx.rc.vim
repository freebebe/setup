" fi = tree open
" sf = tree
"    > h = backspace
"    > enter = open
" 'vertical'
" Define mappings
cnoreabbrev sf Defx -listed -new
    \ -columns=indent:mark:icon:icons:filename:git:size
    \ -buffer-name=tab`tabpagenr()`<CR>
call defx#custom#option('_',{
    \ 'winwidth'  : 30,
    \ 'show_ignored_files': 0,
    \ 'buffer_name': '',
    \ 'toggle': 1,
    \ 'resume': 1,
    \ 'ignored_files': '*.pyc,*.pyd,*~,*.swo,*.swp,.git,.hg,.svn,.bzr,.DS_Store',
    \ })
    " \ 'split'     : 'center',
    "                 'vertical'


call defx#custom#column('icon', {
    \ 'directory_icon': '▸',
    \ 'opened_icon': '▾',
    \ 'root_icon': ' ',
    \ })

call defx#custom#column('git', 'indicators', {
    \ 'Modified'  : 'M',
    \ 'Staged'    : '✚',
    \ 'Untracked' : '✭',
    \ 'Renamed'   : '➜',
    \ 'Unmerged'  : '═',
    \ 'Ignored'   : '☒',
    \ 'Deleted'   : '✖',
    \ 'Unknown'   : '?'
    \ })

