
if dein#tap('defx.nvim')
	nnoremap <silent> <LocalLeader>e
		\ :<C-u>Defx -toggle<CR>
	nnoremap <silent> <LocalLeader>a
		\ :<C-u>Defx -search=`expand('%:p')`<CR>
endif

if dein#tap('fzf.vim')
  nnoremap <silent> <C-p> :GFiles<CR>
endif

if dein#tap('incsearch.vim')
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)

  set hlsearch
  let g:incsearch#auto_nohlsearch = 1
  map n  <Plug>(incsearch-nohl-n)
  map N  <Plug>(incsearch-nohl-N)
  map *  <Plug>(incsearch-nohl-*)
  map #  <Plug>(incsearch-nohl-#)
  map g* <Plug>(incsearch-nohl-g*)
  map g# <Plug>(incsearch-nohl-g#)
endif

if dein#tap('vim-gitgutter')
	nmap ]g <Plug>(GitGutterNextHunk)
	nmap [g <Plug>(GitGutterPrevHunk)
	nmap <Leader>gS <Plug>(GitGutterStageHunk)
	xmap <Leader>gS <Plug>(GitGutterStageHunk)
	nmap <Leader>gr <Plug>(GitGutterUndoHunk)
	nmap <Leader>gv <Plug>(GitGutterPreviewHunk)
endif

if dein#tap('vim-fugitive')
	nmap <Leader>gst :Gstatus<cr>
	nmap <Leader>gc :Gcommit<cr>
	nmap <Leader>ga :Gwrite<cr>
	nmap <Leader>gl :Glog<cr>
	nmap <Leader>gol :0Glog<cr>
	nmap <Leader>gd :Gdiff<cr>
	nmap <Leader>gp :Gpull<cr>
	nmap <Leader>gP :Gpush<cr>
	nmap <Leader>gf :Gfetch<cr>
	nmap <silent><Leader>gh :diffget //2<cr>
	nmap <silent><Leader>gl :diffget //3<cr>
endif

if dein#tap('vim-twiggy')
	nmap <Leader>gt :Twiggy<cr>
endif

if dein#tap('nerdcommenter')
  nmap <silent><C-_> <plug>NERDCommenterToggle
  vmap <silent><C-_> <plug>NERDCommenterToggle
  let g:NERDSpaceDelims = 1
  let g:NERDCompactSexyComs = 1
  let g:NERDDefaultAlign = 'left'
  let g:NERDAltDelims_java = 1
  let g:NERDCommentEmptyLines = 1
  let g:NERDTrimTrailingWhitespace = 1
  let g:NERDToggleCheckAllLines = 1
endif

if dein#tap('vim-operator-replace')
	xmap p <Plug>(operator-replace)
endif

