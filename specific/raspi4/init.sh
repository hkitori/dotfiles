#!/bin/sh -eux

# change password for user pi
sudo passwd pi

# country
sudo raspi-config nonint do_wifi_country JP
sudo raspi-config nonint do_change_timezone Asia/Tokyo
sudo raspi-config nonint do_change_locale en_US.UTF-8

# hdmi_group = 1 : CEA
# hdmi_mode = 16  : 1920x1080 @ 60Hz, progressive
sudo raspi-config nonint do_resolution 1 16
# hdmi_mode = 97  : 3840x2160 @ 60Hz, progressive
# 97 is Raspberry Pi 4 Only. To use this,
# hdmi_enable_4kp60=1 must be set in /boot/config.txt.

# add gpu_mem=512 [MB]
sudo raspi-config nonint do_memory_split 512
# comment out disable_overscan
sudo raspi-config nonint do_overscan 0
# turn off blanking
sudo raspi-config nonint do_blanking 1


sudo apt update
sudo apt -y upgrade
sudo apt -y upgrade vim

# Install font for programming
sudo apt -y install fonts-ricty-diminished

# google JP fonts
sudo apt -y install fonts-noto

# input method for JP
# You need also the following manual setting with GUI:
#   [Step1]
#     Menu -> Preferences -> Ibus Preferences
#     -> General -> Use custom font:
#        Noto Sans CJK JP Regular
#        font size: 10 or 12
#   [Step2]
#     Menu -> Preferences -> Ibus Preferences
#     -> General -> Next input methods: ctrl+space
#   [Step3]
#     Menu -> Preferences -> Ibus Preferences
#     -> Input Method -> Add -> Japanese -> Mozc
#sudo apt -y install ibus-mozc

# https://www.fabshop.jp/raspberrypi-fcitx-mozc/
# https://qiita.com/Higemal/items/6cde9d6b40cbe9f0e97f
# You need also the following manual setting with GUI:
#   [Step1]
#     Menu -> Preferences -> Fcitx Configuration
#     -> Input Method -> + buttun ~> Mozc
#   [Step2]
#     Menu -> Preferences -> Fcitx Configuration
#     -> Global Config -> Triger Input Method -> Zenkakuhankaku
#   [Step3]
#     Reboot
sudo apt -y install fcitx-mozc
#im-config -n fcitx

# packages
sudo apt -y install peco
sudo apt -y install tmux
sudo apt -y install tig
sudo apt -y install expect
sudo apt -y install cec-utils # for cec-client

# Install xscreensaver to disable screen saver
sudo apt -y install xscreensaver # by gui
# Or execute no_blank.sh to manually disable it

# change login shell bash to zsh
sudo apt -y install zsh
sudo chsh -s $(which zsh) pi
git clone https://github.com/zplug/zplug ~/.zplug

sudo systemctl enable ssh
#sudo systemctl start ssh
reboot

