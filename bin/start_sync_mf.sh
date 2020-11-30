#! /bin/bash
export DISPLAY=':0';
cd ~/bin/ || exit
python3 sync_mf.py "id" "password";
