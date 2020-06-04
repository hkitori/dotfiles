#!/bin/sh -eux

#sudo patch /etc/xdg/openbox/lxde-pi-rc.xml < lxde-pi-rc.xml.patch
sudo patch --dry-run /etc/xdg/openbox/lxde-pi-rc.xml < lxde-pi-rc.xml.patch

