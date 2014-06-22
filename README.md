## Color Minder

Remembers last color scheme and sets it for use on vim startup.

### Why?

I normally have a go to color scheme I prefer (currently it's jellybeans) but once in awhile I get bored and want to changes things up and issue a `:colorscheme something_different`.

Problem is that unless I update my .vimrc with this new scheme, subsequent starts of vim load the old color scheme.  But if I update my .vimrc then my git repo managing it is now modified.  Do I commit the change?  Don't really want this permanently.  Don't like having a modifed git repo with only temporary changes.

Plus I use vim-promptline and if I don't update my .vimrc then the nice change of pace to vim's colors that automatically flow to my commnad line are lost when vim starts up with the old color scheme.

Why can't vim just remember what color scheme I was last using and go with that?

Thus Color Minder.

### Features

* No need to update your .vimrc when changing color schemes.
* Remembers seperate color schemes for gui and terminal vim.

### Installation

1) Install with your favorite plugin manager.  If using Pathogen:

    git clone https://github.com/rojspencer/vim-colorminder.git ~/.vim/bundle/vim-colorminder

2) Remove any `colorscheme` calls in your .vimrc.  These will override this plugin and make it rather useless.

3) Recommended: set `g:colorminder_scheme_default_gui` and/or `g:colorminder_scheme_default_term` in your .vimrc

    let g:colorminder_scheme_default_gui = "hybrid"
    let g:colorminder_scheme_default_term = "jellybeans"

The last one ensures that if there hasn't been a previously saved color scheme you won't be staring at vim's 'default' scheme first time you start vim (or starting on a new computer).

### Options

`g:colorminder_scheme_default_gui`

  Default color scheme for gui vim if one has not been previously remembered.
  Will use vim's "default" scheme if not specified.

`g:colorminder_scheme_default_term`

  Default color scheme for terminal vim if one has not been previously remembered.
  Will use vim's "default" scheme if not specified.

`g:colorminder_last_colorscheme_file`

  Path to file to store last used color scheme(s).
  Default: `~/.vim/.colorminder_last_colorscheme`
  If this folder is source controlled in your environment, would be best to specify a different location.
  Example:

    let g:colorminder_last_colorscheme_file = $HOME . "/.last_colorscheme"


