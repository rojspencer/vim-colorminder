" colorminder.vim - Remember last color scheme and use on startup
" Maintainer:   Roger Spencer https://github.com/rojspencer
" Version:      0.0.1


if exists("g:colorminder_loaded") || v:version < 700
  finish
endif
let g:colorminder_loaded = 1

if !exists("colorminder_last_colorscheme")
  let colorminder_last_colorscheme = $HOME."/.vim/.last_colorscheme"
end

function! SaveCurrentColorScheme(file)
  if exists("g:colors_name")
    let mycolorscheme = ["colorscheme ".g:colors_name]
    call writefile(mycolorscheme, a:file)
  end
endfunction
if filereadable(colorminder_last_colorscheme)
  exec "source ".colorminder_last_colorscheme
else
  colorscheme jellybeans
endif
augroup colorminder
  au!
  autocmd ColorScheme * call SaveCurrentColorScheme(colorminder_last_colorscheme)
augroup END

