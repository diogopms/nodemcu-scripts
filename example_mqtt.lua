--- MQTT ---
wifi.setmode(wifi.STATION)
wifi.sta.config("SSID","PASSWORD")
print(wifi.sta.getip())

--- MQTT ---
mqtt_broker_ip = "test.mosquitto.org"     
mqtt_broker_port = 1883
mqtt_topic = "diogo/tests"
mqtt_client_id = node.chipid()
gas_sensor = 0

function get_sensor_Data() 
    gas_sensor = math.random(17,41)
end

tmr.alarm(0, 1000, 1, function()
    m = mqtt.Client(mqtt_client_id, 60)
    m:connect(mqtt_broker_ip, mqtt_broker_port, 3000, function()
        tmr.wdclr()
        get_sensor_Data()
        m:publish(mqtt_topic, gas_sensor, 0, 0, function()
            print("Message Sent!")
            tmr.wdclr()
            m:close()
        end)    
   end)
end)

