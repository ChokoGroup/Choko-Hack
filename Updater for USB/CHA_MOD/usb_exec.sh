#!/bin/sh
# Choko Hack updater

if [ "$CHOKOVERSION" \> "12.3.0" ]
then
  echo "Your Choko Hack version is \"$CHOKOVERSION\" and shoud not be bigger than 12.3.0"
else
  RUNNINGFROM="$(dirname "$(readlink -f "$0")")"

  if [ -e "${RUNNINGFROM}/hackinstall.tar.gz" ]
  then
    eval "$(grep -m 1 'USBCOUNTDOWN=' /etc/init.d/S20usbcheck)"
    eval "$(grep -m 1 'MENUCOUNTDOWN=' /etc/init.d/S20usbcheck)"
    eval "$(grep -m 1 'STOPCOUNT=' /etc/init.d/S20usbcheck)"
    eval "$(grep -m 1 'WANTEDRES=' /etc/init.d/S20usbcheck)"
    eval "$(grep -m 1 'MENUDEFAULTOPTION=' /etc/init.d/S20usbcheck)"
    eval "$(grep -m 1 'PERSISTENTUSBJOYMODE=' /etc/init.d/S20usbcheck)"
    cd /
    gzip -dc < "${RUNNINGFROM}/hackinstall.tar.gz" | tar xvf - 
    RESULT=$?
    if [ $RESULT -eq 0 ]
    then
      [ -f "/.choko/menu-1280x720.rgba" ] && rm "/.choko/menu-1280x720.rgba"
      [ -f "/.choko/menu-1920x1080.rgba" ] && rm "/.choko/menu-1920x1080.rgba"
      [ -f "/.choko/games1S.sh" ] && rm "/.choko/games1S.sh"
      if [ -f "/.choko/Restore USB Joystick Mode.nfo" ]
      then
        mv "/.choko/Activate Choko Hack USB Loader.nfo" "/.choko/Restore USB Joystick Mode.nfo"
        echo "Restore USB Joystick Mode" > "/.choko/Restore USB Joystick Mode.nfo"
        mv "/.choko/Activate Choko Hack USB Loader.sh" "/.choko/Restore USB Joystick Mode.sh"
      fi
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
      [ -n "$USBCOUNTDOWN" ] && sed -i -e "/.*USBCOUNTDOWN\=.*/{s//        USBCOUNTDOWN=$USBCOUNTDOWN/;:a" -e '$!N;$!ba' -e '}' /etc/init.d/S20usbcheck
      [ -n "$MENUCOUNTDOWN" ] && sed -i -e "/.*MENUCOUNTDOWN\=.*/{s//        MENUCOUNTDOWN=$MENUCOUNTDOWN/;:a" -e '$!N;$!ba' -e '}' /etc/init.d/S20usbcheck
      [ -n "$STOPCOUNT" ] && sed -i -e "/.*STOPCOUNT\=.*/{s//        STOPCOUNT=\"$STOPCOUNT\"/;:a" -e '$!N;$!ba' -e '}' /etc/init.d/S20usbcheck
      [ -n "$WANTEDRES" ] && sed -i -e "/.*WANTEDRES\=.*/{s//        WANTEDRES=\"$WANTEDRES\"/;:a" -e '$!N;$!ba' -e '}' /etc/init.d/S20usbcheck
      [ -n "$MENUDEFAULTOPTION" ] && sed -i -e "/.*MENUDEFAULTOPTION\=.*/{s//        MENUDEFAULTOPTION=\"$MENUDEFAULTOPTION\"/;:a" -e '$!N;$!ba' -e '}' /etc/init.d/S20usbcheck
      [ -n "$PERSISTENTUSBJOYMODE" ] && sed -i -e "/.*PERSISTENTUSBJOYMODE\=.*/{s//export PERSISTENTUSBJOYMODE=\"$PERSISTENTUSBJOYMODE\"/;:a" -e '$!N;$!ba' -e '}' /etc/init.d/S20usbcheck
      echo -e "\nChoko Hack updated.\n\e[1;32mDon't forget to remove the pendisk.\e[m\n"
    else
      echo -e "\n\e[0;31mThere was some error!\e[0m"
    fi
  else
    echo -e "\e[0;31mFile hackinstall.tar.gz not found!\e[0m"
  fi
fi

COUNTDOWN=5
while [ $COUNTDOWN -gt 0 ]
do
  echo -ne "\rShutting down in $COUNTDOWN seconds... "
  COUNTDOWN=$((COUNTDOWN - 1))
  sleep 1
done
echo -ne "\r\e[K"
sync
if [ "$CHOKOVERSION" \< "10.0.0" ]
then
  reboot -f
else
  # Call for safe unmount and power off
  exit 201
fi
