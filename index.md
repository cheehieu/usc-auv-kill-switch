---
layout: project
title: usc-auv-kill-switch
subtitle: A thruster enable, complete with capacitive touch sensor, magnetic reed switch, μC, LCD, LEDs.
---

<img src="http://niftyhedgehog.com/usc-auv-kill-switch/images/kill_switch_glow.jpg">

## Overview
A *kill switch* is arguably one of the most important components in any robotic system. This master enable is what will give humans the upper-hand in the event of an apocalyptic robot uprising.

This kill switch was designed for an autonomous underwater vehicle, serving as a thruster enable to initiate navigation or to "kill" the AUV when its thrusters go awry. Being interfaced to an underwater vehicle, the switch must be waterproof, easily accessible, and intuitive to use.

## Hardware
In my time with the USC AUV team, I built two versions of the kill switch. The first of which, was my first ever PCB design. The second revision was an effort to miniaturize the board and simplify the software interface.

Both kill switch boards were housed in a custom-built waterproof aluminium enclosure. Machined in our lab, the enclosure featured a transparent acrylic "window" to view sensor state, double o-ring seals for waterproofing, and a rotating shell with embedded neodymium magnet to trigger the hall sensor.

<img src="http://niftyhedgehog.com/usc-auv-kill-switch/images/kill_switch_enclosure.jpg">

### Rev. 1
This is the first PCB I ever designed. It was a 2-layer board designed with the free version of Eagle.
* Parallax Propeller microcontroller
* Red and green status LEDs
* 2x16 character LCD
* Magnetic hall sensor
* Capacitive touch sensor

<img src="http://niftyhedgehog.com/usc-auv-kill-switch/images/killswitch_rev1.png">

<img src="http://niftyhedgehog.com/usc-auv-kill-switch/images/kill_switch_v1.jpg">

### Rev. 2
This revision was an attempt to miniaturize the design and simplify the software interface with an Arduino. It was a 2-layer board designed with Altium Designer.
* Arduino Nano microcontroller module
* Super-bright CREE red and white status LEDs
* Magnetic hall sensor

<img src="http://niftyhedgehog.com/usc-auv-kill-switch/images/kill_switch_v2.jpg">

## Software
The kill switch code monitors the magnetic sensor, and outputs a corresponding digital signal to the host processor, which feeds the enable signal to a motor control driver. 

### Rev. 1
The Parallax Propeller microcontroller uses a programming language called Spin. The core input/output code is shown below. I also implemented a few LED patterns for special events including a color circulation, color flickering, and random.

```
MAG       = 1
TOUCH     = 2
...
'Display status on LCD
if ina[MAG] == 1
	lcd.str(string("off"))
else
	lcd.str(string("on "))
if ina[TOUCH] == 1
	lcd.str(string("off"))
else
	lcd.str(string("on "))
...
'Display status on LEDs
outa[16]:=ina[MAG]&ina[TOUCH]           'green: good (even)
outa[17]:=!ina[MAG]|!ina[TOUCH]         'red: kill (odd)
outa[18]:=ina[MAG]&ina[TOUCH]
outa[19]:=!ina[MAG]|!ina[TOUCH]
outa[20]:=ina[MAG]&ina[TOUCH]
outa[21]:=!ina[MAG]|!ina[TOUCH]
outa[22]:=ina[MAG]&ina[TOUCH]
outa[23]:=!ina[MAG]|!ina[TOUCH]
```


### Rev. 2
The Arduino Nano uses a simple sketch developed with the Arduino IDE.

```
const int REED_SW = A0;
const int RED_LED1 = 3;
const int RED_LED2 = A4;
const int RED_LED3 = A2;
const int WHT_LED1 = A5;
const int WHT_LED2 = A3;
const int WHT_LED3 = A1;

void setup() {                
  pinMode(REED_SW, INPUT); 
  pinMode(RED_LED1, OUTPUT);
  pinMode(RED_LED2, OUTPUT);
  pinMode(RED_LED3, OUTPUT); 
  pinMode(WHT_LED1, OUTPUT);  
  pinMode(WHT_LED2, OUTPUT);  
  pinMode(WHT_LED3, OUTPUT);
}

void loop() {
  int state = digitalRead(REED_SW);  	//magnet in range, state=LOW
  digitalWrite(RED_LED1, state);		//glow RED when no magnet
  digitalWrite(RED_LED2, state);
  digitalWrite(RED_LED3, state);
  digitalWrite(WHT_LED1, !state);		//glow WHITE when magnet
  digitalWrite(WHT_LED2, !state);
  digitalWrite(WHT_LED3, !state);
}
```

## 3D
<iframe width="640" height="480" src="https://sketchfab.com/models/898664f4c2684241bb64e732e865a336/embed" frameborder="0" allowfullscreen mozallowfullscreen="true" webkitallowfullscreen="true" onmousewheel=""></iframe>

<p style="font-size: 13px; font-weight: normal; margin: 5px; color: #4A4A4A;">
    <a href="https://sketchfab.com/models/898664f4c2684241bb64e732e865a336?utm_source=oembed&utm_medium=embed&utm_campaign=898664f4c2684241bb64e732e865a336" target="_blank" style="font-weight: bold; color: #1CAAD9;">Killswitch Rev2</a>
    by <a href="https://sketchfab.com/hieu?utm_source=oembed&utm_medium=embed&utm_campaign=898664f4c2684241bb64e732e865a336" target="_blank" style="font-weight: bold; color: #1CAAD9;">hieu</a>
    on <a href="https://sketchfab.com?utm_source=oembed&utm_medium=embed&utm_campaign=898664f4c2684241bb64e732e865a336" target="_blank" style="font-weight: bold; color: #1CAAD9;">Sketchfab</a>
</p>
