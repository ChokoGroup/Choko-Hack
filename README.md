# Choko-Hack v12.3.0
### Choko Hack for the Capcom Home Arcade

The Choko Hack will allow you to play more roms with the CHA original system. You can preserve the original software, add games or use an USB disk to play your roms.

Read the file '00 - Instructions.txt' to learn how to install.

You can also look into the 'Video Guide.gif' - it's a little outdated but still gives a good idea of the process.

Download the installer, updater or system images with the hack already installed from https://github.com/ChokoGroup/Choko-Hack/releases/latest

Some notes:
- This hack is a script loader, you need https://github.com/ChokoGroup/Choko-Hack-Automatic-Lists to create and load games lists.
- If official list is the only option, the menu is skipped.
- If there is only one USB option (other than 16 official games) it is automatically loaded (menu is skipped).
- Normal behaviour is joystick mode goes back to arcade mode after reboot, but If we change "joystick mode persistence" to Yes in settings (Start1+Start2) it will always boot into joystick mode until disabled with Coin1+Coin2 at boot.


### What's new in v12.3.0
- Improvements to official USB Joystick Mode in v1.7 firmware:
  Avoid the need of HDMI cable to be connected for USB Joystick mode by reading Coin1+Coin2 combo at boot.
  Add an option to make USB Joystick Mode persistent, instead of reseting every reboot.
- User settings (Start1+Start2 at boot: countdown, wanted resolution, USB Joystick Mode persistence) are preserved after update.
- "Safe reboot" and "Safe shutdown" key combos are disabled if the CHA is in USB Joystick Mode.
- Fully compatible with older firmwares, no need to reinstall after upgrading firmware to v1.7
- If CHA OS is about to be updated all Choko scripts are skipped and a special script is set to run next boot (to restore files overwritten by 1.7 update).
- Fixed minor bug where default MENUCOUNTDOWN would be set to zero when going into settings.
- Updated uninstaller script.
- If SSH server from cha-1.7.img is running at boot, it is deactivated, use Choko Menu to activate server when needed.
- Updated SSH server script to use server from cha-1.7.img, if present.
- Check if SSH or FTP servers are already running before starting new server.

Read the file 'whatsnew.txt' to learn about what was new in past versions.


### Extras
- 'SSH and FTP servers' (un)installer
- 'Choko Hack Uninstaller' (why? I don't really know...)


### Types of Mods

We have now 3 modifications that are independent and can be combined as we wish:

A) Expand internal "disk" partition and add games to the original menu.

B) Use an USB drive to expand "disk" space and add games to the original menu.

C) Use a different operating system (Lakka or Batocera), with all the advantages and disadvantages it may have.

We can use one of this modifications, we can combine 2 or we can use them all.

Examples:
- Use only B and leave CHA running the original system by default, with 16 games. But when in the mood to play "X-Men vs Street Fighter", put the usb disk and add it to the list.
- Use A and B combined; put 85 Capcom games inside the CHA but when in the mood for some "Metal Slug", just insert the usb disk with Neo Geo games and enjoy.
- Use the three, A and B and C; fill the internal "disk" with Capcom games, use the usb disk with more games because internal "disk" is already full and install RetroArch to play those vertical games or other that the original system won't run.


###  Standard model and with SD Card reader (aka International model vs German model)

The Capcom Home Arcade has two different physical versions: with SD card reader and without (the standard).
Around 2000 units sold in Germany contains a SD Card Reader. If you have this SD Card reader, you can make the CHA boot from your SD card, the same way we can boot a PC from an USB disk or a DVD.

But we can add a SD Card reader to any CHA that doesn't have it, just need soldering skills. Look at the file https://github.com/ChokoGroup/Choko-Hack/blob/main/SD_card_reader.png for the type of adapter needed and go to https://github.com/lilo-san/cha-documentation#hardware for info on where it goes and more.
