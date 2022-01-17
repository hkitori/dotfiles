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

# install terminal app
brew cask install iTerm2

# Powerline Fontsのインストール
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# Nerd Fontsのインストール
git clone --branch=master --depth 1 https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
./install.sh
cd ..
rm -fr nerd-fonts
# この後、手動でiterm1のフォントを"Sauce Code Pro Nerd Font Complete"に設定する

# for gtags
brew install global

# for tmux
brew install reattach-to-user-namespace

# mac command like watch or inotifywait
brew install fswatch

