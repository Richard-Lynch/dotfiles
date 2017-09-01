function! FindInc()
  let oldPath=&path
  set path=$PWD/**

  exe ":find " t:newIncSw

"Will do this just in time when needed
"  let t:newIncSw=expand('%:p')

  let &path=oldPath
endfun

function! CurtineIncSw()
  " Switch from *.c* to *.h* and vice versa

  if exists("t:oldIncSw") && expand("%:t:r") == fnamemodify(t:oldIncSw, ":t:r")
    let t:newIncSw=t:oldIncSw
    let t:oldIncSw=expand("%:p")
    exe "e " t:newIncSw
    return 0
  endif
" the below statements were edited to force a switch between cpp and h -
" Richard Lynch 28/6/17
  if match(expand("%"), '\.cpp') > 0
    let t:newIncSw=substitute(expand("%:t"), '\.cpp', '.h\1', "")
  elseif match(expand("%"), "\\.h") > 0
    let t:newIncSw=substitute(expand("%:t"), '\.h', '.cpp\1', "")
  else
      "echoerr 'it done failed'
      echomsg 'swap cpp to h only'
      "echo 'nope'
      return -1 " added by RL so no error is thrown if no file exists
  endif

  call FindInc()
endfun
