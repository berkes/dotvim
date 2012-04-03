My vim settings.

# Installation:

    git clone git://github.com/berkes/dotvim.git ~/.vim

Create symlinks:

    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/gvimrc ~/.gvimrc

Switch to the `~/.vim` directory, and fetch submodules:

    cd ~/.vim
    git submodule init
    git submodule update

# Contents:

* ack.vim               Search strings in project
* bufkill               Unload/delete/wipe a buffer, keep its window(s), display last accessed buffer(s)
* command-t             Open files by pattern
* dbgpclient            PHP Xdebug debugger
* nerdcommenter         Fast commenting sourcecode
* nerdtree              File drawer
* rails                 Ruby on Rails utilities
* supertab              Tab autocomplete based on opened files
* unimpaired            Handy bracket mapping, mostly for bubbling text
* UltiSnips             Snippets
* vim-colors-solarized  Solarized colorscheme
* vim-powerline         Powerline that looks pretty

# Vimrc and customisations:

* Bubble text up and down with c-arrows
* Set common Rails files to filetype Ruby
* Set common Drupal files to filetype Drupal and PHP

# Changelog

* di apr  3  - 0.1 - Seems stable enough for a first release
