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

function! s:file_contents()
  call s:set_scheme_vars()
  return [
    \'let g:colorminder_scheme_gui = "' . g:colorminder_scheme_gui . '"',
    \'let g:colorminder_scheme_term = "' . g:colorminder_scheme_term . '"',
    \'if has("gui")',
    \'  colorscheme ' . g:colorminder_scheme_gui,
    \'else',
    \'  colorscheme ' . g:colorminder_scheme_term,
    \'end']
endfunction

function! s:set_scheme_vars()
  if !exists("g:colors_name")
    let s:colors_name = 'jellybeans'
  else
    let s:colors_name = g:colors_name
  end

  if has("gui")
    let g:colorminder_scheme_gui = s:colors_name
  else
    let g:colorminder_scheme_term = s:colors_name
  end

  if !exists("g:colorminder_scheme_gui")
    if exists("g:colorminder_scheme_term")
      let g:colorminder_scheme_gui = g:colorminder_scheme_term
    else
      let g:colorminder_scheme_gui = g:colors_name
    end
  end
  if !exists("g:colorminder_scheme_term")
    if exists("g:colorminder_scheme_gui")
      let g:colorminder_scheme_term = g:colorminder_scheme_gui
    else
      let g:colorminder_scheme_term = g:colors_name
    end
  end
endfunction

function! ColorminderSaveCurrentColorScheme(file)
  let file_contents = s:file_contents()
  call writefile(file_contents, a:file)
endfunction

if filereadable(s:last_colorscheme_file)
  exec "source ".s:last_colorscheme_file
else
  colorscheme jellybeans
endif

augroup colorminder
  au!
  autocmd ColorScheme * call ColorminderSaveCurrentColorScheme(s:last_colorscheme_file)
augroup END

