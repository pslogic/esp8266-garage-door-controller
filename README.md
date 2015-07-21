# esp8266-garage-door-controller
Garage Door Control System Using the ESP8266

This control system replaces the typical remote controls provided as standard with modern garage door systems. The ESP8266 with NodeMCU firmware is used as the core controller. Activation of the sytem is via a mechanical relay wired in parallel with the wall mounted door switch. Garage door opening status is detected via a magnetic switch sensor typically used in security alarm systems.

OpenHAB with HABmin is used for home automation with Mosquitto as the MQTT broker. Both services are running on a Raspberry Pi 1 Model B and faciliate communication between the ESP8266 and a web client acting as the remote control unit.

*** Manifest:

<b>init.lua</b> - esp8266 boot code, primary purpose is to get an IP for the esp8266 and then execute program code

<b>program.lua</b> - esp8266 program code, main Lua executable; contains functional/feature code of the project

<b>default.items</b> - openHAB config file defining properties for the remote control function and door status report on the web client; placed in <code>/opt/openhab/configurations/items</code>

<b>opening.map</b> - openHAB config file defining the translation mapping for the doorstatus code published by program.lua; used in the presentation layer (sitemap) of the web client; placed in <code>/opt/openhab/configurations/transform</code>

<b>default.sitemap</b> - openHAB config file defining the look & feel of the user interface for the web client; placed in <code>/opt/openhab/configurations/sitemaps</code>

*** Reuse and guidance came from the following sources:

[1] ESP8266 Wifi Smart Garage Door (https://hackaday.io/project/4562-esp8266-wifi-smart-garage-door)

[2] Pete's Cyberspace (http://kayakpete.tumblr.com/post/112647900984/garage-door-opener-version-2-based-on-esp8226)

[3] Nodemcu and MQTT: How to start (https://primalcortex.wordpress.com/2015/02/06/nodemcu-and-mqtt-how-to-start/)

[4] Installing openHAB, Habmin and GreenT on a raspberry pi (Raspbian) (http://www.addictedtopi.com/post/92932590168/installing-openhab-habmin-and-greent-on-a)

[5] HABmin on Raspberry Pi, (An openHAB Admin Console) (http://www.instructables.com/id/openHAB-Admin-Console-HABmin-on-Raspberry-Pi/step3/Installation-Option-2-alternative/)

[6] How to configure a switch to be a pushbutton (https://code.google.com/p/openhab-samples/wiki/ItemDef#How_to_configure_a_switch_to_be_a_pushbutton:)

[7] ESP8266 Thing Hookup Guide / Powering the Thing (https://learn.sparkfun.com/tutorials/esp8266-thing-hookup-guide/powering-the-thing)

[8] Foscam IP camera URL (http://www.ispyconnect.com/man.aspx?n=foscam)

[9] Garage Genie - Parking & Remote Control (http://www.instructables.com/id/Garage-Genie-Parking-Remote-Control/?ALLSTEPS)

*** Development Environment:

[a] NodeMCU DevKit v0.9 with NodeMCU 0.9.5 build 20150318 powered by Lua 5.1.4

[b] Raspberry Pi 1 Model B with Raspbian Wheezy

[c] openHAB 1.7.0 (http://openhab.org)

[d] HABmin 0.1.4 (https://github.com/cdjackson/HABmin/archive/master.zip) *** NOTE: please see [5] above ***

[e] NodeMCU Flasher (https://github.com/nodemcu/nodemcu-flasher)

[f] ESP8266 Lua Loader v0.87 (http://benlo.com/esp8266/index.html#LuaLoader)

[g] My MQTT (https://play.google.com/store/apps/details?id=at.tripwire.mqtt.client&hl=en)

[h] Notepad++ v6.7.5 (https://notepad-plus-plus.org/)
