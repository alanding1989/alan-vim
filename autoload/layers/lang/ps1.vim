"=============================================================================
" powershell.vim lang#powershell layer
" Parent Section: layers
"=============================================================================
scriptencoding utf-8


""
" @section lang#powershell, layer-lang-powershell
" @parentsection layers
" To make this layer work well, you should install Windows PowerShell.
" @subsection mappings
" >
"   mode        key         function
"   -------------------------------------------------------------
"   normal      SPC l h     show Documentation of cursor symbol
"   normal      SPC l e     rename cursor symbol
"   normal      SPC l r     find reference of cursor symbol
" <


function! layers#lang#ps1#plugins() abort
  let plugins = []
  if get(g:, 'spacevim_autocomplete_method', get(g:, 'autocomplete_method', 'deoplete')) ==# 'coc'
    call add(plugins, ['yatli/coc-powershell', { 'do': { -> coc#powershell#install({ "preview": 1, "PowerShellExecutable": "pwsh"})}}])
    if g:is_spacevim && g:spacevim_plugin_manager ==# 'dein'
      if g:is_nvim && glob(g:spacevim_plugin_bundle_dir.'.cache/init.vim/.dein/PowerShellEditorServices') ==# ''
        auto VimEnter * call coc#powershell#install("preview")
      elseif g:is_vim8 && glob(g:spacevim_plugin_bundle_dir.'.cache/vimrc/.dein/PowerShellEditorServices') ==# ''
        auto VimEnter * call coc#powershell#install("preview")
      endif
    elseif !g:is_spacevim && g:plugmanager ==# 'dein'
      if g:is_nvim && glob(g:My_Vim_plug_dir.'.cache/init.vim/.dein/PowerShellEditorServices') ==# ''
        auto VimEnter * call coc#powershell#install("preview")
      elseif g:is_vim8 && glob(g:My_Vim_plug_dir.'.cache/vimrc/.dein/PowerShellEditorServices') ==# ''
        auto VimEnter * call coc#powershell#install("preview")
      endif
    endif
  endif
  if !g:is_spacevim
    " syntax highlighting and indent
  call add(plugins, ['PProvost/vim-ps1'])
  endif
  return plugins
endfunction


function! layers#lang#ps1#config() abort
  if g:is_spacevim
    call SpaceVim#mapping#gd#add('ps1', function('s:go_to_def'))
    call SpaceVim#mapping#space#regesit_lang_mappings('ps1', function('s:language_specified_mappings'))
  else
    augroup layer_lang_powershell
      autocmd!
      auto FileType ps1
            \ call <sid>language_specified_mappings() |
            \ call <sid>go_to_def()
    augroup END
  endif
endfunction


if g:is_spacevim
  function! s:language_specified_mappings() abort
    if g:spacevim_autocomplete_method ==# 'coc'
      nnoremap <silent><buffer> K :call SpaceVim#lsp#show_doc()<CR>

      call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'h'],
            \ 'call SpaceVim#lsp#show_doc()', 'show_document', 1)
      call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'e'],
            \ 'call SpaceVim#lsp#rename()', 'rename symbol', 1)
      call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'r'],
            \ 'call SpaceVim#lsp#references()', 'find references', 1)
    endif
  endfunction
else
  function! s:language_specified_mappings() abort
    if g:autocomplete_method ==# 'coc'
      nnoremap <silent><buffer> K  :call layers#lsp#show_doc()<CR>
      nnoremap <silent><buffer> gd :call s:go_to_def()<CR>

      nnoremap <silent><buffer> <space>lh  :call layers#lsp#show_doc()<CR>
      nnoremap <silent><buffer> <space>le  :call layers#lsp#rename()<CR>
      nnoremap <silent><buffer> <space>lr  :call layers#lsp#references()<CR>
    endif
  endfunction
endif

if g:is_spacevim
  function! s:go_to_def() abort
    if g:spacevim_autocomplete_method ==# 'coc'
      call SpaceVim#lsp#go_to_def()
    endif
  endfunction
else
  function! s:go_to_def() abort
    if g:autocomplete_method ==# 'coc'
      call layers#lsp#go_to_def()
    endif
  endfunction
endif