
call defx#custom#option('_', {
	\ 'winwidth': 70,
	\ 'split': 'vertical',
	\ 'direction': 'topleft',
	\ 'show_ignored_files': 0,
	\ 'columns': 'indent:git:icons:filename',
	\ 'root_marker': ' ',
	\ 'ignored_files':
	\     '.mypy_cache,.pytest_cache,.git,.hg,.svn,.stversions'
	\   . ',__pycache__,.sass-cache,*.egg-info,.DS_Store,*.pyc'
	\ })

call defx#custom#column('git', {
	\   'indicators': {
	\     'Modified'  : '•',
	\     'Staged'    : '✚',
	\     'Untracked' : 'ᵁ',
	\     'Renamed'   : '≫',
	\     'Unmerged'  : '≠',
	\     'Ignored'   : 'ⁱ',
	\     'Deleted'   : '✖',
	\     'Unknown'   : '⁇'
	\   }
	\ })

call defx#custom#column('mark', { 'readonly_icon': '', 'selected_icon': '' })

call defx#custom#column('filename', {
      \ 'max_width': '70',
      \ 'min_width': '70',
      \ })

" defx-icons plugin
let g:defx_icons_column_length = 2
let g:defx_icons_mark_icon = '✓'
let g:defx_icons_parent_icon = ''

augroup user_plugin_defx
	autocmd!

	" FIXME
	" autocmd DirChanged * call s:defx_refresh_cwd(v:event)

	" Delete defx if it's the only buffer left in the window
	autocmd WinEnter * if &filetype == 'defx' && winnr('$') == 1 | q | endif

	" Move focus to the next window if current buffer is defx
	autocmd TabLeave * if &filetype == 'defx' | wincmd w | endif

	autocmd TabClosed * call s:defx_close_tab(expand('<afile>'))

	" Define defx window mappings
	autocmd FileType defx call s:defx_mappings()

augroup END


" Internal functions
" ---

function! s:defx_close_tab(tabnr)
	" When a tab is closed, find and delete any associated defx buffers
	for l:nr in range(1, bufnr('$'))
		let l:defx = getbufvar(l:nr, 'defx')
		if empty(l:defx)
			continue
		endif
		let l:context = get(l:defx, 'context', {})
		if get(l:context, 'buffer_name', '') ==# 'tab' . a:tabnr
			silent! execute 'bdelete '.l:nr
			break
		endif
	endfor
endfunction

function! s:defx_toggle_tree() abort
	" Open current file, or toggle directory expand/collapse
	if defx#is_directory()
		return defx#do_action('open_or_close_tree')
	endif
	return defx#do_action('multi', ['drop', 'quit'])
endfunction

function! s:jump_dirty(dir) abort
	" Jump to the next position with defx-git dirty symbols
	let l:icons = get(g:, 'defx_git_indicators', {})
	let l:icons_pattern = join(values(l:icons), '\|')

	if ! empty(l:icons_pattern)
		let l:direction = a:dir > 0 ? 'w' : 'bw'
		return search(printf('\(%s\)', l:icons_pattern), l:direction)
	endif
endfunction


function! s:defx_mappings() abort
	" Defx window keyboard mappings
	setlocal signcolumn=no
	setlocal cursorline

	nnoremap <silent><buffer><expr> <CR>  <SID>defx_toggle_tree() . 'j' 
	nnoremap <silent><buffer><expr> l     <SID>defx_toggle_tree() . 'j' 
	nnoremap <silent><buffer><expr> h     defx#do_action('close_tree')
	nnoremap <silent><buffer><expr> t     defx#do_action('open_tree_recursive')
	nnoremap <silent><buffer><expr> P     defx#do_action('open', 'pedit')
	nnoremap <silent><buffer><expr> K     defx#do_action('new_directory')
	nnoremap <silent><buffer><expr> N     defx#do_action('new_multiple_files')
	nnoremap <silent><buffer><expr> dd    defx#do_action('remove_trash')
	nnoremap <silent><buffer><expr> r     defx#do_action('rename')
	nnoremap <silent><buffer><expr> .     defx#do_action('toggle_ignored_files')
	nnoremap <silent><buffer><expr> yy    defx#do_action('yank_path')
	nnoremap <silent><buffer><expr> <Esc> defx#do_action('quit')

	nnoremap <silent><buffer>       [g :<C-u>call <SID>jump_dirty(-1)<CR>
	nnoremap <silent><buffer>       ]g :<C-u>call <SID>jump_dirty(1)<CR>

	nnoremap <silent><buffer><expr><nowait> c  defx#do_action('copy')
	nnoremap <silent><buffer><expr><nowait> m  defx#do_action('move')
	nnoremap <silent><buffer><expr><nowait> p  defx#do_action('paste')

	nnoremap <silent><buffer><expr><nowait> <Space>
		\ defx#do_action('toggle_select') . 'j'

	nnoremap <silent><buffer><expr> '      defx#do_action('toggle_select') . 'j'
	nnoremap <silent><buffer><expr> *      defx#do_action('toggle_select_all')
	nnoremap <silent><buffer><expr> <C-r>  defx#do_action('redraw')
	nnoremap <silent><buffer><expr> <C-g>  defx#do_action('print')

	nnoremap <silent><buffer><expr> C
		\ defx#do_action('toggle_columns', 'indent:mark:filename:type:size:time')

endfunction

