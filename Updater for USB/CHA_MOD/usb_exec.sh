#!/bin/sh
# Choko Hack updater

if [ "$CHOKOVERSION" \> "12.2.0" ]
then
  echo "Your Choko Hack version is \"$CHOKOVERSION\" and shoud not be bigger than 12.2.0"
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
      chown root:root /.choko
      chown root:root /.choko/*
      chown root:root /etc
      chown root:root /etc/*
      chown root:root /etc/init.d/*
      chown root:root /root
      chown root:root /root/.profile
      chown root:root /usr
      chown root:root /usr/*
      chown root:root /usr/sbin/readjoysticks
      chmod 644 /.choko/*
      chmod 755 /.choko/*.sh
      chmod 755 /etc/init.d/S11chokopoweroff
      chmod 755 /etc/init.d/S20usbcheck
      chmod 755 /etc/init.d/S21capcom
      chmod 755 /usr/sbin/readjoysticks
      echo -e "\nChoko Hack updated.\n\e[1;32mDon't forget to remove the pendisk.\e[m\n"
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
