#!/bin/sh

# setup vim
#DEIN_DIR="${HOME}/.cache/dein"
#mkdir -p ${DEIN_DIR}
#cd ${DEIN_DIR}
#curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
#sh ./installer.sh ${DEIN_DIR}
#cd -


brew install global # for gtags


# install pip
sudo easy_install pip
# upgrade pip
curl https://bootstrap.pypa.io/get-pip.py | python


brew install ag

