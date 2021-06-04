#! /bin/sh
# SSH server for Choko Hack 12.0.0+


# Start dropbear SSH server if it exists
if [ -x "/.choko/.SSH/dropbear" ]
then
  cd "/.choko/.SSH"
  ./dropbear -r ./dropbear_ecdsa_host_key -r ./id_rsa -R -E -B &>/dev/null
  cd ..
  echo "SSH server started. Going back to menu..."
  sleep 2
fi
exit 202
