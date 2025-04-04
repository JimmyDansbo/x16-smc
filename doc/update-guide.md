# SMC firmware update guide

## Contents

[In-system update](#in-system-update)
- [Bootloader v1](#bootloader-v1)
- [Bootloader v2](#bootloader-v2)
- ["Bad" bootloader v2](#bad-bootloader-v2)
- [Bootloader v3](#bootloader-v3)

[In-system recovery with bootloader v3](#in-system-recovery-with-bootloader-v3)

[In-system update of the bootloader](#in-system-update-of-the-bootloader)

[External programmer](#external-programmer)

## In-system update

The firmware can be updated from within the X16 without any external tools:

- Download SMCUPDATE-x.x.x.PRG, where x.x.x is the SMC firmware version
- Copy the file to your SD card and insert the SD card into your X16
- LOAD the SMCUPDATE-x.x.x.PRG program and RUN it
- The new firmware is embedded into the program and you need no other files
- Follow the on-screen instructions

The update procedure differes slightly depending on which bootloader version
is installed on your SMC.

### Bootloader v1

If your SMC has bootloader v1 installed the SMC enters into an
infinite loop after finishing the update. Just disconnect the X16
from mains power, wait until the LEDs go out, and then reconnect the
X16 again.

There are no known issues with bootloader v1.

### Bootloader v2

Bootloader v2 differs from v1 in that the SMC will reset and power
off after finishing the update. There is no need to disconnect the
computer from mains power.

### "Bad" bootloader v2

Some production boards were delivered with a corrupted version
of bootloader v2, often referred to as a "bad" bootloader.

It is almost certain that you have got the bad bootloader if 
```PRINT I2CPEEK($42,$8E)``` returns 2 (bootloader version) and 
any of the following is true:

- the serial number of your X16 board is between PR00100 and PR00900
- the ```HELP``` command shows that you have got SMC firmware
version 45.1.0

The SMCUPDATE program will display a warning if there is a 
risk that you have got the bad bootloader. There is, however, no
way for the program to determine for sure before the update has started.

Even with the bad bootloader, the update works until the very
final stage where it enters an infinite loop instead of resetting
the SMC and powering off the system.

The SMCUPDATE program will notify you at the end of the update
process if you have got the bad bootloader.

If this happens it is important **not** to disconnect the computer
from mains power. Doing that will brick the SMC firmware, requiring
you to update it with an external programmer.

There is a tested procedure to make the update work with the
bad bootloader. Read about it [here](update-with-bad-bootloader-v2.md).
In short, you need to reset the SMC by connecting reset pin #10
to ground using a piece of wire.

### Bootloader v3

Bootloader v3 will also reset the SMC and power off the
computer when the update is done. There is no need to
disconnect the computer from mains power.

Bootloader v3 is reworked to be safer than the earlier versions.
It also enables the SMCUPDATE program to verify the firmware
after an update.

## In-system recovery with bootloader v3

Bootloader v3 supports recovery of the SMC even if a
firmware update failed and left the SMC inoperable (bricked).
This can happen, for instance, if the update process is
interrupted.

The recovery update requires that you store SMCUPDATE-x.x.x.PRG
on the SD card as file name AUTOBOOT.X16. If you already
have a file named AUTOBOOT.X16, remember to back it up first.

Disconnect the computer from mains power and wait until
the LEDs go out.

Press and hold the Reset button while you reconnect the
computer to mains power. The computer will turn on and 
you may release the Reset button as soon as you see
that the Power LED has turned on.

The computer automatically loads and runs the file 
AUTOBOOT.X16, which will update the SMC firmware without user interaction
after a countdown.

If you want to abort you must disconnect the
computer from mains power before the end of the countdown.

The SMC is reset and the computer is turned off after
the update is finished. You may turn on the computer
again and delete AUTOBOOT.X16.


## In-system update of the bootloader

Since SMC firmware version 47.2.0 it is possible to
do an in-system update of the bootloader itself.

Use the [SMC bootloader tools](smc-bootloader-tools.md)
to do that.

**WARNING:** It is not recommended downgrade the bootloader from
version 3 to version 2 or 1 using those tools. If you do 
that the SMC firmware must be updated after the
bootloader downgrade but before the SMC is reset or
power cycled. Otherwise, the SMC will become
non-functional.


## External programmer

Programming the X16 with an external programmer
requires that the SMC microchip is removed from the
X16 board.

Ensure that the X16 is disconnected from mains
power before you start, as the SMC is always
powered.

To prevent damaging the X16 board, it is recommended 
to use an anti-static wrist band when touching the board
or its components.

It is possible to program the SMC with a TL866 series
programmer, but at least some of the programmers in that
series have problem setting the extended fuse correctly.

It is therefore recommended to program the SMC
with the commmand line utility avrdude and a 
programmer that is compatible with that utility.

For further information, go to the [guide on recovery with an Arduino](recovery-with-arduino.md).
