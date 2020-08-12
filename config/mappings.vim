" Key-mappings
" ===

" Non-standard {{{
" ---

" Fix keybind name for Ctrl+Spacebar
map <Nul> <C-Space>
map! <Nul> <C-Space>

" Double leader key for jumping to alternative file
nmap <silent> <Leader><Leader> <C-^>

" Toggle fold
nnoremap <CR> za

"}}}


" Global niceties {{{
" ---------------

" Start an external command with a single bang
nnoremap ! :!

" Allow misspellings
cnoreabbrev qw wq
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev Qa qa
cnoreabbrev Bd bd
cnoreabbrev bD bd

nnoremap ) :<C-u>cnext<CR>
nnoremap ( :<C-u>cprevious<CR>

" Improve scroll, credits: https://github.com/Shougo
nnoremap <expr> zz (winline() == (winheight(0)+1) / 2) ?
	\ 'zt' : (winline() == 1) ? 'zb' : 'zz'
noremap <expr> <C-f> max([winheight(0) - 2, 1])
	\ ."\<C-d>".(line('w$') >= line('$') ? "L" : "M")
noremap <expr> <C-b> max([winheight(0) - 2, 1])
	\ ."\<C-u>".(line('w0') <= 1 ? "H" : "M")
noremap <expr> <C-e> (line("w$") >= line('$') ? "j" : "3\<C-e>")
noremap <expr> <C-y> (line("w0") <= 1         ? "k" : "3\<C-y>")

" Window control
nnoremap <C-q> <C-w>

" Select blocks after indenting
xnoremap < <gv
xnoremap > >gv|

" Switch history search pairs, matching my bash shell
cnoremap <C-p>  <Up>
cnoremap <C-n>  <Down>
cnoremap <Up>   <C-p>
cnoremap <Down> <C-n>

" }}}

" File operations {{{
" ---------------

" Fast saving
nnoremap <silent><Leader>w :write<CR>
vnoremap <silent><Leader>w <Esc>:write<CR>
nnoremap <silent><C-s> :<C-u>write<CR>
vnoremap <silent><C-s> :<C-u>write<CR>
inoremap <silent><C-s> <C-O>:update<CR>
cnoremap <silent><C-s> <C-u>write<CR>

" }}}


" Totally Custom {{{
" --------------

" Remove spaces at the end of lines
nnoremap <silent> <Leader>cw :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>

" }}}
"
" Windows and buffers {{{

nnoremap <silent> [Window]v  :<C-u>split<CR>
nnoremap <silent> [Window]g  :<C-u>vsplit<CR>
nnoremap <silent> [Window]t  :tabnew<CR>
nnoremap <silent> [Window]o  :<C-u>only<CR>
nnoremap <silent> [Window]b  :b#<CR>
nnoremap <silent> [Window]c  :close<CR>

" }}}
"
nnoremap <Leader>u :call GenUUID()<CR>
func! GenUUID()
  let cmd = 'uuidgen -t | tr "[:upper:]" "[:lower:]" | tr -d "[:cntrl:]"'
  silent exec ":normal a" . system(cmd)
endfunc

" vim: set foldmethod=marker ts=2 sw=2 tw=80 noet :
