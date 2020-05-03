#!/bin/sh -eux

cd ~/
sudo rm -fr RetroPie-Setup
sudo git clone --depth=1 https://github.com/RetroPie/RetroPie-Setup.git
cd RetroPie-Setup

#sudo nano retropie_packages.sh
#Add this line  __platform=rpi3
awk 'NR==3{print "__platform=rpi3"}1' text


sudo __platform=rpi3 ./retropie_setup.sh

