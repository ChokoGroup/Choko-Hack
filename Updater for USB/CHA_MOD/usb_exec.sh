#!/bin/sh
# Choko Hack updater

if [ "$CHOKOVERSION" \> "12.0.0" ]
then
  echo "Your Choko Hack version is \"$CHOKOVERSION\" and shoud not be bigger than 12.0.0"
else
  RUNNINGFROM="$(dirname "$(readlink -f "$0")")"

  if [ -e "${RUNNINGFROM}/hackinstall.tar.gz" ]
  then
    cd /
    gzip -dc < "${RUNNINGFROM}/hackinstall.tar.gz" | tar xvf - 
    RESULT=$?
    if [ $RESULT -eq 0 ]
    then
      [ -f "/.choko/menu-1280x720.rgba" ] && rm "/.choko/menu-1280x720.rgba"
      [ -f "/.choko/menu-1920x1080.rgba" ] && rm "/.choko/menu-1920x1080.rgba"
      [ -f "/.choko/games1S.sh" ] && rm "/.choko/games1S.sh"
      chmod 644 /.choko/*.nfo
      chmod 644 /.choko/*.rgba
      chmod 644 /.choko/*.png
      chmod 755 /etc/init.d/S11chokopoweroff
      chmod 755 /etc/init.d/S20usbcheck
      chmod 755 /etc/init.d/S21capcom
      chmod 755 /usr/sbin/readjoysticks
      echo -e "\nChoko Hack updated."
    else
      echo -e "\n\e[0;31mThere was some error!\e[0m"
    fi
  else
    echo -e "\e[0;31mFile hackinstall.tar.gz not found!\e[0m"
  fi
fi

COUNTDOWN=10
while [ $COUNTDOWN -gt 0 ]
do
  echo -ne "\rRebooting in $COUNTDOWN seconds... "
  COUNTDOWN=$((COUNTDOWN - 1))
  sleep 1
done
echo -ne "\r\e[K"
sync
if [ "$CHOKOVERSION" \< "10.0.0" ]
then
  reboot -f
else
  # Call for safe unmount and reboot
  exit 200
fi
