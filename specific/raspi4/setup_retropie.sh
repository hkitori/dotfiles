#!/bin/sh -eux

# get absolute path to current script
full_path=$(realpath $0)
dir_path=$(dirname $full_path)
echo $dir_path
cp $dir_path/retropie/retropie.desktop ~/Desktop/

# move to home as working dir
cd ~/
sudo rm -fr RetroPie-Setup
sudo git clone --depth=1 https://github.com/RetroPie/RetroPie-Setup.git
cd RetroPie-Setup

#sudo nano retropie_packages.sh
#Add this line  __platform=rpi3
#awk 'NR==12{print "__platform=rpi3"}1' retropie_packages.sh

sudo __platform=rpi3 ./retropie_setup.sh

