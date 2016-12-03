#!/bin/bash -x

RED='\033[0;31m'
NC='\033[0m' # No Color
cd ~/
printf "${RED}git clone https://github.com/beagleboard/bb.org-overlays${NC}"
git clone https://github.com/beagleboard/bb.org-overlays

printf "${RED}cd ./bb.org-overlays && ./install.sh${NC}"
cd ./bb.org-overlays && ./install.sh

printf "${RED}sudo sed -i 's/#cape_enable=bone_capemgr.enable_partno=/cape_enable=bone_capemgr.enable_partno=BB-ADC/g' /       boot/uEnv.txt ${NC}"
sudo sed -i 's/#cape_enable=bone_capemgr.enable_partno=/cape_enable=bone_capemgr.enable_partno=BB-ADC/g' /boot/uEnv.txt

cd ~/
printf "${RED}git clone https://github.com/ArduPilot/ardupilot.git${NC}"
git clone https://github.com/ArduPilot/ardupilot.git

