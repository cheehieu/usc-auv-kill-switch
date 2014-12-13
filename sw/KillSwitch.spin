CON
  _clkmode = xtal1 + pll8x                             ' use crystal x 8
  _xinfreq = 10_000_000
  
OBJ
  lcd : "Serial_Lcd"
  serial : "FullDuplexSerial"         

VAR
  long switchStatus, kill
  long stack[24]
  long temp

PUB Main
  cognew(statusLCD,@stack)
  dira[1..22]~~                             
     
  repeat
    outa[1]:=!ina[0]'|!ina[23]                            'red: kill (odd) 
    outa[3]:=!ina[0]'|!ina[23]  
    outa[5]:=!ina[0]'|!ina[23]              
    outa[7]:=!ina[0]'|!ina[23]  
    outa[8]:=!ina[0]'|!ina[23]  
    outa[11]:=!ina[0]'|!ina[23]    
    outa[13]:=!ina[0]'|!ina[23]  
    outa[15]:=!ina[0]'|!ina[23]
    outa[17]:=!ina[0]'|!ina[23]  
    outa[19]:=!ina[0]'|!ina[23]   
    outa[21]:=!ina[0]'|!ina[23]      

    outa[2]:=ina[0]'&ina[23]                              'green: good (even)
    outa[4]:=ina[0]'&ina[23]   
    outa[6]:=ina[0]'&ina[23]
    outa[9]:=ina[0]'&ina[23]      
    outa[10]:=ina[0]'&ina[23]
    outa[12]:=ina[0]'&ina[23]        
    outa[14]:=ina[0]'&ina[23]
    outa[16]:=ina[0]'&ina[23]    
    outa[18]:=ina[0]'&ina[23]  
    outa[20]:=ina[0]'&ina[23]
    outa[22]:=ina[0]'&ina[23]  



PUB statusLCD
  serial.start(31, 30, 0, 57600)
  if lcd.init(27, 19200, 2)                            ' start lcd
    lcd.cursor(1)                                       ' cursor on
    lcd.backLight(true)                                 ' backlight on (if available)
    lcd.cls                                             ' clear the lcd         
    lcd.home   
    {lcd.str(string("Mag   "))
    lcd.str(string("Touch"))
    repeat
      lcd.gotoxy(0, 1)
      if ina[0] == 0
        lcd.str(string("Go  "))
      else
        lcd.str(string("Kill"))                             
      lcd.gotoxy(6, 1)
      if ina[23] == 0
        lcd.str(string("Go  "))
      else
        lcd.str(string("Kill"))}
    repeat
      temp := Serial.rx
      if temp == $1b 
        lcd.cls
        lcd.home
      else
        lcd.putc(temp)

PUB Circle(Pin, Delay, Count)
{{Toggle Pin, Count times with Delay clock cycles in between.}}

  repeat Pin from 1 to 21 STEP 1
    dira[Pin]~~                'Set I/O pin to output direction
    outa[Pin] := 0
  repeat                'Repeat for Count iterations
    repeat Pin from 1 to 21 STEP 1
      !outa[Pin]               '  Toggle I/O Pin
      waitcnt(Delay + cnt)     '  Wait for Delay cycles

PUB Flicker(Delay, Count)                                    
  repeat Count
    dira[1..22]:=%01010100_11010101_010101                               'Green on
    waitcnt(Delay+cnt)      
    dira[1..22]:=%00000000_00000000_000000     
    waitcnt(Delay+cnt)
    dira[1..22]:=%10101011_00101010_101010                               'Red on
    waitcnt(Delay+cnt)      
    dira[1..22]:=%00000000_00000000_000000     
    waitcnt(Delay+cnt)

PUB Random(Delay, Count)
  repeat
    '?   Random number forward (?X) or reverse (X?)    