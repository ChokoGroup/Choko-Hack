#! /bin/sh
# FTP server for Choko Hack 12.0.0+


# Start FTP server if it exists
if [ -x "/.choko/.FTP/uFTP" ]
then
  cd "/.choko/.FTP"
  ./uFTP &>/dev/null
  cd ..
  echo "FTP server started. Going back to menu..."
  sleep 2
fi
exit 202
