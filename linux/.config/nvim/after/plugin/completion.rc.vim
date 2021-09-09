

if !exists('g:loaded_completion') | finish | endif

set completeopt=menuone,noinsert,noselect

let g:completion_enable_snippet = 'Neosnippet'
" let g:completion_enable_snippet = 'vim-vsnip'

""--------------------------------------------------------
" let g:completion_enable_auto_popup = 0
"===================auto disable

"===============================================================================
" basic snippets
	"snippet": snippet sources based on g:completion_enable_snippet

" Use <Tab> and <S-Tab> to navigate through popup menu

lua <<EOF
local remap = vim.api.nvim_set_keymap
local status, npairs = pcall(require, "nvim-autopairs")
if (not status) then return end

-- skip it, if you use another global object
_G.MUtils= {}

vim.g.completion_confirm_key = ""

MUtils.completion_confirm=function()
  if vim.fn.pumvisible() ~= 0  then
    if vim.fn.complete_info()["selected"] ~= -1 then
      require'completion'.confirmCompletion()
      return npairs.esc("<c-y>")
    else
      vim.api.nvim_select_popupmenu_item(0 , false , false ,{})
      require'completion'.confirmCompletion()
      return npairs.esc("<c-n><c-y>")
    end
  else
    return npairs.autopairs_cr()
  end
end

remap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})
EOF


