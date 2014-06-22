" colorminder.vim - Remember last color scheme and use on startup
" Maintainer:   Roger Spencer https://github.com/rojspencer
" Version:      0.0.1


if exists("g:colorminder_loaded") || v:version < 700
  finish
endif

let g:colorminder_loaded = 1
let g:colorminder_set_colorscheme = 1
let s:script_folder_path = escape( expand( '<sfile>:p:h' ), '\' )
let s:vim_folder_path = s:script_folder_path . '/../../../'

function! s:get_last_colorscheme_file()
  if !exists("g:colorminder_last_colorscheme_file")
    return s:vim_folder_path.".colorminder_last_colorscheme"
  end
  return g:colorminder_last_colorscheme_file
endfunction

let s:last_colorscheme_file = s:get_last_colorscheme_file()

function! s:file_contents()
  call s:set_scheme_vars()
  if exists("g:colorminder_scheme_gui")
    let gui_scheme = g:colorminder_scheme_gui
  elseif exists("g:colorminder_scheme_default_gui")
    let gui_scheme = g:colorminder_scheme_default_gui
  end

  if exists("g:colorminder_scheme_term")
    let term_scheme = g:colorminder_scheme_term
  elseif exists("g:colorminder_scheme_default_term")
    let term_scheme = g:colorminder_scheme_default_term
  end

  let contents = []
  if exists("term_scheme")
    let contents += ['let g:colorminder_scheme_term = "' . term_scheme . '"']
  end
  if exists("gui_scheme")
    let contents += ['let g:colorminder_scheme_gui = "' . gui_scheme . '"']
  end

  let contents += ['if g:colorminder_set_colorscheme == 1']

  if exists("gui_scheme") && exists("term_scheme")
    let contents += [
      \'  if has("gui_running")',
      \'    colorscheme ' . gui_scheme,
      \'  else',
      \'    colorscheme ' . term_scheme,
      \'  end']
  else
    if exists("gui_scheme")
      let contents +=  ['  colorscheme ' . gui_scheme]
    elseif exists("term_scheme")
      let contents += ['  colorscheme ' . term_scheme]
    end
  end

  let contents += ['end']

  return contents

endfunction

function! s:set_scheme_vars()
  if exists("g:colors_name")
    let s:colors_name = g:colors_name
  else
    echoerr "current colorscheme does not set g:colors_name - not remembering"
    return 0
  end

  " source .colorminder_last_colorscheme without reseting colorscheme
  " in case another instance that is gui and we're not
  " or vice/versa has changed it's color scheme
  let g:colorminder_set_colorscheme = 0
  if filereadable(s:last_colorscheme_file)
    exec "source ".s:last_colorscheme_file
  end
  let g:colorminder_set_colorscheme = 1

  if has("gui_running")
    let g:colorminder_scheme_gui = s:colors_name
  else
    let g:colorminder_scheme_term = s:colors_name
  end

endfunction

function! ColorminderSaveCurrentColorScheme()
  let file_contents = s:file_contents()
  call writefile(file_contents, s:last_colorscheme_file)
endfunction

if filereadable(s:last_colorscheme_file)
  exec "source ".s:last_colorscheme_file
else
  " see if defaults are set and use those
  if has("gui_running")
    if exists("g:colorminder_scheme_default_gui")
      exec 'colorscheme ' . g:colorminder_scheme_default_gui
      call ColorminderSaveCurrentColorScheme()
    end
  else
    if exists("g:colorminder_scheme_default_term")
      exec 'colorscheme ' . g:colorminder_scheme_default_term
      call ColorminderSaveCurrentColorScheme()
    end
  end
endif

augroup colorminder
  au!
  autocmd ColorScheme * call ColorminderSaveCurrentColorScheme()
augroup END

