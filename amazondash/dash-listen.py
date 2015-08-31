import logging
logging.getLogger("scapy.runtime").setLevel(logging.ERROR) # helps ignore warnings about IPv6
from scapy.all import *
import paho.mqtt.client as mqtt

BROKER="localhost" # executes on the same Raspberry Pi as the MQTT broker

# connection result code constants
SUCCESSFUL = 0
INCORRECT_PROTOCOL_VERSION = 1
INVALID_CLIENT_IDENTIFIER = 2
SERVER_UNAVAILABLE = 3
BAD_USERNAME_PASSWORD = 4
NOT_AUTHORIZED = 5

# examine ARP packets for the MAC addresses of the Amazon Dashes
def arp_detect(pkt):
	if pkt.haslayer(ARP):
		if pkt[ARP].op == 1: #who-has (request)
			if pkt[ARP].psrc == '0.0.0.0': # ARP Probe
				if pkt[ARP].hwsrc == '82:f6:52:47:27:e6': # amazon dash-01 primary MAC address
					print "Publish remotecontrol success: amazon dash-01 primary"; 
					mqttc.publish("openhab/garage/remotecontrol","TOGGLE")
				elif pkt[ARP].hwsrc == '74:c2:46:9d:d4:46': # amazon dash-01 alternate MAC address
					print "Publish remotecontrol success: amazon dash-01 alternate"; 
					mqttc.publish("openhab/garage/remotecontrol","TOGGLE")
				else:
					print "ARP Probe from unknown device: " + pkt[ARP].hwsrc

# callback function for connection attempt to MQTT broker
def on_connect(client, userdata, flags, rc):
	if (rc == SUCCESSFUL):
		print "MQTT Connected"
	else:
		print "Connection Result Code: " + str(rc)

# callback function for publish attempt to MQTT broker
def on_publish(client, userdata, mid):
    print("Message ID: " + str(mid))
	
mqttc = mqtt.Client("amazon_dash")
mqttc.connect(BROKER, 1883)
mqttc.on_connect = on_connect
mqttc.on_publish = on_publish
mqttc.loop_start()

while True:
	print sniff(prn=arp_detect, filter="arp", store=0, count=0)
