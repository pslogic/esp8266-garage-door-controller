-- Initialize global constants--
BROKER="192.168.1.83"
DEVICE="esp8266_" .. wifi.sta.getmac()
REMOTECONTROL=6 -- NodeMCU D6 / GPIO12
DOORSTATUS=1 -- NodeMCU D1 / GPIO05

-- constants
STATION_IDLE = 0
STATION_CONNECTING = 1
STATION_WRONG_PASSWORD = 2
STATION_NO_AP_FOUND = 3
STATION_CONNECT_FAIL = 4
STATION_GOT_IP = 5

-- DOORSTATUS is a floating input connected to a magnetic switch with internal pullup enabled  
gpio.mode(DOORSTATUS,gpio.INPUT,gpio.FLOAT)  
gpio.write(DOORSTATUS,gpio.PULLUP)
-- REMOTECONTROL is an output initialized to logic high and connected to a relay
gpio.mode(REMOTECONTROL,gpio.OUTPUT)  
gpio.write(REMOTECONTROL,gpio.LOW)  

print("Program Start")
print("I am Device " .. DEVICE)

-- subscribe to remotecontrol messages
function mqtt_sub() 
	m:subscribe("openhab/garage/remotecontrol",0, function(client) print("Subscribed remotecontrol")
		if pcall(pubdoorstatus) then
			print("Publish doorstatus success")
		else
			print("Publish doorstatus failed")
		end
	end)
end 

-- reconnect to wifi and/or broker 
function reconnect()
	print ("Waiting for WiFi...")

	if wifi.sta.status() == STATION_GOT_IP and wifi.sta.getip() ~= nil then 
		print ("WiFi Up!")
		tmr.stop(1) 
	
		m:connect(BROKER, 1883, 0, function(client) print("Connected to MQTT")
			mqtt_sub() --run the subscripion function 
		end)
	end
end

-- publish a state change to doorstatus
function pubdoorstatus()
   state = gpio.read(DOORSTATUS)
   m:publish("openhab/garage/doorstatus",state,0,0, function(client) print("Published doorstatus")
      print("Door status is " .. state)
   end)
end

-- Start up MQTT
m = mqtt.Client(DEVICE, 120)
m:lwt("/lwt", DEVICE, 0, 0)

-- establish connection with broker
m:connect(BROKER, 1883, 0, function(client) print("Connected to MQTT")
	mqtt_sub() --run the subscription function 
end) 

-- broker is offline and/or wifi is down
m:on("offline", function(con) 
	print ("Reconnecting to MQTT...") 
	tmr.alarm(1, 10000, 1, function() 
		reconnect()
	end) 
end)

-- remotecontrol activated
m:on("message", function(client, topic, msg) print("Received:" .. topic .. ":" .. msg)   
   if (msg=="TOGGLE") then  -- Activate Door Button
      print("Activated remotecontrol") -- manual door control is normally open (NO)
      gpio.write(REMOTECONTROL,gpio.HIGH)  
      tmr.delay(1000000) -- wait 1 second
      gpio.write(REMOTECONTROL,gpio.LOW)  
   else  
      print("Invalid - Ignoring")   
   end   
end)

-- doorstatus triggered
gpio.trig(DOORSTATUS, "both", function(level) print("Triggered doorstatus")
   if pcall(pubdoorstatus) then
      print("Publish doorstatus success")
   else
      print("Publish doorstatus failed")
   end
end)

