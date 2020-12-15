" File Types
" ===

augroup user_plugin_filetype " {{{
	autocmd!

	" save on focus lost

	" Reload vim config automatically
	autocmd BufWritePost $VIM_PATH/{*.vim,*.yaml,vimrc} nested
		\ source $MYVIMRC | redraw

	" Configuration for vim-scala
	au BufRead,BufNewFile *.sbt set filetype=scala
	au BufRead,BufNewFile *.conf set filetype=hocon

	" Highlight current line only on focused window
	autocmd WinEnter,InsertLeave * if &ft !~# 'denite' | set cursorline | endif
	autocmd WinLeave,InsertEnter * if &ft !~# 'denite' | set nocursorline | endif

	" Equalize window dimensions when resizing vim window
	autocmd VimResized * tabdo wincmd =

	" Check if file changed when its window is focus, more eager than 'autoread'
	autocmd FocusGained * checktime

	autocmd Syntax * if line('$') > 5000 | syntax sync minlines=200 | endif

	" Update filetype on save if empty
	autocmd BufWritePost * nested
		\ if &l:filetype ==# '' || exists('b:ftdetect')
		\ |   unlet! b:ftdetect
		\ |   filetype detect
		\ | endif

	" Reload Vim script automatically if setlocal autoread
	autocmd BufWritePost,FileWritePost *.vim nested
		\ if &l:autoread > 0 | source <afile> |
		\   echo 'source '.bufname('%') |
		\ endif

	" When editing a file, always jump to the last known cursor position.
	" Don't do it when the position is invalid or when inside an event handler
	autocmd BufReadPost *
		\ if &ft !~# 'commit' && ! &diff &&
		\      line("'\"") >= 1 && line("'\"") <= line("$")
		\|   execute 'normal! g`"zvzz'
		\| endif


augroup END " }}}

" Internal Plugin Settings  {{{
" ------------------------

" Python {{{
let g:python_highlight_all = 1

" }}}
" Vim {{{
let g:vimsyntax_noerror = 1
let g:vim_indent_cont = &shiftwidth

" }}}
" Bash {{{
let g:is_bash = 1

" }}}
" Java {{{
let g:java_highlight_functions = 'style'
let g:java_highlight_all = 1
let g:java_highlight_debug = 1
let g:java_allow_cpp_keywords = 1
let g:java_space_errors = 1
let g:java_highlight_functions = 1

" }}}
" JavaScript {{{
let g:SimpleJsIndenter_BriefMode = 1
let g:SimpleJsIndenter_CaseIndentLevel = -1

" }}}
" Ruby {{{
let g:ruby_no_expensive = 1

" }}}
" Folding {{{
" augroup: a
" function: f
let g:vimsyn_folding = 'af'
let g:tex_fold_enabled = 1
let g:xml_syntax_folding = 1
let g:perl_fold = 1
" }}}
" }}}

" vim: set foldmethod=marker ts=2 sw=2 tw=80 noet :
