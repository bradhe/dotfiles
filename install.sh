#!/bin/bash

if [ ! -d ~/.vim ]; then
  mkdir -p ~/.vim/plugins
fi

for f in `ls ./vim/plugins`
do
  echo "Installing $f"
  cp ./vim/plugins/$f ~/.vim/plugins
done

for f in `ls ./vim/syntax`
do
  echo "Installing $f"
  cp ./vim/syntax/$f ~/.vim/syntax
done

echo "Installing .emacs"
cp ./emacs ~/.emacs

echo "Installing .vimrc"
cp ./vimrc ~/.vimrc

grep=`grep "source ~/.dotfiles/bashrc" ~/.bashrc`
if [ "x$grep" == "x" ]; then
  echo "source ~/.dotfiles/bashrc" >> ~/.bashrc
fi

source ~/.bashrc
