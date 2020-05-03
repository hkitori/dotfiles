#!/bin/sh -eux

# change password for user pi
sudo passwd pi

# country
sudo raspi-config nonint do_wifi_country JP
sudo raspi-config nonint do_change_timezone Asia/Tokyo
sudo raspi-config nonint do_change_locale en_US.UTF-8

# hdmi_group = 1 : CEA
# hdmi_mode = 4  : 1280x720 @ 60Hz, progressive
sudo raspi-config nonint do_resolution 1 4
# add disable_overscan
sudo raspi-config nonint do_overscan 1
# turn off blanking
sudo raspi-config nonint do_blanking 0


sudo apt update
sudo apt -y upgrade
sudo apt -y upgrade vim

# google JP fonts
sudo apt -y install fonts-noto
# input method for JP
sudo apt -y install ibus-mozc


sudo apt -y install peco
sudo apt -y install tmux


sudo systemctl enable ssh
#sudo systemctl start ssh
reboot

