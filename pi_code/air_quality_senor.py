import serial
import time
import binascii  #用于二进制(byte类型数据)和ASCII的转换

class Multisensor():
    def __init__(self):
        self.ser = serial.Serial("/dev/ttyUSB0", 9600)
        self.time_sent=bytes.fromhex('42 78 01 00 00 00 00 FF')  #设置数据传输周期1s
        self.ser.write(self.time_sent)
        self.ser.flushInput()
    
    def serial_rec(self):
        count = self.ser.inWaiting()  #获取串口缓冲区数据
        while count != 0:
            recv=self.ser.read(count)
            '''返回二进制数据的十六进制表示形式(每个字节被转换为相应的2位十六进制表示形式),
            其中[2:-1]表示#截取该行从第三位到最后一个字符(换行符)之间的部分'''
            recv= str(binascii.b2a_hex(recv))[2:-1]  
            self.ser.flushInput()  #清空接收缓存区
            return recv

    #以下具体计算公式参见传感器模块文档
    def co2_count(self,recv):
        recv_co2 = recv[6:10] #截取CO2参数
        recv_co2_h = int(recv_co2[0:2],16) #高字节十六进制转换成十进制
        recv_co2_l = int(recv_co2[2:4],16) #低字节十六进制转换成十进制
        co2 = recv_co2_h*256 + recv_co2_l
        print('(1).CO2 ： %d ppm' %co2)
        return round(co2,2)  #返回参数保留小数点后2位

    def tvoc_count(self,recv):
        recv_tvoc = recv[10:14]  
        recv_tvoc_h = int(recv_tvoc[0:2],16)
        recv_tvoc_l = int(recv_tvoc[2:4],16)
        tvoc = float(recv_tvoc_h*256 + recv_tvoc_l)/10.0
        print('(2).TVOC ： %f ug/m3' %tvoc)
        return round(tvoc,2)

    def ch20_count(self,recv):
        recv_ch20 = recv[14:18]  
        recv_ch20_h = int(recv_ch20[0:2],16)
        recv_ch20_l = int(recv_ch20[2:4],16)
        ch20 = float(recv_ch20_h*256 + recv_ch20_l)/10.0
        print('(3).CH20 ： %f ug/m3' %ch20)
        return round(ch20,2)

    def pm25_count(self,recv):
        recv_pm25 = recv[18:22]  
        recv_pm25_h = int(recv_pm25[0:2],16)
        recv_pm25_l = int(recv_pm25[2:4],16)
        pm25 = recv_pm25_h*256 + recv_pm25_l
        print('(4).PM2.5 ： %d ug/m3' %pm25)
        return round(pm25,2)

    def humidity_count(self,recv):
        recv_humidity = recv[22:26]  
        recv_humidity_h = int(recv_humidity[0:2],16)
        recv_humidity_l = int(recv_humidity[2:4],16)
        srh = recv_humidity_h*256 + recv_humidity_l
        humidity = -6 + 125*float(srh)/ 2**16
        print('(6).Humidity ： %f %%RH' %humidity)
        return round(humidity,2)

    def temp_count(self,recv):
        recv_temp = recv[26:30]  
        recv_temp_h = int(recv_temp[0:2],16)
        recv_temp_l = int(recv_temp[2:4],16)
        stem = recv_temp_h*256 + recv_temp_l
        temp = -46.85 + 175.72*float(stem)/ 2**16
        print('(7).Temperature ： %f °C' %temp)
        return round(temp,2)

    def pm10_count(self,recv):
        recv_pm10 = recv[30:34]
        recv_pm10_h = int(recv_pm10[0:2],16)
        recv_pm10_l = int(recv_pm10[2:4],16)
        pm10 = recv_pm10_h*256 + recv_pm10_l
        print('(5).PM10 ： %d ug/m3' %pm10)
        return round(pm10,2)
    
    def read_sensor_data(self):  
        while True:
            recv = self.serial_rec()
            if recv != None and len(recv) == 38 and recv[0:6] == '01030e':
                sto_co2 = self.co2_count(recv)
                sto_tvoc = self.tvoc_count(recv)
                sto_ch20 = self.ch20_count(recv)
                sto_pm25 = self.pm25_count(recv)
                sto_pm10 = self.pm10_count(recv)
                sto_humidity = self.humidity_count(recv)
                sto_temp = self.temp_count(recv)
                break #直至接收到一次完整数据后退出本次循环        
                
        return sto_co2,sto_tvoc,sto_ch20,sto_pm25,sto_pm10,sto_humidity,sto_temp

if __name__ == '__main__':         
    try:
        multisensor = Multisensor()
        while True:
            multisensor.read_sensor_data()
            print('-----------------------')
    except KeyboardInterrupt:
        if multisensor.ser != None:
            multisensor.ser.close()

#查看串口的波特率stty -F /dev/ttyUSB0
