// #include "DHT.h"

// // --- Change this to your pin ---
// #define DHTPIN   7 // DHT11 signal pin
// #define DHTTYPE DHT11

// DHT dht(DHTPIN, DHTTYPE);

// void setup(){
//     Serial.begin(9600);
//     delay(500); //delay to let system boot
//     Serial.println("DHT11 Humidity & temperature sensor\n\n");
//     delay(1000); // wait before accessing sensor
// }
// void loop(){
//     int temp = dht.readTemperature();
//     Serial.println(temp);

//     delay(5000); // wait 5 seconds before accessing sensor again
// }

#include "pitches.h"

const int ledPin = 11;
const int micPin = A0;
const int speakerPin = 9;
const int buttonPin = 2;
const int threshold = 515;

int notes[] = { 
    NOTE_C4, NOTE_G2, NOTE_G3, NOTE_A3, NOTE_G3, 0, NOTE_B3, NOTE_C4  //These are just numbers in the pitches.h file that are used for the different frequencies 
  };

// note durations: 4 = quarter note, 8 = eighth note, etc.:
int noteDurations[] = {
    4, 8, 8, 4, 4, 4, 4, 4
};



void setup() {
  Serial.begin(9600);
  pinMode(ledPin, OUTPUT);
  pinMode(micPin, INPUT);
  pinMode(speakerPin, OUTPUT);
  pinMode(buttonPin, INPUT_PULLUP);

}

void loop() {
  int buttonState = digitalRead(buttonPin);

  if(buttonState == LOW){
    startMelody(notes, noteDurations);
    delay(2000);
  } else {
    Serial.println("Not pressed.");
  }

  int soundsens = analogRead(micPin);

  if (soundsens >= threshold) {
    // digitalWrite(ledPin, HIGH);
    Serial.println(soundsens);
    delay(500);
  } else {
    digitalWrite(ledPin, LOW);
  }
}

void startMelody(int inputNotes[], int inputDurations[]){
    // iterate over the notes of the melody:

    for (int noteIndex = 0; noteIndex < 8; noteIndex++) {

      // to calculate the note duration, take one second divided by the note type.

      //e.g. quarter note = 1000 / 4, eighth note = 1000/8, etc.

      int noteDuration = 1000 / inputDurations[noteIndex];

      tone(9, inputNotes[noteIndex], noteIndex);

      // to distinguish the notes, set a minimum time between them.

      // the note's duration + 30% seems to work well:

      int pauseBetweenNotes = noteDuration * 1.30;

      delay(pauseBetweenNotes);

      // stop the tone playing:

      noTone(8);
  }
}
