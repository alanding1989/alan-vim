"================================================================================
" Description: Vim config file
" Section:     config/Vim
"================================================================================
scriptencoding utf-8



" Themes list " {{{
let g:my_cs = split([
      \ '0 gruvbox'     ,
      \ '1 one'         ,
      \ '2 onedark'     ,
      \ '3 palenight'   ,
      \ '4 neodark'     ,
      \ '5 OceanicNext' ,
      \ '6 NeoSolarized',
      \ '7 PaperColor'  ,
      \ '8 nord'        ,
      \ '9 default'     ,
      \ ][4])[1]
let g:my_bg = 1 ? 'dark' : 'light'
"}}}

"================================================================================
" Preferences:
"================================================================================
let g:autocomplete_method           = get(['coc'       , 'deoplete' , 'ncm2'], 0)
let g:snippet_engine                = get(['neosnippet', 'ultisnips', 'coc' ], 0)
let g:fuzzyfinder                   = get(['leaderf'   , 'denite'   , 'fzf' ], 0)
let g:filemanager                   = get(['vimfiler'  , 'nerdtree' , 'defx'], 0)
let g:gitgutter_plugin              = get(['coc'       , 'vim-gitgutter'    ], 0)
let g:checker                       = 1 ? 'ale'     : 'neomake'
let g:statusline                    = 1 ? 'airline' : 'lightline'
let g:lint_on_the_fly               = 1
let g:format_on_save                = 1
let g:enable_deotabline             = 0
let g:enable_googlesuggest          = 0
" Choose minimal setting
let g:pure_viml = 0


" Ui {{{
let g:enable_fat_statusline         = 1
let g:statusline_separator          = get(['fire', 'arrow', 'curve', 'slant'], 1)
" }}}

" System {{{
let g:enable_checkinstall          = 1
"}}}

" Var {{{
function! MyVim_layers_variable(layer) abort
  return get({
        \ 'lang#scala' : {
        \     'format_on_save'            : 1,
        \     'formatter_scalariform_path': g:is_win
        \         ? 'D:\devtools\scala\scalariform.jar'
        \         : '/opt/lang-tools/scala/scalariform.jar'
        \ },
        \ 'lsp' : { 'filetypes': extend([
        \     'python'    ,
        \     'ipynb'     ,
        \     'javascript',
        \     'vim'       ,
        \     ], g:is_unix ? ['sh'] : []
        \ )},
        \ 'defhighlight' : {
        \     'enable_vim_highlight' : 0,
        \     'hlcolor'  : g:_defhighlight_var.hlcolor
        \ }
        \ }, a:layer, {})
endfunction
"}}}


"================================================================================
" Layers Enable:
"   DefaultLayers:
"   autocomplete,  checkers,  core,  edit,  format,  leaderf
"============================================================================= {{{
let g:MyVim_layers = {
      \ 'git'               : 1,
      \ 'lsp'               : 1,
      \ 'langtools'         : 1,
      \ 'tags'              : 1,
      \ 'tools'             : 1,
      \ 'lang#markdown'     : 1,
      \ 'lang#ipynb'        : 0,
      \ 'lang#python'       : 1,
      \ 'lang#latex'        : 0,
      \ 'lang#scala'        : 0,
      \ 'lang#vim'          : 1,
      \ 'lang#ps1'          : g:is_win,
      \ 'tools#clock'       : 1,
      \
      \ 'denite'            : 0,
      \ 'leaderf'           : 1,
      \
      \ 'chinese'           : 1,
      \ 'VersionControl'    : 0,
      \ }

if g:fuzzyfinder ==# 'leaderf' " {{{
      \ && g:MyVim_layers['leaderf']
  let g:MyVim_layers['leaderf'] = 1
  let g:MyVim_layers['denite']  = 0
elseif g:fuzzyfinder ==# 'denite'
  let g:MyVim_layers['denite']  = 1
  let g:MyVim_layers['leaderf'] = 0
elseif g:fuzzyfinder ==# 'fzf'
  let g:MyVim_layers['fzf']     = 1
  let g:MyVim_layers['denite']  = 0
  let g:MyVim_layers['leaderf'] = 0
endif "}}}

if g:autocomplete_method ==# 'coc' " {{{
  let g:snippet_engine = 'coc'
  let g:gitgutter_plugin = 'coc'
else
  let g:gitgutter_plugin = 'vim-gitgutter'
endif
"}}}

if g:pure_viml || !g:has_py " {{{
  let g:autocomplete_method = 'asyncomplete'
  let g:snippet_engine      = 'neosnippet'
  let g:filemanager         = 'vimfiler'
  let g:enable_smart_clock  = 0
  let g:MyVim_layers = {
        \ 'colorscheme'     : 1,
        \ 'tags'            : 1,
        \ 'tools'           : 1,
        \ 'lsp'             : 1,
        \ 'lang#scala'      : 0,
        \ 'lang#python'     : 1,
        \ 'lang#vim'        : 1,
        \ 'ui'              : 1,
        \ 'unite'           : 1,
        \ }
endif "}}}
"}}}


"================================================================================
" Disabled Plugins:
"============================================================================= {{{
" let g:disabled_plugins = [
      " \ '',
      " \ ]
"}}}

