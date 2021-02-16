#!/bin/sh

RUNNINGFROM="$(dirname "$(readlink -f "$0")")"

if [ -e "$RUNNINGFROM/hackinstall.tar.gz" ]
then
	cd /
	gzip -dc < "$RUNNINGFROM/hackinstall.tar.gz" | tar xvf - 
	RESULT=$?
  if [ $RESULT -eq 0 ] && [ -x /.choko/usb_exec.sh ]
  then
     cp "$RUNNINGFROM/usb_exec.sh2" /.choko/usb_exec.sh
     RESULT=$?
     [ $RESULT -eq 0 ] && echo "/.choko/usb_exec.sh"
  fi
	[ $RESULT -eq 0 ] && echo -e "\nChoko Hack updated." || echo -e "\n\e[0;31mThere was some error!\e[0m"
else
	echo -e "\e[0;31mFile hackinstall.tar.gz not found!\e[0m"
fi

if [ "$CHOKOVERSION" \< "10.0.0" ]
then
  COUNTDOWN=10
  while [ $COUNTDOWN -ge 0 ]
  do
    echo -ne "\rShutting down in $COUNTDOWN seconds... "
    COUNTDOWN=$(($COUNTDOWN - 1))
    sleep 1
  done
  clear
  sync
  echo "Power off now, then remove the pendrive and power on again."
  poweroff -f
else
  # Call for safe unmount and poweroff
  sync
  exit 201
fi
