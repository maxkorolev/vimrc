
if dein#tap('defx.nvim')
	nnoremap <silent> <LocalLeader>e
		\ :<C-u>Defx -toggle<CR>
	nnoremap <silent> <LocalLeader>a
		\ :<C-u>Defx -search=`expand('%:p')`<CR>
endif

