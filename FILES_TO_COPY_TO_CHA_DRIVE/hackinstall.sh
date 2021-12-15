#!/bin/sh

echo -e "\n\n\n\e[0;35m"
echo "      ___           ___           ___           ___           ___      "
echo "     /\__\         /\  \         /\  \         /|  |         /\  \     "
echo "    /:/  /         \:\  \       /::\  \       |:|  |        /::\  \    "
echo "   /:/  /           \:\  \     /:/\:\  \      |:|  |       /:/\:\  \   "
echo "  /:/  /  ___   ___ /::\  \   /:/  \:\  \   __|:|  |      /:/  \:\  \  "
echo " /:/__/  /\__\ /\  /:/\:\__\ /:/__/ \:\__\ /\ |:|__|____ /:/__/ \:\__\ "
echo " \:\  \ /:/  / \:\/:/  \/__/ \:\  \ /:/  / \:\/:::::/__/ \:\  \ /:/  / "
echo "  \:\  /:/  /   \::/__/       \:\  /:/  /   \::/~~/       \:\  /:/  /  "
echo "   \:\/:/  /     \:\  \        \:\/:/  /     \:\~~\        \:\/:/  /   "
echo "    \::/  /       \:\__\        \::/  /       \:\__\        \::/  /    "
echo "     \/__/         \/__/         \/__/         \/__/         \/__/     "
echo ""
echo "    ----===== Por que semos los mas mejores der mundo... =====----     "
echo ""
echo "            Y al que no le guste, [CENSORED BY THE AUDITOR]            "
echo -e "\n\n\n\e[0m"

if [ ! -e /mnt2/hackinstall.tar.gz ]
then
	echo -e "\e[0;31mFile hackinstall.tar.gz not found!\e[0m"
	exit 1
fi
if [ ! -e /mnt2/original.boot.scr ]
then
	echo -e "\e[0;31mFile original.boot.scr not found!\e[0m"
	exit 1
fi

cd /mnt
gzip -dc < /mnt2/hackinstall.tar.gz | tar xvf - 
RESULT=$?
if [ $RESULT -eq 0 ]
then
  chown root:root /.choko
  chown root:root /.choko/*
  chown root:root /etc
  chown root:root /etc/*
  chown root:root /etc/init.d/*
  chown root:root /root
  chown root:root /root/.profile
  chown root:root /usr
  chown root:root /usr/*
  chown root:root /usr/sbin/js2hid2
  chown root:root /usr/sbin/readjoysticks
  chmod 644 /.choko/*
  chmod 755 /.choko/*.sh
  chmod 755 /etc/init.d/S11chokopoweroff
  chmod 755 /mnt/etc/init.d/S20joystick
  chmod 755 /etc/init.d/S20usbcheck
  chmod 755 /etc/init.d/S21capcom
  chmod 755 /usr/sbin/js2hid2
  chmod 755 /usr/sbin/readjoysticks
	rm /mnt2/hackinstall.tar.gz
	mv /mnt2/original.boot.scr /mnt2/boot.scr
fi
cd /mnt2
exit $RESULT
