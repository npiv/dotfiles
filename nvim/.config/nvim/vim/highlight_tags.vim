augroup enterMarkdownNpiv
   autocmd! 
   autocmd BufEnter *.md syntax match Hashtag /#\w\+/
   autocmd BufEnter *.md highlight Hashtag ctermfg=Green guifg=pink guibg=darkgreen
augroup END
