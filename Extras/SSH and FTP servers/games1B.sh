#!/bin/sh
# SSH server for Choko Hack 13.0.0

# Simple string compare, since until 10.0.0 CHOKOVERSION wasn't set
# Future versions need to keep this in mind
if [ -z "$CHOKOVERSION" ] || [ "$CHOKOVERSION" \< "13.0.0" ]
then
  echo -e "\nYou are running an outdated version of Choko Hack.\nYou need v13.0.0 or later.\n"
  COUNTDOWN=5
  while [ $COUNTDOWN -ge 0 ]
  do
    echo -ne "\rRebooting in $COUNTDOWN seconds... "
    COUNTDOWN=$((COUNTDOWN - 1))
    sleep 1
  done
  echo -e "\r                                   \r"
  if [ -z "$CHOKOVERSION" ] || [ "$CHOKOVERSION" \< "10.0.0" ]
  then
    reboot -f
  else
    exit 200
  fi
fi

RUNNINGFROM="$(dirname "$(realpath "$0")")"
if [ -f "/etc/ssh/sshd_config" ] && [ -f /.choko/S50sshd.original ]
then
  sed -i "/PermitRootLogin/c\PermitRootLogin yes" /etc/ssh/sshd_config
  chmod 755 /.choko/S50sshd.original
  cp "$RUNNINGFROM/Start SSH server."* /.choko/
else
  mkdir -p /.choko/.SSH
  cp "$RUNNINGFROM/.SSH"/* /.choko/.SSH/
  cp "$RUNNINGFROM/Start SSH server."* /.choko/
fi
echo "Menu option installed."
sleep 3
# Go back to Choko Menu
exit 202
