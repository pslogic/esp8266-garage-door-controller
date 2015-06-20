-- Initialize global constants--
BROKER="192.168.1.139"
DEVICE="esp8266_" .. wifi.sta.getmac()
REMOTECONTROL=2 -- NodeMCU D2 / GPIO04
DOORSTATUS=1 -- NodeMCU D1 / GPIO05

-- DOORSTATUS is a floating input connected to a magnetic switch with internal pullup enabled  
gpio.mode(DOORSTATUS,gpio.INPUT,gpio.FLOAT)  
gpio.write(DOORSTATUS,gpio.PULLUP)
-- REMOTECONTROL is an output initialized to logic high and connected to a relay
gpio.mode(REMOTECONTROL,gpio.OUTPUT)  
gpio.write(REMOTECONTROL,gpio.LOW)  

print("Program Start")
print("I am Device " .. DEVICE)

-- Start up MQTT
m = mqtt.Client(DEVICE, 120)
m:lwt("/lwt", DEVICE, 0, 0)
m:connect(BROKER, 1883, 0, function(client) print("Connected MQTT")
   m:subscribe("openhab/garage/remotecontrol",0, function(client) print("Subscribed remotecontrol")
      if pcall(pubdoorstatus) then
         print("Publish doorstatus success")
      else
         print("Publish doorstatus failed")
      end
   end)
end)

-- Reconnect to mqtt server if needed !!! this code block is incorrect somehow... causes lockup/hard reset
--m:on("offline", function(client) print ("Reconnecting...")
--   tmr.alarm(1, 10000, 0, function()
--      m:connect(BROKER, 1883, 0, function(client) print("Connected MQTT")
--         m:subscribe("openhab/garage/remotecontrol",0, function(client) print("Subscribed remotecontrol") 
--            if pcall(pubdoorstatus) then
--               print("Publish doorstatus success")
--            else
--               print("Publish doorstatus failed")
--            end
--         end)
--      end)
--   end)
--end)

-- doorstatus triggered
gpio.trig(DOORSTATUS, "both", function(level) print("Triggered doorstatus")
   if pcall(pubdoorstatus) then
      print("Publish doorstatus success")
   else
      print("Publish doorstatus failed")
   end
end)

function pubdoorstatus()
   state = gpio.read(DOORSTATUS)
   m:publish("openhab/garage/doorstatus",state,0,0, function(client) print("Published doorstatus")
      print("Door status is " .. state)
   end)
end

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