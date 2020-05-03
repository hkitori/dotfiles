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

# add gpu_mem=512
sudo raspi-config nonint do_memory_split 512
# comment out disable_overscan
sudo raspi-config nonint do_overscan 0
# turn off blanking
sudo raspi-config nonint do_blanking 1


sudo apt update
sudo apt -y upgrade
sudo apt -y upgrade vim

# google JP fonts
sudo apt -y install fonts-noto
# input method for JP
#   You need also the following manual setting with GUI:
#     Menu -> Preferences -> Ibus Preferences
#     -> General -> Use custom font: Noto Sans CJK JP Regular
#     font size: 10 or 12
sudo apt -y install ibus-mozc


sudo apt -y install peco
sudo apt -y install tmux


sudo systemctl enable ssh
#sudo systemctl start ssh
reboot

