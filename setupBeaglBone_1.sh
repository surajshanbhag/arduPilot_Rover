#!/bin/bash -x
#setup beaglebone for ARduCopter

echo "update debian"
sudo apt-get update
sudo apt-get upgrade -y

echo "install software"
sudo apt install -y cpufrequtils g++ liblttng-ust-dev pkg-config gawk git make device-tree-compiler screen python python-dev python-lxml python-pip
sudo pip install future
sudo ln -s pkg-config /usr/bin/arm-linux-gnueabihf-pkg-config
cd /opt/scripts && sudo git pull
sudo /opt/scripts/tools/grow_partition.sh
sudo /opt/scripts/tools/update_kernel.sh --bone-rt-kernel --lts-4_4
sudo sed -i 's/#dtb=$/dtb=am335x-boneblack-bbbmini.dtb/' /boot/uEnv.txt
sudo sed -i 's/GOVERNOR="ondemand"/GOVERNOR="performance"/g' /etc/init.d/cpufrequtils


echo "setup wifi"
sudo apt-get install -y wireless-tools unzip dhcpcd5
sudo apt-get install -y build-essential linux-headers-$(uname -r)
cd ~/
wget https://git.kernel.org/cgit/linux/kernel/git/firmware/linux-firmware.git/tree/rtlwifi/rtl8192cufw_TMSC.bin
wget https://git.kernel.org/cgit/linux/kernel/git/firmware/linux-firmware.git/tree/rtlwifi/rtl8192cufw.bin
wget https://git.kernel.org/cgit/linux/kernel/git/firmware/linux-firmware.git/tree/rtlwifi/rtl8192cufw_A.bin
wget https://git.kernel.org/cgit/linux/kernel/git/firmware/linux-firmware.git/tree/rtlwifi/rtl8192cufw_B.bin
cp rtl8192cufw* /lib/modules/4.4.22-ti-r49/kernel/drivers/net/wireless/realtek/rtlwifi/
cp rtl8192cufw* /lib/modules/4.4.22-ti-r49/kernel/drivers/net/wireless/realtek/rtlwifi/rtl8192cu
rm -rf ~/rtl8192cufw*
