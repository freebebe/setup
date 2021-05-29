if dein#tap('lightline.vim')
  let g:lightline = {}
  let g:lightline.colorscheme = empty(get(g:colorscheme, 'lightline', '')) ? g:colorscheme.name : g:colorscheme.lightline
  let g:lightline.enable = {}
  let g:lightline.enable.statusline = 1
  let g:lightline.enable.tabline = 1

  let g:lightline.active = {}
  let g:lightline.active.left = [['readonly', 'relativepath', 'modified']]
  let g:lightline.active.right = [['lineinfo', 'percent', 'filetype', 'lamp']]
  let g:lightline.inactive = g:lightline.active
  let g:lightline.separator = { 'left': '', 'right': '' }
  let g:lightline.subseparator = { 'left': '', 'right': '' }

  let g:lightline.tabline = {}
  let g:lightline.tabline.left = [['tabs']]
  let g:lightline.tabline.right = [['git']]
  let g:lightline.tabline_separator = { 'left': '', 'right': '' }
  let g:lightline.tabline_subseparator = { 'left': '', 'right': '' }

  let g:lightline.component_function = {}
  let g:lightline.component_function.git = 'Git'
