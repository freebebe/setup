lua <<EOF
vim.lsp.set_log_level(0)

local lspconfig = require "lspconfig"

local map = function(mode, key, result, noremap)
    if noremap == nil then
        noremap = true
    end
    vim.api.nvim_buf_set_keymap(0, mode, key, result, {noremap = noremap, silent = true})
end

vim.lsp.handlers["textDocument/formatting"] = function(err, _, result, _, bufnr)
    if err ~= nil or result == nil then
        return
    end

    if not vim.api.nvim_buf_get_option(bufnr, "modified") then
        local view = vim.fn.winsaveview()
        vim.lsp.util.apply_text_edits(result, bufnr)
        vim.fn.winrestview(view)
        if bufnr == vim.api.nvim_get_current_buf() then
            vim.cmd("noautocmd :update")
            vim.cmd("GitGutter")
        end
    end
end

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = function(...)
--     vim.lsp.with(
--         vim.lsp.diagnostic.on_publish_diagnostics,
--         {
--             underline = true,
--             update_in_insert = false
--         }
--     )(...)
--     pcall(vim.lsp.diagnostic.set_loclist, {open_loclist = false})
-- end

-- _G.formatting = function()
--     if not vim.g[string.format("format_disabled_%s", vim.bo.filetype)] then
--         vim.lsp.buf.formatting(vim.g[string.format("format_options_%s", vim.bo.filetype)] or {})
--     end
-- end

local on_attach = function(client)
    -- Illuminate handles highlighting keywords
    require 'illuminate'.on_attach(client)

    -- Handle formatting with EFM
    client.resolved_capabilities.document_formatting = false

    if client.resolved_capabilities.goto_definition then
        map("n", "<C-]>", "<cmd>lua vim.lsp.buf.definition()<CR>")
    end

    -- if client.resolved_capabilities.completion then
    --     require "completion".on_attach(client)
    --     map("i", "<c-n>", "<Plug>(completion_trigger)", false)
    --     map("i", "<c-j>", "<Plug>(completion_next_source)", false)
    --     map("i", "<c-k>", "<Plug>(completion_prev_source)", false)
    -- end

    if client.resolved_capabilities.document_highlight then
      vim.api.nvim_command [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
      vim.api.nvim_command [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]
      vim.api.nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
    end

    -- if client.resolved_capabilities.hover then
    --     map("n", "<CR>", "<cmd>lua vim.lsp.buf.hover()<CR>")
    -- end

    if client.resolved_capabilities.find_references then
        map("n", "<Leader>*", ":call lists#ChangeActiveList('Quickfix')<CR>:lua vim.lsp.buf.references()<CR>")
    end

    if client.resolved_capabilities.rename then
        map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
    end
end

local on_attach_efm = function(client)
    vim.cmd [[augroup Format]]
    vim.cmd [[autocmd! * <buffer>]]
    vim.cmd [[autocmd BufWritePost <buffer> lua formatting()]]
    vim.cmd [[augroup END]]

    print("efm attached")
end

lspconfig.efm.setup {
    on_attach = on_attach_efm,
    init_options = { documentFormatting = true },
    default_config = {
      cmd = { "efm-langserver", "-c", [["$HOME/.config/efm-langserver/config.yaml"]] },
    },
    filetypes = {
  -------------------------- nots
        "json",
        "jsonc",
        "lua",
        "yml",
        "yaml",
        "markdown",
  -------------------------- backSever
        "go",
        "php",
        "java",
        "graphql",
        "ruby",
  -------------------------- web_dev
        "css",
        "scss",
        "html",
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescript.tsx",
        "typescriptreact",
        "rust",
        "vue"
  -------------------------- 
    }
}

lspconfig.solargraph.setup { on_attach = on_attach }
EOF

let g:lsp_diagnostics_enabled = 1
let g:lsp_signs_enabled       = 1
let g:lsp_signs_error         = {'text': '!!'}
let g:lsp_signs_warning       = {'text': '~>'}
let g:lsp_highlights_enabled  = 1

" Do not use virtual text
let g:lsp_virtual_text_enabled = 0

" echo a diagnostic message at cursor position
let g:lsp_diagnostics_echo_cursor = 0

" show diagnostic in floating window
let g:lsp_diagnostics_float_cursor = 1

" whether to enable highlight a symbol and its references
let g:lsp_highlight_references_enabled = 1
let g:lsp_preview_max_width = 80

nnoremap <leader>gp :lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <leader>gn :lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <leader>de :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>ff :lua vim.lsp.buf.formatting()<CR>
nnoremap <leader>ho :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>rn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>f :lua vim.lsp.buf.references()<CR>
nnoremap <leader>ds :lua vim.lsp.buf.document_symbol()<CR>
