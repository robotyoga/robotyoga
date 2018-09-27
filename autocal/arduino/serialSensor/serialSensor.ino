int sensorPin = A0;    // select the input pin for the potentiometer
int sensorValue = 0;  // variable to store the value coming from the sensor

void setup() {
  Serial.begin(9600);
}

void loop() {
  int maxValue = 0; 
  for (int i = 0; i < 5; i++) {
    maxValue = max(analogRead(sensorPin), maxValue);
    delay(5);
  }
  
  Serial.print(maxValue);
  Serial.print("\n");
}
