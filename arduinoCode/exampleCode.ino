const int outputPins[3] = {2,3,4};
const int inputPins [6] = {5,6,7,8,9,16};
const int joy1Pins [3] = {A3,A2,13};
const int joy2Pins [3] = {A1,A0,15};
const int potentiometerPin = A10;

void setup() {
  Serial.begin(9600);
  while(!Serial){;}
  
  for (int i=0;i<sizeof(outputPins) / sizeof(int);i++){
    pinMode(outputPins[i], OUTPUT);
  }

  for (int i=0;i<sizeof(inputPins) / sizeof(int);i++){
    pinMode(inputPins[i], INPUT);
  }
}

void loop() {
  //check the potentiometers
  Serial.print("joystick 1 X: ");
  Serial.print(analogRead(joy1Pins[0]));
  Serial.print(" Y: ");
  Serial.println(analogRead(joy1Pins[1]));
  Serial.print(" joystick 2 X: ");
  Serial.print(analogRead(joy2Pins[0]));
  Serial.print(" Y: ");
  Serial.println(analogRead(joy2Pins[1]));
  Serial.print(" potentiometer: ");
  Serial.println(analogRead(potentiometerPin));
  
  //check the grid
  for (int i=0;i<sizeof(outputPins) / sizeof(int);i++){
    //SET OUTPUT PIN STATUS
    if(i==0){
      digitalWrite(outputPins[sizeof(outputPins) / sizeof(int)-1], LOW);
    }
    else{
      digitalWrite(outputPins[i-1], LOW);
    }
    digitalWrite(outputPins[i], HIGH);

    //READ WHICH PINS ARE HIGH
    for (int n=0;n<sizeof(inputPins) / sizeof(int);n++){
      if(digitalRead(inputPins[n])==HIGH){
        Serial.print("output pin: ");
        Serial.print(outputPins[i]);
        Serial.print(" input pin: ");
        Serial.println(inputPins[n]);
      }
    }
    
    delay(1);
  }
}
