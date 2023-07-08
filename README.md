# Choko-Hack v12.6.0
### Choko Hack for the Capcom Home Arcade


<p align="center"><img src="https://raw.githubusercontent.com/ChokoGroup/Choko-Hack/main/screenshot_golden_UI.png" style="width:40%"></p>


The Choko Hack will allow you to play more roms with the CHA original system. You can preserve the original software, add games or use an USB disk to play your roms.

Read the file '00 - Instructions.txt' to learn how to install.

You can also look into the 'Video Guide.gif' - it's a little outdated but still gives a good idea of the process.

Download the installer, updater or system images with the hack already installed from https://github.com/ChokoGroup/Choko-Hack/releases/latest

Some notes:
- This hack is a script loader, you need https://github.com/ChokoGroup/Choko-Hack-Automatic-Lists to create and load games lists with your ROMs, or you can also try [FinalBurn Neo emulator for CHA](https://github.com/ChokoGroup/FBNeo/tree/fbneo-CHA).
- If official list is the only option, the menu is skipped.
- If there is only one USB option (other than 16 official games) it is automatically loaded (menu is skipped).
- A default games list can be difined by selecting it and pressing Start (pressing Coin will reset the option to the first item of the list).
- Normal behaviour is joystick mode goes back to arcade mode after reboot, but If we change "joystick mode persistence" to Yes in settings (P1 Start + P2 Start) it will always boot into joystick mode **until disabled with P1 Coin + P2 Coin at boot**.


<p align="center"><img src="https://raw.githubusercontent.com/ChokoGroup/Choko-Hack/main/choko_menu_help.png" style="width:60%"></p>


### What's new in v12.6.0

- Great estability improvements. Hopefully, lots of under-the-hood changes will give us NO MORE CORRUPTED USB DISKS!
- New check for script files modified by Windows or Macintosh users, and convert to Linux EOL style if needed.
- New setting to unlock or disable Golden UI Choko easter-egg.
- If a file named `wpa_supplicant.conf` is included in installer/updater folder, it will be copied to the CHA. This allows to automatically configure WiFi. See the example file `wpa_supplicant.conf.example` included.
- Avoid that automatic execution of a single script from USB runs again automatically if returning to Choko Menu.
- Detect when official firmware update failed to download/install some files, alert the user and eventually start firmware reinstallation.
- Fixed not reading USB disk after firmware update.
- Fixed screen resolution setting going back to auto after firmware update.
- Fixed firmware update writing boot files in eMMC when using SD card.
- Visual improvements in settings menu and on reboot and shutdown, with color and "animation" (dots will be added until the machine is really shutdown).

Don't forget to also update your [Automatic Games Lists pack](https://github.com/ChokoGroup/Choko-Hack-Automatic-Lists).

Read the file 'what_was_new.txt' to learn about what was new in past versions.


<p align="center"><img src="https://raw.githubusercontent.com/ChokoGroup/Choko-Hack/main/screenshot_Choko_Menu.png" style="width:25%"> <img src="https://raw.githubusercontent.com/ChokoGroup/Choko-Hack/main/screenshot_Choko_Menu_settings.png" style="width:25%"> <img src="https://raw.githubusercontent.com/ChokoGroup/Choko-Hack/main/Screenshot_Shutdown_messages.png" style="width:25%"></p>


### Extras
- 'SSH and FTP servers' (un)installer
- 'Choko Hack Uninstaller' (why? I don't really know...)
- Source code for the input readers


### Types of Mods

We have now 3 modifications that are independent and can be combined as we wish:

A) Expand internal "disk" partition and add games to the original menu.

B) Use an USB drive to expand "disk" space and add games to the original menu or play them with [FinalBurn Neo emulator for CHA](https://github.com/ChokoGroup/FBNeo/tree/fbneo-CHA).

C) Use a different operating system (Lakka or Batocera), with all the advantages and disadvantages it may have.

We can use one of this modifications, we can combine two or we can use them all.

Examples:
- Use only B and leave CHA running the original system by default, with 16 games. But when in the mood to play "X-Men vs Street Fighter", put the usb disk and add it to the list.
- Use A and B combined; put 85 Capcom games inside the CHA but when in the mood for some "Metal Slug", just insert the usb disk with Neo Geo games and enjoy.
- Use the three, A and B and C; fill the internal "disk" with Capcom games, use the usb disk with more games because internal "disk" is already full and install RetroArch to play those vertical games or other that the original system won't run.


###  Standard model and with SD Card reader (aka International model vs German model)

The Capcom Home Arcade has two different physical versions: with SD card reader and without (the standard).
Around 2000 units sold in Germany contains a SD Card Reader. If you have this SD Card reader, you can make the CHA boot from your SD card, the same way we can boot a PC from an USB disk or a DVD.

But we can add a SD Card reader to any CHA that doesn't have it, just need soldering skills. Look at the file https://github.com/ChokoGroup/Choko-Hack/blob/main/SD_card_reader.png for the type of adapter needed and go to https://github.com/lilo-san/cha-documentation#hardware for info on where it goes and more.


###  Need help? Want to chat about CHA?

Join the Discord Channel at https://discord.gg/JbJTUAhc66


