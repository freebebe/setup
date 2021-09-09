if exists("b:did_ftplugin_css") | finish | endif

autocmd FileType css,sass,scss setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType css,sass,scss setlocal sw=2 sts=2 expandtab
