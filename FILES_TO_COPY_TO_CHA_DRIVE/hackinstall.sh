#!/bin/sh
# Choko Hack installer 12.6.0

echo -e "\n\n\e[0;35m"
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
echo -e "\n\n\e[m"

if [ ! -f /mnt2/hackinstall.tar.gz ]
then
	echo -e "\e[0;31mFile hackinstall.tar.gz not found!\e[m"
	exit 1
fi
if [ ! -f /mnt2/original.boot.scr ]
then
	echo -e "\e[0;31mFile original.boot.scr not found!\e[m"
	exit 1
fi

cd /mnt
gzip -dc < /mnt2/hackinstall.tar.gz | tar xvf - 
RESULT=$?
if [ $RESULT -eq 0 ]
then
  mkdir -p /mnt/boot
  rm -f "/mnt/.choko/menu-1280x720.rgba" "/mnt/.choko/menu-1920x1080.rgba" "/mnt/.choko/games1S.sh" "/mnt/.choko/S19chokohelper.choko" "/mnt/etc/init.d/S19chokohelper"
  rm -f "/mnt/.choko/Activate Choko Hack USB Loader"*
  rm -f "/mnt/.choko/Restore USB Joystick Mode"*
  [ -f "/mnt/etc/ssh/sshd_config" ] && sed -i "/PermitRootLogin/c\PermitRootLogin yes" /mnt/etc/ssh/sshd_config
  [ -f "/mnt2/wpa_supplicant.conf" ] && cp /mnt2/wpa_supplicant.conf /mnt/etc/
  chown -f root:root /mnt/.choko
  chown -f root:root /mnt/.choko/*
  chown -f root:root /mnt/boot
  chown -f root:root /mnt/etc
  chown -f root:root /mnt/etc/*
  chown -f root:root /mnt/etc/init.d/*
  chown -f root:root /mnt/root
  chown -f root:root /mnt/root/.profile
  chown -f root:root /mnt/usr
  chown -f root:root /mnt/usr/*
  chown -f root:root /mnt/usr/sbin/js2hid2
  chown -f root:root /mnt/usr/sbin/readjoysticks
  chmod -f 644 /mnt/.choko/*
  chmod -f 755 /mnt/.choko/*.sh
  chmod -f 755 /mnt/.choko/S20joystick.choko
  chmod -f 755 /mnt/.choko/S21capcom.choko
  chmod -f 755 /mnt/boot
  chmod -f 755 /mnt/etc/init.d/*
  chmod -f 755 /mnt/usr/sbin/js2hid2
  chmod -f 755 /mnt/usr/sbin/readjoysticks
	mv /mnt2/original.boot.scr /mnt2/boot.scr
	rm /mnt2/hackinstall.tar.gz
fi
cd /mnt2
exit $RESULT
