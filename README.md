# esp8266-garage-door-controller
Garage Door Control System Using the ESP8266

This control system replaces the typical remote controls priovided as standard with modern garage door systems. The ESP8266 with NodeMCU firmware is used as the core controller. Activation of the sytem is via a mechanical relay wired in parallel with the wall mounted door switch. Garage door opening status is detected via a magnetic switch sensor typically used in security alarm systems.

OpenHAB with HABmin is used for home automation with Mosquitto as the MQTT broker. Both services are running on a Raspberry Pi 1 Model B and faciliate communication between the ESP8266 and a mobile Android client acting as the remote control unit.

*** Reuse and guidance came from the following sources:

[1] ESP8266 Wifi Smart Garage Door (https://hackaday.io/project/4562-esp8266-wifi-smart-garage-door)

[2] Pete's Cyberspace (http://kayakpete.tumblr.com/post/112647900984/garage-door-opener-version-2-based-on-esp8226)

[3] Nodemcu and MQTT: How to start (https://primalcortex.wordpress.com/2015/02/06/nodemcu-and-mqtt-how-to-start/)

[4] Installing openHAB, Habmin and GreenT on a raspberry pi (Raspbian) (http://www.addictedtopi.com/post/92932590168/installing-openhab-habmin-and-greent-on-a)

[5] HABmin on Raspberry Pi, (An openHAB Admin Console) (http://www.instructables.com/id/openHAB-Admin-Console-HABmin-on-Raspberry-Pi/step3/Installation-Option-2-alternative/)

*** Development Environment:

[a] NodeMCU DevKit v0.9 with NodeMCU 0.9.5 build 20150318 powered by Lua 5.1.4

[b] Raspberry Pi 1 Model B with Raspian Wheezy

[c] openHAB 1.7.0 (http://openhab.org)

[d] HABmin 0.1.4 (https://github.com/cdjackson/HABmin/archive/master.zip) *** NOTE: please see [5] above ***

[e] NodeMCU Flasher (https://github.com/nodemcu/nodemcu-flasher)

[f] ESP8266 Lua Loader v0.87 (http://benlo.com/esp8266/index.html#LuaLoader)
