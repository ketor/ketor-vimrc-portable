    let g:my_complete_plugin = "asyncomplete"
    let s:vim_home = fnamemodify(resolve(expand('<sfile>:p')), ':h')

    " vim-lsp configuration ------------------------------
    let g:lsp_diagnostics_enabled = 1
    let g:lsp_diagnostics_signs_enabled = 1
    let g:lsp_diagnostics_echo_cursor = 1
    let g:lsp_diagnostics_float_cursor = 0
    let g:lsp_document_code_action_signs_enabled = 0
    let g:lsp_settings_servers_dir = expand('~/.cache/vim-lsp-servers')

    " Buffer-local LSP keymaps, only active when LSP is available
    function! s:on_lsp_buffer_enabled() abort
        setlocal omnifunc=lsp#complete
        nmap <buffer> gd <plug>(lsp-definition)
        nmap <buffer> gr <plug>(lsp-references)
        nmap <buffer> gi <plug>(lsp-implementation)
        nmap <buffer> gt <plug>(lsp-type-definition)
        nmap <buffer> K <plug>(lsp-hover)
        nmap <buffer> <leader>rn <plug>(lsp-rename)
        nmap <buffer> [g <plug>(lsp-previous-diagnostic)
        nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    endfunction

    augroup lsp_install
        au!
        autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
    augroup END

    " asyncomplete configuration ------------------------------
    let g:asyncomplete_auto_popup = 1
    let g:asyncomplete_auto_completeopt = 0
    let g:asyncomplete_popup_delay = 50

    " Register buffer source
    augroup AsyncompleteBuffer
        au!
        au User asyncomplete_setup call asyncomplete#register_source(
            \ asyncomplete#sources#buffer#get_source_options({
            \     'name': 'buffer',
            \     'allowlist': ['*'],
            \     'blocklist': ['go'],
            \     'completor': function('asyncomplete#sources#buffer#completor'),
            \     'config': { 'max_buffer_size': 5000000 },
            \ }))
    augroup END

    " Register neosnippet source
    augroup AsyncompleteNeosnippet
        au!
        au User asyncomplete_setup call asyncomplete#register_source(
            \ asyncomplete#sources#neosnippet#get_source_options({
            \     'name': 'neosnippet',
            \     'allowlist': ['*'],
            \     'completor': function('asyncomplete#sources#neosnippet#completor'),
            \ }))
    augroup END

    " Register file source
    augroup AsyncompleteFile
        au!
        au User asyncomplete_setup call asyncomplete#register_source(
            \ asyncomplete#sources#file#get_source_options({
            \     'name': 'file',
            \     'allowlist': ['*'],
            \     'priority': 10,
            \     'completor': function('asyncomplete#sources#file#completor'),
            \ }))
    augroup END

    " Dictionary completion (using vim-dict) ------------------------------
    " Use Vim native 'dictionary' option with 'complete+=k'
    set complete+=k
    let s:dict_filetypes = [
        \ 'batch', 'c', 'context', 'cpp', 'cs', 'css', 'css3', 'dot',
        \ 'erlang', 'go', 'haskell', 'html', 'java', 'javascript',
        \ 'latex', 'less', 'lua', 'make', 'masm', 'matlab', 'node',
        \ 'perl', 'php', 'plaintex', 'python', 'ruby', 'rust', 'scala',
        \ 'scss', 'sh', 'snippet', 'tex', 'text', 'verilog', 'vim',
        \ 'wiki', 'word', 'xhtml', 'xslt', 'zsh'
        \ ]

    augroup DictComplete
        au!
        for s:ft in s:dict_filetypes
            execute 'autocmd FileType ' . s:ft . ' setlocal dictionary+=' .
                \ s:vim_home . '/bundle/vim-dict/dict/' . s:ft . '.dict'
        endfor
    augroup END

    " Key mappings ------------------------------
    " TAB/S-TAB: navigate popup menu
    inoremap <expr><TAB>   pumvisible() ? "\<C-n>" : "\<TAB>"
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

    " CR: accept completion and close popup
    inoremap <expr><CR> pumvisible() ? asyncomplete#close_popup() : "\<CR>"

    " C-e: cancel popup
    inoremap <expr><C-e> pumvisible() ? asyncomplete#cancel_popup() : "\<C-e>"

    " C-l: force refresh completion
    imap <C-l> <Plug>(asyncomplete_force_refresh)
