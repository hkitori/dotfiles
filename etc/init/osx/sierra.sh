#!/bin/sh

# setup vim
DEIN_DIR="${HOME}/.vim/dein_cache/"
mkdir -p ${DEIN_DIR}
cd ${DEIN_DIR}
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ${DEIN_DIR}
cd -
