#!/bin/bash
#
# This script pulls in updates made to the files in situ so they can be checked
# in and updated up stream.
#

#
# Actual dotfiles
#
cp $HOME/.vimrc dots/vimrc
cp $HOME/.bashrc dots/bashrc
cp $HOME/.profile dots/profile
cp $HOME/.emacs dots/emacs
cp $HOME/.gitconfig dots/gitconfig
cp $HOME/.gitignore_global dots/gitignore_global

#
# VIM and Emacs crap
#
cp -r $HOME/.vim/ vim
cp -r $HOME/.emacs.d/ emacs

#
# Now we'll nuke .git directories, since we don't need 'em any more.
find . -type d | grep \.git$ | grep -v ./.git | grep -v ./git | xargs -I {} rm -rf {}
