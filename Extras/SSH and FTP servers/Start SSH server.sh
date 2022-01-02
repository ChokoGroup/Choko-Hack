#! /bin/sh
# SSH server for Choko Hack 12.0.0+

if [ -x /.choko/.SSH/dropbear ] || [ -x /.choko/S50sshd.original ]
then
  if [ -n "$(pidof dropbear)" ] || [ -f /var/lock/sshd ]
  then
    echo "SSH server is already running!"
  else
    if [ -x /.choko/S50sshd.original ]
    then
      /.choko/S50sshd.original start &>/dev/null
    else
      cd /.choko/.SSH
      ./dropbear -r ./dropbear_ecdsa_host_key -r ./id_rsa -R -E -B &>/dev/null
      cd ..
    fi
    echo "SSH server started. Going back to menu..."
  fi
else
  echo "SSH server not found!? Going back to menu..."
fi
sleep 2
exit 202
