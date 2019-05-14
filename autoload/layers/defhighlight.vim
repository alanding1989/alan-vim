"================================================================================
" File Name    : autoload/layers/defhighlight.vim
" Author       : AlanDing
" mail         : 
" Created Time : Mon 13 May 2019 09:37:00 PM CST
"================================================================================
scriptencoding utf-8



function! layers#defhighlight#plugins() abort
  return
endfunction


function! layers#defhighlight#config() abort
  if len(s:hlcolor) > 0
    for [ft, colors] in items(s:hlcolor)
      exec 'auto FileType '.ft.' call s:highlight_apply('.string(ft).', '.string(colors).')'
    endfor
  endif
endfunction


let s:hlcolor    = {}
function! layers#defhighlight#set_variable(var) abort
  " [ guifg, guibg, ctermfg, ctermbg, italic], -1 if None or negative
  let s:hlcolor = get(a:var, 'hlcolor', {})
endfunction


let s:hlcmds = {}
function! s:highlight_apply(ft, colors) abort
  let ftcmds = {}
  let ftcmds[a:ft] = []
  for [group, attr_val] in items(a:colors)
    call add(ftcmds[a:ft], <sid>hl_one(group, attr_val))
  endfor
  call extend(s:hlcmds, ftcmds)
endfunction

function! s:hl_one(group, attr_val) abort
  let attrs = {
        \ 'guifg'   : 0,
        \ 'guibg'   : 1,
        \ 'ctermfg' : 2,
        \ 'ctermbg' : 3,
        \ 'italic'  : 4
        \ }
  let strlist = []
  for [attr, idx] in reverse(items(attrs))
    if idx != 4
      let cmd = a:attr_val[idx] != -1 ? attr. '=' .a:attr_val[idx] : ''
      call add(strlist, cmd)
    else
      let cmdi = a:attr_val[4] ? 'gui=italic cterm=italic' : ''
    endif
  endfor
  call add(strlist, cmdi)
  exec 'hi! '. a:group .' '. join(strlist, ' ')

  " format hlcmds
  let hlcmd = a:group .repeat(' ', 20-len(a:group)). join(strlist, ' ')
  return hlcmd
endfunction

function! layers#defhighlight#test_highlightcmds(...) abort
  let hlcmds = get(s:, 'hlcmds', {})
  if len(hlcmds) == 0
    let fts = join(keys(s:hlcolor), ' ')
    echohl WarningMsg
    echo ' No customized highlight' 
          \ . (empty(fts) ? '' : ', have you already opened a '. fts .' file ?')
    echohl NONE
    return
  endif
  topleft vsplit _Custom_Highlight_Cmds_
  nnoremap <silent><buffer> q  :q<CR>
  nnoremap <silent><buffer> qq :bd<CR>
  setlocal buftype=nofile nolist noswapfile nowrap cursorline nospell
  setlocal filetype=defhighlight
  let str = []
  if a:0 > 0
    let ft = toupper(a:1[0]) . a:1[1:]
    let info = [
          \ '',
          \ ft .' Highlight Commands :',
          \ '',
          \ ]
    let str = info + hlcmds[a:1]
  else
    for [ft, list] in items(hlcmds)
      let ft = toupper(ft[0]) . ft[1:]
      let info = [
            \ '',
            \ ft .' Highlight Commands :',
            \ '',
            \ ]
      let str = str + info + list
    endfor
  endif
  call setline(1, str)
  setl nomodifiable
endfunction
