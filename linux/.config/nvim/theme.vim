if exists("&termguicolors") && exists("&winblend")

lua << EOF
--vim.g.vscode_style = "dark"
--vim.g.vscode_style = "light"
EOF

   set winblend=0
   set wildoptions=pum
   set pumblend=5
   " set background=dark
   " runtime ./colors/blueWhite.vim
   " colo whiteBlue
   " colo blackWhite-n
   " colo blackWhite-l
   " colo falcon
   " colo blueWhite
   " colo monochrome
   " colo codedark
   " colo srcery
   colo vscode

endif

