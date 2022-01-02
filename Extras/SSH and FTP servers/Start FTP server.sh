#! /bin/sh
# FTP server for Choko Hack 12.0.0+


# Start FTP server if it exists
if [ -x "/.choko/.FTP/uFTP" ]
then
  if [ -n "$(pidof dropbear)" ]
  then
    echo "FTP server is already running!"
  else
    cd "/.choko/.FTP"
    ./uFTP &>/dev/null
    cd ..
    echo "FTP server started. Going back to menu..."
  fi
else
  echo "FTP server not found!? Going back to menu..."
fi
sleep 2
exit 202
