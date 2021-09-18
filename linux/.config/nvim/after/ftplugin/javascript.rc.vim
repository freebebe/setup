if exists("b:did_ftplugin_javascript") | finish | endif

autocmd Filetype javascript,javascriptreact,typescriptreact  setlocal sw=2 sts=2 expandtab

lua << EOF
vim.fn.execute(
  string.format(
    'noautocmd set filetype=%s',
    vim.fn.substitute(vim.bo.filetype, 'javascriptreact', 'javascript.jsx', '')
  )
)                                                                               --reactJSX

vim.fn.execute(
  string.format(
    'noautocmd set filetype=%s',
    vim.fn.substitute(vim.bo.filetype, 'typescriptreact', 'typescript.tsx', '')
  )
)                                                                               --reactTSX

EOF
