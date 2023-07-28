#!/bin/sh
# Choko Hack updater 13.0.0

_var_running_from_folder="$(dirname "$(readlink -f "$0")")"
echo -e "Current Choko Hack version is \"$CHOKOVERSION\"\nThis script will install version 13.0.0\n"

if [ -f "${_var_running_from_folder}/hackinstall.tar.gz" ]
then
  eval "$(grep -m 1 '_var_wanted_screen_resolution=' /etc/init.d/S20usbcheck)"
  eval "$(grep -m 1 '_var_wait_for_USB_countdown=' /etc/init.d/S20usbcheck)"
  eval "$(grep -m 1 '_var_wait_in_menu_countdown=' /etc/init.d/S20usbcheck)"
  eval "$(grep -m 1 '_var_stop_countdown_default=' /etc/init.d/S20usbcheck)"
  eval "$(grep -m 1 '_var_menu_default_option=' /etc/init.d/S20usbcheck)"
  eval "$(grep -m 1 '_var_persistent_Joystick_Mode=' /etc/init.d/S20usbcheck)"
  eval "$(grep -m 1 '_var_Golden_UI_easter_egg=' /etc/init.d/S20usbcheck)"
  cd /
  gzip -dc < "${_var_running_from_folder}/hackinstall.tar.gz" | tar xvf - 
  RESULT=$?
  if [ $RESULT -eq 0 ]
  then
    mkdir -p /boot
    rm -f "/.choko/menu-1280x720.rgba" "/.choko/menu-1920x1080.rgba" "/.choko/games1S.sh" "/.choko/S19chokohelper.choko" "/etc/init.d/S19chokohelper"
    rm -f "/.choko/Activate Choko Hack USB Loader"*
    rm -f "/.choko/Restore USB Joystick Mode"*
    [ -f "/etc/ssh/sshd_config" ] && sed -i "/PermitRootLogin/c\PermitRootLogin yes" /etc/ssh/sshd_config
    [ -f "${_var_running_from_folder}/wpa_supplicant.conf" ] && cp "${_var_running_from_folder}/wpa_supplicant.conf" /etc/
    chown -f root:root /.choko
    chown -f root:root /.choko/*
    chown -f root:root /boot
    chown -f root:root /etc
    chown -f root:root /etc/*
    chown -f root:root /etc/init.d
    chown -f root:root /etc/init.d/*
    chown -f root:root /root
    chown -f root:root /root/.profile
    chown -f root:root /usr
    chown -f root:root /usr/*
    chown -f root:root /usr/bin
    chown -f root:root /usr/bin/bash
    chown -f root:root /usr/bin/poweroff
    chown -f root:root /usr/bin/reboot
    chown -f root:root /usr/sbin
    chown -f root:root /usr/sbin/js2hid2
    chown -f root:root /usr/sbin/readjoysticks
    chmod -f 755 /.choko
    chmod -f 644 /.choko/*
    chmod -f 755 /.choko/*.sh
    chmod -f 755 /.choko/busybox
    chmod -f 755 /.choko/S20joystick.choko
    chmod -f 755 /.choko/S21capcom.choko
    chmod -f 755 /.choko/S40network.choko
    chmod -f 755 /boot
    chmod -f 755 /etc
    chmod -f 600 /etc/shadow
    chmod -f 755 /etc/init.d
    chmod -f 755 /etc/init.d/*
    chmod -f 700 /root
    chmod -f 600 /root/.profile
    chmod -f 755 /usr
    chmod -f 755 /usr/bin
    chmod -f 755 /usr/bin/bash
    chmod -f 755 /usr/bin/poweroff
    chmod -f 755 /usr/bin/reboot
    chmod -f 755 /usr/sbin
    chmod -f 755 /usr/sbin/js2hid2
    chmod -f 755 /usr/sbin/readjoysticks
    [ -n "$_var_wanted_screen_resolution" ] && sed -i -e "/.*_var_wanted_screen_resolution\=.*/{s//_var_wanted_screen_resolution=\"$_var_wanted_screen_resolution\"/;:a" -e '$!N;$!ba' -e '}' /etc/init.d/S20usbcheck
    [ -n "$_var_wait_for_USB_countdown" ] && sed -i -e "/.*_var_wait_for_USB_countdown\=.*/{s//    _var_wait_for_USB_countdown=$_var_wait_for_USB_countdown/;:a" -e '$!N;$!ba' -e '}' /etc/init.d/S20usbcheck
    [ -n "$_var_wait_in_menu_countdown" ] && sed -i -e "/.*_var_wait_in_menu_countdown\=.*/{s//    _var_wait_in_menu_countdown=$_var_wait_in_menu_countdown/;:a" -e '$!N;$!ba' -e '}' /etc/init.d/S20usbcheck
    [ -n "$_var_stop_countdown_default" ] && sed -i -e "/.*_var_stop_countdown_default\=.*/{s//    _var_stop_countdown_default=\"$_var_stop_countdown_default\"/;:a" -e '$!N;$!ba' -e '}' /etc/init.d/S20usbcheck
    [ -n "$_var_menu_default_option" ] && sed -i -e "/.*_var_menu_default_option\=.*/{s//    _var_menu_default_option=\"$_var_menu_default_option\"/;:a" -e '$!N;$!ba' -e '}' /etc/init.d/S20usbcheck
    [ -n "$_var_persistent_Joystick_Mode" ] && sed -i -e "/.*_var_persistent_Joystick_Mode\=.*/{s//    _var_persistent_Joystick_Mode=\"$_var_persistent_Joystick_Mode\"/;:a" -e '$!N;$!ba' -e '}' /etc/init.d/S20usbcheck
    [ -n "$_var_Golden_UI_easter_egg" ] && sed -i -e "/.*_var_Golden_UI_easter_egg\=.*/{s//    _var_Golden_UI_easter_egg=\"$_var_Golden_UI_easter_egg\"/;:a" -e '$!N;$!ba' -e '}' /etc/init.d/S20usbcheck
    touch /tmp/donotruncapcom
    echo -e "\nChoko Hack updated.\n"
  else
    echo -e "\n\e[0;31mThere was some error!\e[m"
  fi
else
  echo -e "\e[0;31mFile hackinstall.tar.gz not found!\e[m"
fi

_var_countdown=3
while [ $_var_countdown -gt 0 ]
do
  echo -ne "\rShutting down in $_var_countdown seconds... "
  _var_countdown=$((_var_countdown - 1))
  sleep 1
done
echo -ne "\r                                        \r"
sync
if [ -z "$CHOKOVERSION" ] || [ "$CHOKOVERSION" \< "10.0.0" ]
then
  poweroff -f
else
  # Call for safe unmount and power off
  exit 201
fi
