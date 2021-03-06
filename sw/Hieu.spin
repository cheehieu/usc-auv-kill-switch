''****************************************
''*  Debug_Lcd Test (4x20 LCD) v1.2      *
''*  Authors: Jon Williams, Jeff Martin  *
''*  Copyright (c) 2006 Parallax, Inc.   *
''*  See end of file for terms of use.   *
''***************************************
''
'' v1.2 - March 26, 2008 - Updated by Jeff Martin to use updated Debug_LCD.
'' v1.1 - April 29, 2006 - Updated by Jon Williams for consistency.
''
'' Uses the Parallax 4x20 serial LCD to display a counter in decimal, hex, and binary formats.


CON
  _clkmode = xtal1 + pll16x                             ' use crystal x 16
  _xinfreq = 5_000_000                                  ' 5 MHz cyrstal (sys clock = 80 MHz)

  LCD_PIN   = 0                                         ' for Parallax 4x20 serial LCD on P0
  LCD_BAUD  = 2400
  LCD_LINES = 2
  MAG       = 1
  TOUCH     = 2

OBJ
  lcd : "debug_lcd"
  serial : "FullDuplexSerial"

Var
 long temp, col, row
 
  
PUB main | idx
  dira[MAG]~
  dira[TOUCH]~
  dira[16]~~
  dira[17]~~
  dira[18]~~
  dira[19]~~
  dira[20]~~
  dira[21]~~
  dira[22]~~
  dira[23]~~

  serial.start(31, 30, 0, 115200)
                                              
  if lcd.init(LCD_PIN, LCD_BAUD, LCD_LINES)             ' start lcd
    lcd.cls
    repeat
      lcd.cursor(0)                                       ' cursor off
      lcd.backLight(true)                                 ' backlight on (if available)
      lcd.custom(0, @Bullet)                              ' create custom character 0
      lcd.cls                                             ' clear the lcd
      lcd.home     
      lcd.str(string("Mag"))
      lcd.gotoxy(5,0)
      lcd.str(string("Touch"))
      lcd.gotoxy(0, 1)
      if ina[1] == 1
        lcd.str(string("off"))
      else
        lcd.str(string("on "))                             
      lcd.gotoxy(5, 1)
      if ina[2] == 1
        lcd.str(string("off"))
      else
        lcd.str(string("on "))       
      outa[16]:=ina[1]&ina[2]           'green: good (even)                      
      outa[17]:=!ina[1]|!ina[2]         'red: kill (odd)                     
      outa[18]:=ina[1]&ina[2]             
      outa[19]:=!ina[1]|!ina[2]
      outa[20]:=ina[1]&ina[2]             
      outa[21]:=!ina[1]|!ina[2]
      outa[22]:=ina[1]&ina[2]             
      outa[23]:=!ina[1]|!ina[2]
  

PRI updateLcd(value)

  lcd.gotoxy(12, 1)
  lcd.decf(value, 8)                                    ' print right-justified decimal value
  lcd.gotoxy(11, 2)
  lcd.ihex(value, 8)                                    ' print indicated (with $) hex
  lcd.gotoxy(7, 3)
  lcd.ibin(value, 12)                                   ' print indicated (with %) binary                
      
DAT

  Bullet      byte      $00, $04, $0E, $1F, $0E, $04, $00, $00

{{
┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                                   TERMS OF USE: MIT License                                                  │                                                            
├──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation    │ 
│files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,    │
│modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software│
│is furnished to do so, subject to the following conditions:                                                                   │
│                                                                                                                              │
│The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.│
│                                                                                                                              │
│THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE          │
│WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR         │
│COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,   │
│ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                         │
└──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
}} 