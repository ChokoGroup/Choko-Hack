#!/bin/sh
# Choko Hack updater 12.6.0

RUNNINGFROM="$(dirname "$(readlink -f "$0")")"
echo -e "Your Choko Hack version in CHA is \"$CHOKOVERSION\"\nThis script will install version 12.6.0\n"

if [ -f "${RUNNINGFROM}/hackinstall.tar.gz" ]
then
  eval "$(grep -m 1 'USBCOUNTDOWN=' /etc/init.d/S20usbcheck)"
  eval "$(grep -m 1 'MENUCOUNTDOWN=' /etc/init.d/S20usbcheck)"
  eval "$(grep -m 1 'STOPCOUNTDEFAULT=' /etc/init.d/S20usbcheck)"
  eval "$(grep -m 1 'WANTEDRES=' /etc/init.d/S20usbcheck)"
  eval "$(grep -m 1 'MENUDEFAULTOPTION=' /etc/init.d/S20usbcheck)"
  eval "$(grep -m 1 'PERSISTENTUSBJOYMODE=' /etc/init.d/S20usbcheck)"
  eval "$(grep -m 1 'GOLDENUI=' /etc/init.d/S20usbcheck)"
  cd /
  gzip -dc < "${RUNNINGFROM}/hackinstall.tar.gz" | tar xvf - 
  RESULT=$?
  if [ $RESULT -eq 0 ]
  then
    mkdir -p /boot
    rm -f "/.choko/menu-1280x720.rgba" "/.choko/menu-1920x1080.rgba" "/.choko/games1S.sh" "/.choko/S19chokohelper.choko" "/etc/init.d/S19chokohelper"
    rm -f "/.choko/Activate Choko Hack USB Loader"*
    rm -f "/.choko/Restore USB Joystick Mode"*
    [ -f "/etc/ssh/sshd_config" ] && sed -i "/PermitRootLogin/c\PermitRootLogin yes" /etc/ssh/sshd_config
    [ -f "${RUNNINGFROM}/wpa_supplicant.conf" ] && cp "${RUNNINGFROM}/wpa_supplicant.conf" /etc/
    chown -f root:root /.choko
    chown -f root:root /.choko/*
    chown -f root:root /boot
    chown -f root:root /etc
    chown -f root:root /etc/*
    chown -f root:root /etc/init.d/*
    chown -f root:root /root
    chown -f root:root /root/.profile
    chown -f root:root /usr
    chown -f root:root /usr/*
    chown -f root:root /usr/sbin/js2hid2
    chown -f root:root /usr/sbin/readjoysticks
    chmod -f 644 /.choko/*
    chmod -f 755 /.choko/*.sh
    chmod -f 755 /.choko/S20joystick.choko
    chmod -f 755 /.choko/S21capcom.choko
    chmod -f 755 /boot
    chmod -f 755 /etc/init.d/*
    chmod -f 755 /usr/sbin/js2hid2
    chmod -f 755 /usr/sbin/readjoysticks
    [ -n "$USBCOUNTDOWN" ] && sed -i -e "/.*USBCOUNTDOWN\=.*/{s//      USBCOUNTDOWN=$USBCOUNTDOWN/;:a" -e '$!N;$!ba' -e '}' /etc/init.d/S20usbcheck
    [ -n "$MENUCOUNTDOWN" ] && sed -i -e "/.*MENUCOUNTDOWN\=.*/{s//      MENUCOUNTDOWN=$MENUCOUNTDOWN/;:a" -e '$!N;$!ba' -e '}' /etc/init.d/S20usbcheck
    [ -n "$STOPCOUNTDEFAULT" ] && sed -i -e "/.*STOPCOUNTDEFAULT\=.*/{s//      STOPCOUNTDEFAULT=\"$STOPCOUNTDEFAULT\"/;:a" -e '$!N;$!ba' -e '}' /etc/init.d/S20usbcheck
    [ -n "$WANTEDRES" ] && sed -i -e "/.*WANTEDRES\=.*/{s//WANTEDRES=\"$WANTEDRES\"/;:a" -e '$!N;$!ba' -e '}' /etc/init.d/S20usbcheck
    [ -n "$MENUDEFAULTOPTION" ] && sed -i -e "/.*MENUDEFAULTOPTION\=.*/{s//      MENUDEFAULTOPTION=\"$MENUDEFAULTOPTION\"/;:a" -e '$!N;$!ba' -e '}' /etc/init.d/S20usbcheck
    [ -n "$PERSISTENTUSBJOYMODE" ] && sed -i -e "/.*PERSISTENTUSBJOYMODE\=.*/{s//      PERSISTENTUSBJOYMODE=\"$PERSISTENTUSBJOYMODE\"/;:a" -e '$!N;$!ba' -e '}' /etc/init.d/S20usbcheck
    [ -n "$GOLDENUI" ] && sed -i -e "/.*GOLDENUI\=.*/{s//      GOLDENUI=\"$GOLDENUI\"/;:a" -e '$!N;$!ba' -e '}' /etc/init.d/S20usbcheck
    touch /tmp/donotruncapcom
    echo -e "\nChoko Hack updated.\n\e[1;32mDon't forget to remove the pendisk.\e[m\n"
  else
    echo -e "\n\e[0;31mThere was some error!\e[m"
  fi
else
  echo -e "\e[0;31mFile hackinstall.tar.gz not found!\e[m"
fi

COUNTDOWN=3
while [ $COUNTDOWN -gt 0 ]
do
  echo -ne "\rShutting down in $COUNTDOWN seconds... "
  COUNTDOWN=$((COUNTDOWN - 1))
  sleep 1
done
echo -ne "\r                                        \r"
sync
if [ "$CHOKOVERSION" \< "10.0.0" ]
then
  poweroff -f
else
  # Call for safe unmount and power off
  exit 201
fi
