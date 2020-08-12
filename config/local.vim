" colorscheme gruvbox
colorscheme onedark

hi CocUnderline gui=None term=None
highlight CocErrorHighlight guisp=#542d2d guibg=#542d2d
highlight CocWarningHighlight guisp=#423926 guibg=#423926
 
function! CommitQF(...)
    " Get the commit hash if it was specified
    let commit = a:0 == 0 ? '' : a:1

    " Get the result of git show in a list
    let flist = system('git show --name-only ' . commit . ' | tail -n +7')
    let flist = split(flist, '\n')

    " Create the dictionnaries used to populate the quickfix list
    let list = []
    for f in flist
        let dic = {'filename': f, "lnum": 1}
        call add(list, dic)
    endfor

    " Populate the qf list
    call setqflist(list)
endfunction
