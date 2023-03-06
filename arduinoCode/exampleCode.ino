const int outputPins[3] = {2,3,4};
const int inputPins [6] = {5,6,7,8,9,10};

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
