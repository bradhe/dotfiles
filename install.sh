#!/bin/bash
#

current_user=`whoami`

install_directory() {
  local from_dir=$1
  local to_dir=$2
  local base_dir=$(dirname $to_dir)

  if [ ! -w $base_dir ]; then
    sudo mkdir -p $to_dir
    sudo chown $current_user $base_dir
  fi

  if [ ! -d $to_dir ]; then
    mkdir -p $to_dir
  fi

  for f in `ls $from_dir`
  do
    echo "Installing $to_dir/$f"
    cp -R $from_dir/$f $to_dir/
  done
}

install_file() {
  local from_file=$1
  local to_file=$2

  echo "Installing file $to_dir/$f"
  cp $from_file $to_file
}

# Get the latest submodules.
git submodule update --init

if [ ! -d ~/.vim ]; then
  mkdir -p ~/.vim/plugins
fi

install_directory ./vim ~/.vim
install_directory ./scripts ~/scripts

#
# Install all the emacs modes.
#
mkdir -p ~/.emacs.d/modes

for f in `ls emacs/rspec-mode/*.el`
do
    install_file $f ~/.emacs.d/modes/
done

for f in `ls emacs/ruby-mode/*.el`
do
    install_file $f ~/.emacs.d/modes/
done

for f in `ls emacs/emacs-starter-kit/*.el`
do
    install_file $f ~/.emacs.d/modes/
done

for f in `ls ./dots`;
do
  echo "Installing .$f"
  cp -r ./dots/$f $HOME/.$f
done

source ~/.bashrc
