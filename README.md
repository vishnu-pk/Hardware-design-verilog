# Hardware-design-verilog
Hardware design course based on Intel Labs FPGA


Lab Questions can be foud here and also in the files in repository.
https://www.intel.com/content/www/us/en/programmable/support/training/university/materials-lab-exercises.html

Device used is DE10-Lite 
Terasic DE10-Lite is a cost-effective Altera MAX 10 based FPGA board. The board utilizes the maximum capacity MAX 10 FPGA, which has around 50K logic elements(LEs) and on-die analog-to-digital converter (ADC). It features on-board USB-Blaster, SDRAM, accelerometer, VGA output, 2x20 GPIO expansion connector, and an Arduino UNO R3 expansion connector in a compact size. The kit provides the perfect system-level prototyping solution for industrial, automotive, consumer, and many other market applications.

The DE10-Lite kit also contains lots of reference designs and software utilities for users to easily develop their applications based on these design resources.

Find it here:
https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&No=1021&PartNo=8
or Just find it on amazon

DEVICE INFORMATION

### FPGA Device
MAX 10 10M50DAF484C7G Device
Integrated dual ADCs, each ADC supports 1 dedicated analog input and 8 dual function pins
50K programmable logic elements
1,638 Kbit M9K Memory
144 18 × 18 Multiplier
4 PLLs
### Programming and Configuration
On-Board USB Blaster (Normal type B USB connector)
### Memory Device
64MB SDRAM, x16 bits data bus
### Sensor
Accelerometer
### Expansion Connectors
One 2x20 GPIO Connector(voltage levels: 3.3V)
Arduino Uno R3 Connector, including six ADC channels.
### Display
4-bit Resistor VGA
### Switches/Buttons/LEDs/7-Segment Display
10 LEDs
10 Slide Switches
2 Push Buttons
Six 7-Segments Display
### Power
5V DC input


What can you find in here.
•Implement combinational and sequential logic using an HDL and and an FPGA
•Simulate and verify logic designs using a simulator and an HDL
•Present complex, technical information in an oral presentation

You may not find all the labs, I tried to put in as many as I could. If you have the code working for the ones that I haven't added here please feel free to add them. Together we learn better. 

Please note that this is to be used only as help. 

## HOW TO USE THIS
1. Download intel Quartus Prime Lite software. http://fpgasoftware.intel.com/?edition=lite (This is a free version you can also use pro versions)
2. Download all the files in this repository.
3. compile the program and dump it on to the board.

If you come across issues I suggest to look into these things 
1. Pin assignments go to assignments-> Remove Assignments and then go ahead and do assignments-> Import Assignments -> select file "DE10_Lite.qsf". 
2. Make sure you have the USB drivers installed for the board. typically says "USB BLASTER".
3. Make sure the particular device is selected "10M50DAF484C7G" (Note: This is the particular board I used. You should be able to find yours on the box).
4. simulation couldn't run issues assignments-> settings -> EDA Tools check for correct path.




<Let's design hardware>
