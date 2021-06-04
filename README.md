# Choko-Hack v12.0.0
### Choko Hack for the Capcom Home Arcade

The Choko Hack will allow you to play more roms with the CHA original system. You can preserve the original software, add games or use an USB disk to play your roms.

Read the file '00 - Instructions.txt' to learn how to install.

You can also look into the 'Video Guide.gif' - it's a little outdated but still gives a good idea of the process.


### What's new in v12.0.0
- Menu can now be navigated with player 1 joystick (UP and DOWN move 1 line, LEFT and RIGHT move 5 lines).
- Pressing both players Start button at startup will allow to change the timeout for USB and for menu default selection (zero disables automatic selection in menu) and optionally force screen resolution to 720p.
- File structure from version 11 is still valid, but now ROMs folders can have any name (that name will be used for the menu list).
- We are now not limited to one item per button but to screen number of rows; all available options are listed at once (USB and internal).
- New exit code 202 to allow scripts returning to menu without rebooting the CHA.
- Use 'readjoysticks' to read input, instead of relying in 'evtest' (lighter and faster; source code included).


### Extras
- 'SSH and FTP servers' (un)installer
- 'Choko Hack Uninstaller' (why? I don't really know...)


### Types of Mods

We have now 3 modifications that are independent and can be combined as we wish:

A) Expand internal "disk" partition and add games to the original menu.

B) Use an USB drive to expand "disk" space and add games to the original menu.

C) Use a different operating system (Lakka), with RetroArch as user interface, with all the advantages and disadvantages it may have.

We can use one of this modifications, we can combine 2 or we can use them all.

Examples:
- Use only B and leave CHA running the original system by default, with 16 games. But when in the mood to play "X-Men vs Street Fighter", put the usb disk and add it to the list.
- Use A and B combined; put 85 Capcom games inside the CHA but when in the mood for some "Metal Slug", just insert the usb disk with Neo Geo games and enjoy.
- Use the three, A and B and C; fill the internal "disk" with Capcom games, use the usb disk with more games because internal "disk" is already full and install RetroArch to play those vertical games or other that the original system won't run.


###  Standard model and with SD Card reader (aka International model vs German model)

The Capcom Home Arcade has two different physical versions: with SD card reader and without (the standard).
Around 2000 units sold in Germany contains a SD Card Reader. If you have this SD Card reader, you can make the CHA boot from your SD card, the same way we can boot a PC from an USB disk or a DVD.

But we can add a SD Card reader to any CHA that doesn't have it, just need soldering skills and follow this guide: https://cha-choko-mod.fandom.com/wiki/SD_Card_reader_MOD
