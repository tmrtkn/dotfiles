#!/bin/bash

SCRIPT=$(readlink -f "$0")
SCRIPT_DIR=$(dirname "$SCRIPT")

FILES=(.bashrc .vimrc .gitconfig .tmux.conf .xinitrc .Xresources)

for file in ${FILES[@]}; do
    if [ -f $file ]; then
    	mv ~/$file ~/$file.original
    fi
    ln -s $SCRIPT_DIR/$file ~/$file
done


if [ -d ~/.config/i3 ]; then
  mv ~/.config/i3 ~/.config/i3.original
fi
mkdir -p ~/.config/
ln -s $SCRIPT_DIR/.config/i3 ~/.config/i3

if [ -d ~/.config/i3status ]; then
  mv ~/.config/i3status ~/.config/i3status.original
fi
mkdir -p ~/.config/
ln -s $SCRIPT_DIR/.config/i3status ~/.config/i3status

if [ -d ~/.config/fontconfig ]; then
  mv ~/.config/fontconfig ~/.config/fontconfig.original
fi
mkdir -p ~/.config/
ln -s $SCRIPT_DIR/.config/fontconfig ~/.config/fontconfig

exit 0
