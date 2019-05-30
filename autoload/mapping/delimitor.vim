"================================================================================
" File Name    : autoload/mapping/delimitor.vim
" Author       : AlanDing
" Created Time : Thu 30 May 2019 08:00:26 PM CST
" Description  : 
"================================================================================
scriptencoding utf-8



function! mapping#delimitor#init() abort " {{{
  " -= += != =~ == <= >= -> => ==# ==? || &&
  " match del space before

  " inoremap <expr> =   MatchDel('=', '\(=\+\)\\|\(>\+\)\\|\(<\+\)\\|\(+\+\)\\|\(-\+\)\\|\(!\+\)\s$')
  inoremap <expr> =   MatchDel('=', '\v(\=+)\|(\>+)\|(\<+)\|(\++)\|(-+)\|(!+)\s$', 1, 11)
  inoremap <expr> \|  MatchDel('\|', '\|\+\s$', 1, 11)
  inoremap <expr> &   MatchDel('&', '&\+\s$', 0, 00)
  inoremap <expr> #   MatchDel('#', '\v(\={2}\s)\|(\=\~\s)\|(!\=\s)\|(!\~\s)', 0, 00)
  inoremap <expr> ?   MatchDel('?', '\v^\s*(let)\|(:\s).*\S\_$', 1, 01)
  inoremap <expr> ~   MatchDel('~', '\v(\=+)\|(!)\s', 1, 11)
  inoremap <expr> >   MatchDel('>', '\v(\>+)\|(\=)\|(-)\|(\<\w*)\s$', 1, 11)

  " match add space before
  inoremap <expr> -   MatchDel('-', '\v^\s*(if\|el\|wh\|let\|val\|var).*\S$', 1, 00)
  inoremap <expr> +   MatchDel('+', '0000', 1, 11)
  inoremap <expr> !   MatchDel('!', '\v^\s*((if\|el\|wh\|let\|val\|var).*\S$)\|((if\|el\|wh)$)', 0, 01)
  inoremap <expr> :   (CurChar(0, '\s') \|\| CurChar(0, '\w') \|\| Curchar(0, '\d')) ? ': ' : Within('pair') ? ':' : ' : '
  inoremap <expr> <   MatchDel('<', '\v^\s*(if\|el\|wh\|let).*\S$', '>')
  inoremap <expr> ,   CurChar(0, '\s') ? "\<BS>,\<Space>" : (CurChar(1, '\s') ? "," : ",\<Space>")

  call s:AutoPairs()
  call s:Numfix()

  augroup Delimitor_init
    auto!
    autocmd  FileType c,cpp    let b:eol_marker = ';'

    autocmd  FileType sh       call <sid>Bash()

    autocmd  FileType vim
                 \ inoremap <buffer><expr> "  MatchCl('\v(^\_$)\|(^\s*\w*\s\_$)\|(^\s+\_$)') ? "\"\<Space>" : AutoClo('"')|
                 \ inoremap <buffer><expr> :  MatchCl('\v\s(s)\|(g)\|(a)\|(l)\|(\S\W\s)$')
                 \ ? ':' : Within('pair') ? ':' : CurChar(0, '\s') ? ': ' : ' : '

    autocmd  FileType markdown  call <sid>AutoPairs({'《':'》'}, 2) | call <sid>AutoPairs('*', 1)
  augroup END
endfunction
" }}}


function! s:AutoPairs(...) abort " {{{
  let single = extend(["'", '"', '`'], a:0 && a:000[-1] == 1 ? [a:1] : [])
  for r in single
    exec 'inoremap <expr> '.r.' AutoClo('.string(r).')'
  endfor

  let autopairs = extend({'(':')', '[':']', '{':'}'}, a:0 && a:000[-1] == 2 ? a:1 : {})
  for [l, r] in items(autopairs)
    exec 'inoremap <expr> '.l.' AutoClo('.string(l).', '.string(r).')'
    exec 'inoremap <expr> '.r.' AutoClo('.string(l).', '.string(r).', 1)'
  endfor
endfunction " }}}


function! s:Numfix() abort " {{{
  for num in range(1, 9)
    exec 'inoremap <expr> '.num.' MatchDel('.num.", '\\v.*\\s\\W*\\s\-\\s$')"
  endfor
endfunction " }}}


function! s:Bash() abort " {{{
  for char in ['d', 'e', 'f', 'z', 'n', 'r', 'i']
    exec 'inoremap <buffer><expr> '.char.' MatchDel('.string(char).', ".*-\\s_$", 0, 00)'
  endfor
endfunction "}}}


