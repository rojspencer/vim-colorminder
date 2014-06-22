## Color Minder

Remembers last color scheme and sets it for use on vim startup.

### Why?

I normally have a go to color scheme I prefer (currently it's jellybeans) but once in awhile I get bored and want to changes things up and issue a `:colorscheme something_different`.

Problem is that unless I update my .vimrc with this new scheme, subsequent starts of vim load the old color scheme (which tends to happen frequently switching between multiple projects).  But if I update my .vimrc then my git repo managing it is now modified with something I probably don't want to keep permanently.

Plus I use vim-promptline and if I don't update my .vimrc then the nice change of pace to vim's colors that automatically flow to my commnad line are lost when vim starts up with the old color scheme.

My .vimrc ended up with crap like this:

    " colorscheme hybrid
    " colorscheme codeschool
    " I like JellyBeans for now
    colorscheme jellybeans
    " colorscheme base16-brewer
    " colorscheme badwolf
    " Let's go with my forked Ubaryd for now
    " colorscheme ubaryd
    " How about code school (set AirlineTheme to base16)
    " colorscheme codeschool
    " let g:hybrid_use_iTerm_colors = 1
    " colorscheme hybrid
    " colorscheme Tomorrow

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

This ensures that if there hasn't been a previously saved color scheme you won't be staring at vim's 'default' scheme first time you start vim (or starting on a new computer).  If you don't mind seeing the default color scheme until you change it for the first time then don't bother setting these.

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


### Issues

Does not handle any additional settings a color scheme may require.  For example, if a theme has both dark and light versions and that is controlled by
setting background, you will have to ensure background is set in your .vimrc per your preference.

This plugin relies on the chosen color scheme setting `g:colors_name`.  If the color scheme fails to set this then things will not work.  There is an
attempt to shoot out a warning if a color scheme is not setting `g:colors_scheme`.

Some color themes have multiple variations but don't update `g:colors_name` to reflect those.  For example, the [sol](https://github.com/Pychimp/vim-sol.git) theme as 'sol' and 'sol-term'.  If you set `:colorscheme sol-term` `g:colors_name` is only updated to be 'sol' and that's what gets remembered.  Not sure if there is anything I can do about that.

This was my first vim plugin.  Was fun learning how to do this but things may not be perfect.
