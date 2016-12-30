# Eetlijst-Indicator
ESP8266 based indicator for a popular dutch site eetlijst.nl to see who is going to cook, eat, or will not be at dinner.

![Final](https://github.com/wytsem/Eetlijst-Indicator/blob/master/Pictures/EetlijstIndicator.jpg)

# Summary

- Firmware with build-in WS2812 module
- Acces point to login and your fill in your wifi and Eetlijst.nl credentials
- Acceses Eetlijst through mobile page for day by day indication
- Leds corresponts with name from Eetlijst.nl from left to right

## Useful links

| Resource | Location |
| -------------- | -------------- |
| Developer Wiki       | https://github.com/nodemcu/nodemcu-firmware/wiki |
| API docs             | [NodeMCU api](https://github.com/nodemcu/nodemcu-firmware/wiki/nodemcu_api_en) |
| Home                 | [nodemcu.com](http://www.nodemcu.com) |
| BBS                  | [Chinese BBS](http://bbs.nodemcu.com) |
| Docs                 | [NodeMCU docs](http://www.nodemcu.com/docs/) |
| Tencent QQ group     | 309957875 |
| Windows flash tool   | [nodemcu-flasher](https://github.com/nodemcu/nodemcu-flasher) |
| Linux flash tool     | [Esptool](https://github.com/themadinventor/esptool) |
| ESPlorer GUI         | https://github.com/4refr0nt/ESPlorer |
| NodeMCU Studio GUI   | https://github.com/nodemcu/nodemcu-studio-csharp |


# Flash the firmware

## Flash tools for Windows

You can use the [nodemcu-flasher](https://github.com/nodemcu/nodemcu-flasher) to burn the firmware.

## Flash tools for Linux

Esptool is a python utility which can read and write the flash in an ESP8266 device. See https://github.com/themadinventor/esptool

## Preparing the hardware for firmware upgrade

To enable ESP8266 firmware flashing, the GPIO0 pin must be pulled low before
the device is reset. Conversely, for a normal boot, GPIO0 must be pulled high
or floating.

If you have a [NodeMCU Development Kit](http://www.nodemcu.com/index_en.html) then
you don't need to do anything, as the USB connection can pull GPIO0
low by asserting DTR, and reset your board by asserting RTS.

If you have an ESP-01 or other device without inbuilt USB, you will need to
enable flashing yourself by pulling GPIO0 low or pressing a "flash" switch.

![Schematic Flash](https://github.com/wytsem/Eetlijst-Indicator/blob/master/Schematic_flash.png)

## Files to burn to the flash

Flash the .bin file onto your ESP8266 module, you can flash that file directly to address 0x00000.

# Connecting to your NodeMCU device

NodeMCU serial interface uses 9600 baud at boot time. To increase the speed after booting, issue `uart.setup(0,115200,8,0,1,1)` (ESPlorer will do this automatically when changing the speed in the dropdown list).

If the device panics and resets at any time, errors will be written to the serial interface at 115200 bps.

# User Interface tools

## Esplorer

Victor Brutskiy's [ESPlorer](https://github.com/4refr0nt/ESPlorer) is written in Java, is open source and runs on most platforms such as Linux, Windows, Mac OS, etc.

With the Esplorer you can upload the lua, html, and css files on your ESP8266. 

# Use of the Eetlijst indicator

When you have uploaded the files to your ESP8266 you can power it up.

- Connect a WS2812b ledstrip to GPIO2 (pin4) of the ESP8266, the amount of leds is dependend on the number of people in the eetlijst group you have.
- When power is applied the first led should light up red, a acces point is created (Eetlijst 192.168.4.1).
- Connect to the acces point and go to 192.168.4.1 if this doesn't work try reset the ESP8266 or a new tab in your browser
- Fill in all your credentials and click on connect
- The leds should now light up corresponding with your eetlijst account

When you want to change your eetlijst credentials look up the ip adress of the ESP8266 module, you can find it in your router, and put the IP adress in your brouwser and you can change your credentials.

![Schematic](https://github.com/wytsem/Eetlijst-Indicator/blob/master/Schematic.png)

![Final](https://github.com/wytsem/Eetlijst-Indicator/blob/master/Pictures/Inside.jpg)



## Troubleshooting

### The first led is red
The ESP8266 can't make a connection to your wifi network. Make sure that your network is up and running and reset the module. If there is still no connection go the the ESP acces point and try again with the new filled in credentials.

### The first led is red and flashing
If the first led is flasing red your eetlijst credentials where not right or there was no internet connection. Try resetting the ESP8266.
If this does not work find the IP adres of your ESP8266, look it up in your router, and type the IP adress in your browser. Fill your eetlijst credentials in and you should be good to go.
