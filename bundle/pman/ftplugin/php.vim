" Vim filetype plugin
" Language:		PHP
" Maintainer:		Bèr Kessels (ber@webschuur.com)
" URL:			
" Anon CVS:		
" ----------------------------------------------------------------------------

" Thanks to ruby.vim for some great ideas.

set ballooneval

if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1

" To activate, :set ballooneval
if has('balloon_eval') && exists('+balloonexpr')
  setlocal balloonexpr=PmanBalloonexpr()
endif

function! PmanBalloonexpr()
  let str = v:beval_text
  " @TODO write regular expressions to detect if hovered item matches the
  " pattern for a function. 
  return system("pman ".str)
  " @TODO write a parser to make output denser.
endfunction
