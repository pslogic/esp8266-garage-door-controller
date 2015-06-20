-- constants
STATION_IDLE = 0
STATION_CONNECTING = 1
STATION_WRONG_PASSWORD = 2
STATION_NO_AP_FOUND = 3
STATION_CONNECT_FAIL = 4
STATION_GOT_IP = 5

print("Boot Start")
if wifi.sta.status() ~= STATION_GOT_IP then tmr.alarm(6, 10000, 0, function(d) dofile('init.lua') end) return end
if wifi.sta.status() == STATION_GOT_IP then print(wifi.sta.getip()) dofile('program.lua') return end