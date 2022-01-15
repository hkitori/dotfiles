#!/bin/sh

brew install peco
brew install tmux

# setup vim
#DEIN_DIR="${HOME}/.cache/dein"
#mkdir -p ${DEIN_DIR}
#cd ${DEIN_DIR}
#curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
#sh ./installer.sh ${DEIN_DIR}
#cd -


# molokai for vim
mkdir -p ~/.vim/colors
git clone https://github.com/tomasr/molokai ~/.vim/colors/
mv ~/.vim/colors/molokai/colors/molokai.vim ~/.vim/colors/molokai.vim

brew install global # for gtags

# for tmux
brew install reattach-to-user-namespace

# mac command like watch or inotifywait
brew install fswatch
