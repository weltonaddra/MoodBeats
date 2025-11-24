int soundPin = A0;   // Big Sound Sensor OUT pin
int ledPin = 9;      // LED pin 

void setup() {
  pinMode(ledPin, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  int audioLevel = analogRead(soundPin);

  // Print the sound value so you can adjust the threshold later
  Serial.println(audioLevel);

  // Basic threshold test (you can tune this)
  if (audioLevel > 491) {
    digitalWrite(ledPin, HIGH);  // LED ON
  } else {
    digitalWrite(ledPin, LOW);   // LED OFF
  }

  delay(300);
}
