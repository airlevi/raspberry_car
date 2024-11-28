import smbus
import time
import math

class HMC5883():
    def __init__(self, address=0x1e,x_offset = 0.041304,y_offset = -0.132608): #HMC5883L设备地址0x1e
        self._address = address
        self._bus = smbus.SMBus(1)   #创建smbus实例,1代表/dev/i2c-1
        self.Magnetometer_config()
        self.x_offset = x_offset
        self.y_offset = y_offset

    def read_raw_data(self,addr): #addr为数据输出寄存器的高字节地址
        high = self._bus.read_byte_data(self._address, addr)  #读取高字节数据
        low  = self._bus.read_byte_data(self._address, addr+1)  #读取低字节数据
        value = (high << 8) + low
        if (value >= 0x8000):  #两个字节以补码的形式存储
            return -((65535 - value) + 1)
        else:   
            return value
        
    def Magnetometer_config(self):  #设置配置寄存器A、B和模式寄存器,参看数据手册
        self._bus.write_byte_data(self._address, 0, 0x74)  #配置寄存器A地址0x00
        self._bus.write_byte_data(self._address, 1, 0xe0)  #配置寄存器B地址0x01
        self._bus.write_byte_data(self._address, 2, 0)  #模式寄存器地址0x02

    '''XYZ轴数据输出寄存器高字节地址分别为0x03，0x07和0x05
    读取的原始数据除以增益'''
    def get_magnetic_xyz(self):
        x_data = self.read_raw_data(3) / 230.0  #X轴输出数据
        y_data = self.read_raw_data(7) / 230.0  #Y轴输出数据
        z_data = self.read_raw_data(5) / 230.0  #Z轴输出数据
        return [x_data,y_data,z_data]

    def read_HMC5883_data(self):
        x_data,y_data,z_data = self.get_magnetic_xyz()
        x_data = x_data - self.x_offset  #校正偏差
        y_data = y_data - self.y_offset  
        print('x轴磁场强度：', x_data, ' Gs')
        print('y轴磁场强度：', y_data, ' Gs')
        print('z轴磁场强度：', z_data, ' Gs')
        #计算航向角
        bearing = math.atan2(y_data, x_data)  
        if (bearing < 0):
            bearing += 2 * math.pi
        print("航向角：", math.degrees(bearing),"\n")  #将弧度转换为角度
        return round(math.degrees(bearing),2)  #保留小数点后2位
        
if __name__ == '__main__': 
    hmc = HMC5883()
    while True:
        hmc.read_HMC5883_data()
        time.sleep(1)
    
    
