To install CommuncationDataSensor:
    - git clone to "Blink", where is a folder in your TinyOS
    - Run with 2 sensors:
        - sensor1: in cmd : make telosb install.1 bsl,/dev/ttyUSB0
        - sensor2: in cmd : make telosb install.2 bsl,/dev/ttyUSB0
    
Plug sensor1 into ttyUSB0, and open "Serial port terminal".
sensor2 will transmit data to sensor1. 
sensor2's data :" du lieu vua gui : x, x, x" (light, temperature, humidity).
sensor1's data : "Sensor : node_id 
Current light : x    temp : x    humidity : x ".