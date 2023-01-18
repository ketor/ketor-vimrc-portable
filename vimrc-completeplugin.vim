if filereadable(expand("$HOME/.vim/bundle/YouCompleteMe/vimrc_ycm_minimal"))
    let g:my_complete_plugin = "YouCompleteMe"
    " echo 'YouCompleteMe is exists'

    " YouCompleteMe ------------------------------
    let g:acp_enableAtStartup = 0
    " let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
    " let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
    " let g:ycm_extra_conf_globlist=['~/.vim/*']
    " let g:ycm_collect_identifiers_from_tags_files = 1
    let g:ycm_filetype_blacklist = {
            \ 'tagbar': 1,
            \ 'qf' : 1,
            \ 'notes': 1,
            \ 'markdown': 1,
            \ 'netrw': 1,
            \ 'unite': 1,
            \ 'text': 1,
            \ 'vimwiki': 1,
            \ 'pandoc': 1,
            \ 'infolog': 1,
            \ 'leaderf': 1,
            \ 'objc' : 1,
            \ 'mail': 1
            \}
    nnoremap <silent> <Leader>yc :YcmCompleter GetDoc<CR>
    nnoremap <silent> <Leader>yf :YcmCompleter FixIt<CR>
    nnoremap <silent> <Leader>yi :YcmCompleter GoToInclude<CR>
    nnoremap <silent> <Leader>yt :YcmCompleter GetType<CR>
    nnoremap <silent> <Leader>jj :YcmCompleter GoTo<CR>
    nnoremap <silent> <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
    nnoremap <silent> <Leader>jr :YcmCompleter GoToReferences<CR>
    nnoremap <silent> <Leader>ji :YcmCompleter GoToImplementation<CR>
    nnoremap <silent> <Leader>jc :YcmCompleter GoToCallers<CR>

    " Enable omni completion.
    " autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    " autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    " autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    " autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    " autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    " autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
    " autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

    " 回车键选中补全项(有冲突，关闭此设置）
    "inoremap <expr> <CR>       pumvisible() ? '<C-y>' : '\<CR>'

    "使用 ctrl+z 激活语义补全
    let g:ycm_key_invoke_completion = '<c-z>'
else
    let g:my_complete_plugin = "neocomplcache"

    " NeoComplCache ------------------------------
    "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplcache.
    let g:neocomplcache_enable_at_startup = 1
    " Use smartcase.
    let g:neocomplcache_enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplcache_min_syntax_length = 3
    let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

    " Enable heavy features.
    " Use camel case completion.
    "let g:neocomplcache_enable_camel_case_completion = 1
    " Use underbar completion.
    "let g:neocomplcache_enable_underbar_completion = 1

    " Define dictionary.
    let g:neocomplcache_dictionary_filetype_lists = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

    " Define keyword.
    if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
    endif
    let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplcache#undo_completion()
    inoremap <expr><C-l>     neocomplcache#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
      return neocomplcache#smart_close_popup() . "\<CR>"
      " For no inserting <CR> key.
      "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplcache#close_popup()
    inoremap <expr><C-e>  neocomplcache#cancel_popup()

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable heavy omni completion.
    if !exists('g:neocomplcache_force_omni_patterns')
      let g:neocomplcache_force_omni_patterns = {}
    endif
    let g:neocomplcache_force_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
    let g:neocomplcache_force_omni_patterns.cc = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
    let g:neocomplcache_force_omni_patterns.go = '[^.[:digit:] *\t]\.\w*'

    " For perlomni.vim setting.
    " https://github.com/c9s/perlomni.vim
    let g:neocomplcache_force_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
endif

