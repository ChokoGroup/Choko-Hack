#!/bin/sh
# SSH server for Choko Hack 13.0.0 (uninstaller)

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

if [ -d /.choko/.SSH ] || [ -f /.choko/S50sshd.original ]
then
  [ -d /.choko/.SSH ] && rm -rf /.choko/.SSH
  rm "/.choko/Start SSH server."*
  echo "SSH server deleted."
else
  echo "SSH server not found."
fi
sleep 3
# Go back to Choko Menu
exit 202
