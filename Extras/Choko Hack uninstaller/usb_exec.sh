#!/bin/sh
# Choko Hack v13.3.0 Uninstaller

# Wait for buttons to be released before asking to delete
while [ "$(readjoysticks j1 j2 -b)" != "0000000000000000" ]
do
  sleep 1
done
COUNTDOWN=10
STOPCOUNT="N"
ANSWER="No"
echo -ne "\nDo you want to \e[1;31muninstall\e[m \"Choko Hack\"? \e[1;93m$ANSWER \n\e[1;30mUse joystick to change answer. Waiting $COUNTDOWN seconds...\e[m "

# Read joystick
while [ $COUNTDOWN -gt 0 ]
do
  case "$(readjoysticks j1)" in
    U|D|L|R)
      if [ "$ANSWER" = "No" ]
      then
        ANSWER="Yes"
      else
        ANSWER="No"
      fi
      if [ "$STOPCOUNT" = "N" ]
      then
        STOPCOUNT="Y"
      fi
      echo -ne "\r\e[1ADo you want to \e[1;31muninstall\e[m \"Choko Hack\"? \e[1;93m$ANSWER \n\e[m\e[K"
    ;;
    0|1|2|3|4|5|6|7)
      COUNTDOWN=0
    ;;
    *)
      if [ "$STOPCOUNT" = "N" ]
      then
        COUNTDOWN=$((COUNTDOWN - 1))
        echo -ne "\r\e[1ADo you want to \e[1;31muninstall\e[m \"Choko Hack\"? \e[1;93m$ANSWER \n\e[1;30mUse joystick to change answer. Waiting $COUNTDOWN seconds...\e[m "
      fi
    ;;
  esac
done
echo -ne "\r\e[1ADo you want to \e[1;31muninstall\e[m \"Choko Hack\"? \e[1;93m$ANSWER \n\e[m\e[K"
if [ "$ANSWER" = "Yes" ]
then
  [ -f /etc/init.d/S20usbcheck ] && rm /etc/init.d/S20usbcheck
  [ -f /etc/init.d/S19chokohelper ] && rm /etc/init.d/S19chokohelper
  [ -f /etc/init.d/S11chokopoweroff ] && rm /etc/init.d/S11chokopoweroff
  [ -f /.choko/S21capcom.original ] && mv /.choko/S21capcom.original /etc/init.d/S21capcom
  [ -f /.choko/S20joystick.original ] && mv /.choko/S20joystick.original /etc/init.d/S20joystick
  [ -f /.choko/S40network.original ] && mv /.choko/S40network.original /etc/init.d/S40network
  # Older installers removed the executable permission from the original scripts
  chmod -f 755 /etc/init.d/*
  # /boot may be mounted read-only
  grep ' /boot ' /proc/mounts | grep -q -E ' ro[, ]' && mount -o remount,rw /boot
  # Screen resolution may have been changed in Choko Hack settings
  [ -f /.choko/original.boot.scr ] && [ -f /boot/boot.scr ] && cp /.choko/original.boot.scr /boot/boot.scr
  if [ -f /boot/sun8i-h3-orangepi-pc.dtb ]
  then
    # DTB used before installing Choko Hack (firmware 1.7 needs its own DTB for the official USB Joystick Mode)
    [ -f /.choko/sun8i-h3-orangepi-pc.dtb.original ] && cp /.choko/sun8i-h3-orangepi-pc.dtb.original /boot/sun8i-h3-orangepi-pc.dtb
    if cmp -s /.choko/sun8i-h3-orangepi-pc.dtb /boot/sun8i-h3-orangepi-pc.dtb
    then
      # Still using the DTB from Choko Hack, with Ethernet disabled (the CHA has none): don't let the network wait 15 seconds for eth0
      sed -i '/^[[:space:]]*wait-delay/d' /etc/network/interfaces
    fi
    sync
  fi
  [ -d /.choko ] && rm -rf /.choko
  [ -f /usr/sbin/js2hid2 ] && rm /usr/sbin/js2hid2
  [ -f /usr/sbin/readjoysticks ] && rm /usr/sbin/readjoysticks
  [ -f /usr/sbin/evtest ] && rm /usr/sbin/evtest
  # Choko Hack reboot and poweroff commands call S11chokopoweroff, that was deleted
  grep -qs "Choko Hack" /usr/bin/reboot && rm /usr/bin/reboot
  grep -qs "Choko Hack" /usr/bin/poweroff && rm /usr/bin/poweroff
  [ -f /usr/bin/setfont ] && rm /usr/bin/setfont
  rm -f /usr/share/consolefonts/default.psf.gz /usr/share/consolefonts/terminus*.psf.gz /usr/share/consolefonts/spleen*.psfu.gz
  [ -f /bin/bash ] && rm /bin/bash
  [ -f /usr/bin/bash ] && rm /usr/bin/bash
  [ -f /root/.profile ] && rm /root/.profile
  echo -e "\nChoko Hack uninstalled. Shutting down..."
  sync
  # S11chokopoweroff was deleted, Choko Menu can't do the safe shutdown
  /usr/sbin/poweroff
  exit 201
fi

sleep 3
if [ -z "$CHOKOVERSION" ] || [ "$CHOKOVERSION" \< "10.0.0" ]
then
  reboot -f
else
  if [ "$CHOKOVERSION" \< "12.0.0" ]
  then
    exit 200
  else
    exit 202
  fi
fi
