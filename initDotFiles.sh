#!/bin/bash

SCRIPT=$(readlink -f "$0")
SCRIPT_DIR=$(dirname "$SCRIPT")

FILES=(.bashrc .vimrc .gitconfig .tmux.conf)

for file in ${FILES[@]}; do
    if [ -f $file ]; then
    	mv ~/$file ~/$file.original
    fi
    ln -s $SCRIPT_DIR/$file ~/$file
done

exit 0
