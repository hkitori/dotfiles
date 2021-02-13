#!/bin/sh -eux

sudo apt update

# packages
sudo apt -y install peco
sudo apt -y install tmux
sudo apt -y install tig
sudo apt -y install expect
sudo apt -y install nkf
sudo apt -y install shellcheck

# code reading
sudo apt -y install global # for gtags
sudo apt -y install exuberant-ctags

# hdmi
sudo apt -y install cec-utils # for cec-client


# change login shell bash to zsh
sudo apt -y install zsh
sudo chsh -s $(which zsh) pi
if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
fi

reboot

