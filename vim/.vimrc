set laststatus=2
"if filereadable($HOME . "/.local/lib/python2.7/site-packages/powerline_status-2.6.dist-info/metadata.json") || filereadable("/usr/local/lib/python2.7/site-packages/powerline_status-2.6.dist-info/metadata.json")
"  python from powerline.vim import setup as powerline_setup
"  python powerline_setup()
"  python del powerline_setup
"else
"  python3 from powerline.vim import setup as powerline_setup
"  python3 powerline_setup()
"  python3 del powerline_setup
"endif
set timeoutlen=1000 ttimeoutlen=0

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 15

"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"  autocmd VimEnter * :wincmd l
"augroup END

set mouse=a
set hlsearch
set incsearch


fun! VexToggle(dir)
  if exists("t:vex_buf_nr")
    call VexClose()
  else
    call VexOpen(a:dir)
  endif
endf

fun! VexOpen(dir)
  let g:netrw_browse_split = 4
  let vex_width = 25

  execute "Vexplore " . a:dir
  let t:vex_buf_nr = bufnr("%")
  wincmd H

  call VexSize(vex_width)
endf

fun! VexClose()
  let cur_win_nr = winnr()
  let target_nr = ( cur_win_nr == 1 ? winnr("#") : cur_win_nr )

  1wincmd w
  close

  unlet t:vex_buf_nr

  execute (target_nr - 1) . "wincmd w"
  call NormalizeWidths()
endf

fun! VexSize(vex_width)
  execute "vertical resize" . a:vex_width
  set winfixwidth
  call NormalizeWidths()
endf

fun! NormalizeWidths()
  let eadir_pref = &eadirection
  set eadirection=hor
  set equalalways! equalalways!
  let &eadirection = eadir_pref
endf

noremap <Tab> :call VexToggle(getcwd())<CR>
noremap ` :call VexToggle("")<CR>
