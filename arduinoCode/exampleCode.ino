#include <Joystick.h>

const uint8_t buttonCount = 20;

Joystick_ controller(JOYSTICK_DEFAULT_REPORT_ID,JOYSTICK_TYPE_GAMEPAD,
  buttonCount, 0,                  // Button Count, Hat Switch Count
  true, true, false,      // X, Y, Z Axis
  true, true, false,      // Rx, Ry, Rz
  false, true,            // rudder, throttle
  false, false, false);   // accelerator, brake, steering

const int outputPins[3] = {2,3,4};
const int inputPins [6] = {5,6,7,8,9,16};
const int joy1Pins [3] = {A2,A3,14};
const int joy2Pins [3] = {A0,A1,15};
const int potentiometerPin = A10;

int lastButtonValue[buttonCount];
int lastXAxisValue = -1;
int lastYAxisValue = -1;
int lastRxAxisValue = -1;
int lastRyAxisValue = -1;
int lastThrottleValue = -1;

void setup()
{
  controller.setYAxisRange(1023, 0);
  controller.setXAxisRange(0, 1023);
  controller.setRxAxisRange(1023, 0);
  controller.setRyAxisRange(0, 1023);
  controller.setThrottleRange(0, 1023);
  controller.begin(false);

  pinMode(LED_BUILTIN, OUTPUT);
  digitalWrite(LED_BUILTIN, LOW);

  for (int i=0;i<sizeof(outputPins) / sizeof(int);i++){
    pinMode(outputPins[i], OUTPUT);
  }

  for (int i=0;i<sizeof(inputPins) / sizeof(int);i++){
    pinMode(inputPins[i], INPUT);
  }

  for (int i = 0; i < buttonCount; i++)
  {
    lastButtonValue[i] = -1;
  }
  
  //my 2 joystick buttons are wired differently. So according to the Joystick.h documentation i need to pull them up
  pinMode(joy1Pins[2], INPUT_PULLUP);
  pinMode(joy2Pins[2], INPUT_PULLUP);
}

void loop()
{
  bool sendUpdate = false;

  //check button grid
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
    int gridButtonValues[buttonCount];
    for (int n=0;n<sizeof(inputPins) / sizeof(int);n++){
      if(digitalRead(inputPins[n])==HIGH){
        gridButtonValues[i*6+n] = 1;
        controller.pressButton(i*6+n);
      }
      if(digitalRead(inputPins[n])==LOW){
        gridButtonValues[i*6+n] = 0;
        controller.releaseButton(i*6+n);
      }
      if(gridButtonValues[i*6+n] != lastButtonValue[i*6+n])
      {
        sendUpdate = true;
      }
    }
    delay(1);
  }

  //check joystick buttons
  const int buttonValue = digitalRead(joy1Pins[2]);
    if (buttonValue != lastButtonValue[buttonCount-1])
    {
      controller.setButton(buttonCount-1, !buttonValue);
      lastButtonValue[buttonCount-1] = buttonValue;
      sendUpdate = true;
    }
  const int buttonValue2 = digitalRead(joy2Pins[2]);
    if (buttonValue2 != lastButtonValue[buttonCount-2])
    {
      controller.setButton(buttonCount-2, !buttonValue2);
      lastButtonValue[buttonCount-2] = buttonValue2;
      sendUpdate = true;
    }

  //check joystick values
  const int currentXAxisValue = analogRead(joy1Pins[0]);
  if (currentXAxisValue != lastXAxisValue)
  {
    controller.setXAxis(currentXAxisValue);
    lastXAxisValue = currentXAxisValue;
    sendUpdate = true;
  }

  const int currentYAxisValue = analogRead(joy1Pins[1]);
  if (currentYAxisValue != lastYAxisValue)
  {
    controller.setYAxis(currentYAxisValue);
    lastYAxisValue = currentYAxisValue;
    sendUpdate = true;
  }

  const int currentRxAxisValue = analogRead(joy2Pins[0]);
  if (currentRxAxisValue != lastRxAxisValue)
  {
    controller.setRxAxis(currentRxAxisValue);
    lastRxAxisValue = currentRxAxisValue;
    sendUpdate = true;
  }

  const int currentRyAxisValue = analogRead(joy2Pins[1]);
  if (currentRyAxisValue != lastRyAxisValue)
  {
    controller.setRyAxis(currentRyAxisValue);
    lastRyAxisValue = currentRyAxisValue;
    sendUpdate = true;
  }

  const int currentThrottleValue = analogRead(potentiometerPin);
  if (currentThrottleValue != lastThrottleValue)
  {
    controller.setThrottle(currentThrottleValue);
    lastThrottleValue = currentThrottleValue;
    sendUpdate = true;
  }

  if (sendUpdate)
  {
    controller.sendState();
  }
  delay(50);
}
