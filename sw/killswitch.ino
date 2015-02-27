const int REED_SW = A0;
const int RED_LED1 = 3;
const int RED_LED2 = A4;
const int RED_LED3 = A2;
const int WHT_LED1 = A5;
const int WHT_LED2 = A3;
const int WHT_LED3 = A1;
//const int RED_BRIGHTNESS = 255;
//const int WHT_BRIGHTNESS = 255;

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
  int state = digitalRead(REED_SW);  //magnet in range, state=LOW
  digitalWrite(RED_LED1, state);
  digitalWrite(RED_LED2, state);
  digitalWrite(RED_LED3, state);
  digitalWrite(WHT_LED1, !state);
  digitalWrite(WHT_LED2, !state);
  digitalWrite(WHT_LED3, !state);
/*  
  analogWrite(RED_LED1, state * RED_BRIGHTNESS);    //glow RED when no magnet
  analogWrite(RED_LED2, state * RED_BRIGHTNESS);
  analogWrite(RED_LED3, state * RED_BRIGHTNESS);
  analogWrite(WHT_LED1, !state * WHT_BRIGHTNESS);   //glow WHITE when magnet
  analogWrite(WHT_LED2, !state * WHT_BRIGHTNESS);
  analogWrite(WHT_LED3, !state * WHT_BRIGHTNESS);
*/
}
