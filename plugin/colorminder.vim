" colorminder.vim - Remember last color scheme and use on startup
" Maintainer:   Roger Spencer https://github.com/rojspencer
" Version:      0.0.1


if exists("g:colorminder_loaded") || v:version < 700
  finish
endif
let g:colorminder_loaded = 1
let s:script_folder_path = escape( expand( '<sfile>:p:h' ), '\' )
let s:vim_folder_path = s:script_folder_path . '/../../../'

if !exists("s:last_colorscheme_file")
  let s:last_colorscheme_file = s:vim_folder_path.".last_colorscheme"
end

function! SaveCurrentColorScheme(file)
  if exists("g:colors_name")
    let mycolorscheme = ["colorscheme ".g:colors_name]
    call writefile(mycolorscheme, a:file)
  end
endfunction
if filereadable(s:last_colorscheme_file)
  exec "source ".s:last_colorscheme_file
else
  colorscheme jellybeans
endif
augroup colorminder
  au!
  autocmd ColorScheme * call SaveCurrentColorScheme(s:last_colorscheme_file)
augroup END

