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

if [ ! -f /mnt2/hackinstall.tar.gz ]
then
	echo -e "\e[0;31mFile hackinstall.tar.gz not found!\e[0m"
	exit 1
fi
if [ ! -f /mnt2/original.boot.scr ]
then
	echo -e "\e[0;31mFile original.boot.scr not found!\e[0m"
	exit 1
fi

cd /mnt
gzip -dc < /mnt2/hackinstall.tar.gz | tar xvf - 
RESULT=$?
if [ $RESULT -eq 0 ]
then
  [ -f "/mnt/.choko/menu-1280x720.rgba" ] && rm "/mnt/.choko/menu-1280x720.rgba"
  [ -f "/mnt/.choko/menu-1920x1080.rgba" ] && rm "/mnt/.choko/menu-1920x1080.rgba"
  [ -f "/mnt/.choko/games1S.sh" ] && rm "/mnt/.choko/games1S.sh"
  rm "/mnt/.choko/Activate Choko Hack USB Loader"*
  rm "/mnt/.choko/Restore USB Joystick Mode"*
  find /mnt/ -type f \( -iname "*.old" -or -iname "Thumbs.db" \) -exec rm -v {} +
  [ -f "/mnt/etc/ssh/sshd_config" ] && sed -i "/PermitRootLogin/c\PermitRootLogin yes" /mnt/etc/ssh/sshd_config
  chown root:root /mnt/.choko
  chown root:root /mnt/.choko/*
  chown root:root /mnt/etc
  chown root:root /mnt/etc/*
  chown root:root /mnt/etc/init.d/*
  chown root:root /mnt/root
  chown root:root /mnt/root/.profile
  chown root:root /mnt/usr
  chown root:root /mnt/usr/*
  chown root:root /mnt/usr/sbin/js2hid2
  chown root:root /mnt/usr/sbin/readjoysticks
  chmod 644 /mnt/.choko/*
  chmod 755 /mnt/.choko/*.sh
  chmod 755 /mnt/.choko/S19chokohelper.choko
  chmod 755 /mnt/.choko/S20joystick.choko
  chmod 755 /mnt/.choko/S21capcom.choko
  chmod 755 /mnt/etc/init.d/*
  chmod 755 /mnt/usr/sbin/js2hid2
  chmod 755 /mnt/usr/sbin/readjoysticks
	rm /mnt2/hackinstall.tar.gz
	mv /mnt2/original.boot.scr /mnt2/boot.scr
fi
cd /mnt2
exit $RESULT
