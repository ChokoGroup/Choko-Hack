#!/bin/sh
# Choko Hack v 12.0.0 Uninstaller

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
echo -ne "\r\e[1ADo you want to \e[1;31muninstall\e[m \"$LISTNAME\"? \e[1;93m$ANSWER \n\e[m\e[K"
if [ "$ANSWER" = "Yes" ]
then
  [ -f /etc/init.d/S20usbcheck ] && rm /etc/init.d/S20usbcheck
  [ -f /etc/init.d/S11chokopoweroff ] && rm /etc/init.d/S11chokopoweroff
  [ -d /.choko ] && rm -rf /.choko
  [ -f /usr/sbin/readjoysticks ] && rm /usr/sbin/readjoysticks
  [ -f /usr/sbin/evtest ] && rm /usr/sbin/evtest
  [ -f /root/.profile ] && rm /root/.profile
  exit 201
fi

sleep 3
if [ "$CHOKOVERSION" \< "10.0.0" ]
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
