" ================================================================================
" leaderf settings
" ================================================================================
scriptencoding utf-8
if get(s:, 'loaded', 0)
  finish
endif
let s:loaded = 1


let g:Lf_StlColorscheme       = 'default'
" let g:Lf_StlColorscheme       = 'powerline'
if get(g:, 'spacevim_colorscheme', get(g:, 'my_cs')) ==# 'gruvbox'
  let g:Lf_StlColorscheme       = 'spacevim'
endif

let g:Lf_ShortcutF            = '<leader>ff'
let g:Lf_ShortcutB            = '<leader>fb'
let g:Lf_DefaultMode          = 'NameOnly'
let g:Lf_PreviewResult        = {'BufTag': 0, 'Function': 0}
let g:Lf_WindowHeight         = 0.3
let g:Lf_CursorBlink          = 1
let g:Lf_ShowRelativePath     = 0
let g:Lf_HideHelp             = 0
let g:Lf_StlSeparator         = { 'left': '', 'right': '' }

" let g:Lf_GtagsAutoGenerate    = g:is_nvim ? 1 : 0
let g:Lf_Gtagsconf            = expand('~/.globalrc')
let g:Lf_Gtagslabel           = 'native-pygments'
let g:Lf_CacheDirectory       = expand('~/.cache')
let g:Lf_RootMarkers          = deepcopy(g:project_root_marker)
let g:Lf_WorkingDirectoryMode = 'Ac'
" <C-X> : open in horizontal split window.
let g:Lf_CommandMap           = {
      \ '<del>'  : ['<c-d>'],
      \ '<bs>'   : ['<c-h>'],
      \ '<home>' : ['<c-a>'],
      \ '<left>' : ['<c-b>'],
      \ '<right>': ['<c-l>'],
      \ '<c-]>'  : ['<c-i>'],
      \ '<tab>'  : ['<c-o>'],
      \ }
" ESC directly quit leaderf normal mode
let g:Lf_NormalMap = {
      \ 'File'    : [['<ESC>', ':exec g:Lf_py "fileExplManager.quit()"<CR>'    ]],
      \ 'Buffer'  : [['<ESC>', ':exec g:Lf_py "bufExplManager.quit()"<cr>'     ]],
      \ 'Mru'     : [['<ESC>', ':exec g:Lf_py "mruExplManager.quit()"<cr>'     ]],
      \ 'Tag'     : [['<ESC>', ':exec g:Lf_py "tagExplManager.quit()"<cr>'     ]],
      \ 'BufTag'  : [['<ESC>', ':exec g:Lf_py "bufTagExplManager.quit()"<cr>'  ]],
      \ 'Function': [['<ESC>', ':exec g:Lf_py "functionExplManager.quit()"<cr>']],
      \ }
let g:Lf_RgConfig   = [
      \ '--max-columns=150',
      \ '--type-add web:*.{html,css,js}*',
      \ '--glob=!git/*',
      \ '--hidden'
      \ ]
let g:Lf_WildIgnore = {
      \ 'dir' : ['.svn','.git','.hg','.vscode'],
      \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
      \}
let g:Lf_MruFileExclude = [
      \ '*.so', '*.exe', '*.py[co]', '*.sw?',
      \ '~$*', '*.bak', '*.tmp', '*.dll'
      \ ]
