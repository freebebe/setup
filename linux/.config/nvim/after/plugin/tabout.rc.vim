if !exists('g: loaded_tabout') | finish | endif

lua << EOF
-- Lua
use {
    'abecodes/tabout.nvim',
    config = function()
        require('tabout').setup {
        tabkey = '<Tab>', -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = true, -- shift content if tab out is not possible
        act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
        enable_backwards = true, -- well ...
        completion = true, -- if the tabkey is used in a completion pum
        tabouts = {
            {open = "'", close = "'"},
            {open = '"', close = '"'},
            {open = '`', close = '`'},
            {open = '(', close = ')'},
            {open = '[', close = ']'},
            {open = '{', close = '}'}
        },
        ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
        exclude = {} -- tabout will ignore these filetypes
}
    end,
        wants = {'nvim-treesitter'}, -- or require if not used so far
        after = {'nvim-cmp'} -- if a nvim-cmp plugin is using tabs load it before
}

require("tabout").setup({
    tabkey = "",
    backwards_tabkey = "",
})

local function replace_keycodes(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_binding()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_binding()", {expr = true})

EOF
