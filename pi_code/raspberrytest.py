import requests
import json
import time
import random
import gps 
import hmc5883l
import air_quality_senor

url = 'http://192.168.1.107/server_demo/dataupload.php'
headers = {'content-type' : "application/json", 'charset' : 'utf-8'}
while True:
    hmc = hmc5883l.HMC5883()
    sto = air_quality_senor.Multisensor()
    angle = hmc.read_HMC5883_data()
    time.sleep(0.5)
    sto_co2,sto_tvoc,sto_ch20,sto_pm25,sto_pm10,sto_humidity,sto_temp = sto.read_sensor_data()
    time.sleep(0.5)
    gps_lng,data_6,gps_lat,data_4 = gps.GPS()
    time.sleep(0.5)

    body = {"node_id" : "1",
            "lng" : gps_lng,
            "lat" : gps_lat,
            "temperature" : sto_temp,
            "humidity" : sto_humidity,
            "co2" : sto_co2,
            "tvoc" : sto_tvoc,
            "ch2o" : sto_ch20,
            "pm25" : sto_pm25,
            "pm10" : sto_pm10,
            "heading_angle" : angle
        }

    response = requests.post(url, data = json.dumps(body), headers = headers)



