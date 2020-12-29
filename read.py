import serial
import time
from datetime import datetime
now = datetime.now()
ser = serial.Serial('/dev/ttyUSB0', 115200, timeout=0) 
f = open('myfile.txt','a')
f.write(str(now))
print(str(now))
f.close()
while 1:
   data=ser.readline()
   
   f = open('myfile.txt','a')
   print(data)
   #f.write(data)
   f.close()
   time.sleep(5) 

