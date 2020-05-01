#!/bin/sh

# setup vim
mkdir -p ~/.vim/deain_cache/
cd ~/.cache/dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.vim/dein_cache/
cd ../
