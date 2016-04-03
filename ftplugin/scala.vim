" c	Auto-wrap comments using textwidth, inserting the current comment leader automatically.
" r	Automatically insert the current comment leader after hitting <Enter> in Insert mode.
" q	Allow formatting of comments with "gq".
setlocal formatoptions=crq

" Maximum width of text that is being inserted
setlocal textwidth=80

"setlocal foldmethod=marker
"setlocal foldmarker=//{,//}

setlocal foldlevel=0
