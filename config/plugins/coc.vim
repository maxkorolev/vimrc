" coc.nvim settings
" ---

" Use <c-space> for trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" use <c-space>for trigger completion
inoremap <silent><expr> <C-space> coc#refresh()

" Movement within 'ins-completion-menu'
imap <expr><C-j>   pumvisible() ? "\<Down>" : "\<C-j>"
imap <expr><C-k>   pumvisible() ? "\<Up>" : "\<C-k>"

" Scroll pages in menu
inoremap <expr><C-f> pumvisible() ? "\<PageDown>" : "\<Right>"
inoremap <expr><C-b> pumvisible() ? "\<PageUp>" : "\<Left>"
imap     <expr><C-d> pumvisible() ? "\<PageDown>" : "\<C-d>"
imap     <expr><C-u> pumvisible() ? "\<PageUp>" : "\<C-u>"


" Use `[q` and `]q` to navigate diagnostics
nmap <silent> [q <Plug>(coc-diagnostic-prev)
nmap <silent> ]q <Plug>(coc-diagnostic-next)

nnoremap <silent> ]c :<C-u>CocNext<CR>
nnoremap <silent> [c :<C-u>CocPrev<CR>
nnoremap <silent> } :<C-u>CocNext<CR>
nnoremap <silent> { :<C-u>CocPrev<CR>

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" show commit contains current position
nmap gC <Plug>(coc-git-commit)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim', 'help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		let l:found = CocAction('doHover')
	endif
endfunction

" Remap for rename current word
nmap <Leader>i :CocCommand editor.action.organizeImport<CR>


" Remap for rename current word
nmap <Leader>rn <Plug>(coc-rename)
" Fix autofix problem of current line
nmap <leader>qf <Plug>(coc-fix-current)

" Show all diagnostics
nnoremap <silent> <Leader>a  :<C-u>CocList diagnostics<cr>
" Find symbol of current document
nnoremap <silent> <Leader>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <Leader>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <Leader>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <Leader>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <Leader>p  :<C-u>CocListResume<CR>

" Notify coc.nvim that <enter> has been pressed.
" Currently used for the formatOnType feature.
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" Grep

" grep word under cursor
command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep '.<q-args>

function! s:GrepArgs(...)
  let list = ['-S', '-i', '-ignorecase', '-w', '-word',
        \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
  return join(list, "\n")
endfunction

" Keymapping for grep word under cursor with interactive mode
nnoremap <silent> <Leader>cf :exe 'CocList -A -I --input='.expand('<cword>').' grep'<CR>

vnoremap <Leader>g :<C-u>call <SID>GrepFromSelected(visualmode())<CR>
nnoremap <Leader>g :<C-u>set operatorfunc=<SID>GrepFromSelected<CR>g@

function! s:GrepFromSelected(type)
  let saved_unnamed_register = @@
  if a:type ==# 'v'
    normal! `<v`>y
  elseif a:type ==# 'char'
    normal! `[v`]y
  else
    return
  endif
  let word = substitute(@@, '\n$', '', 'g')
  let word = escape(word, '| ')
  let @@ = saved_unnamed_register
  execute 'CocList -A grep '.word
endfunction

nnoremap <silent> <Leader>w  :exe 'CocList -A -I --normal --input='.expand('<cword>').' words'<CR>
