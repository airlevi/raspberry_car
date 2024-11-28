import serial
import gps_transform
import time

ser=serial.Serial("/dev/ttyAMA0",9600)
def GPS():
    str_gps=ser.read(1200)
    #转换成utf-8编码输出，避免乱码
    str_gps=str_gps.decode(encoding = 'utf-8', errors = 'ignore')

    pos1=str_gps.find("$GNRMC")
    pos2=str_gps.find("\n",pos1)
    loc=str_gps[pos1:pos2]
    data=loc.split(",")

    if data[2]=='V':
        print("No location found")
        pass
    else:
        position_lat=float(data[3][0:2]) + float(data[3][2:9]) / 60.0
        position_lng = float(data[5][0:3]) + float(data[5][3:10]) / 60.0
        print('position_lat:',position_lat)
        print('position_lng:',position_lng)
        position_lng,position_lat = gps_transform.wgs84_to_gcj02(position_lng, position_lat)
        position_lng,position_lat = gps_transform.gcj02_to_bd09(position_lng, position_lat)
        time = data[1]
        time_h = int(time[0:2])+8 #调整为北京时间
        time_m = int(time[2:4])
        time_s = int(time[4:6])  
        print("经度： %f %s" % (position_lng, data[6]))
        print("纬度： %f %s" % (position_lat, data[4]))
        print("时间： %d h %d m %d s\n" % (time_h, time_m, time_s))
        return [round(position_lng,6), data[6],round(position_lat,6), data[4]]
        
if __name__ == "__main__":
    try:
        while True:
            GPS()
            time.sleep(5)
    except KeyboardInterrupt:
        ser.close()  
    
