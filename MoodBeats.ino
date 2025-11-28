#include "DHT.h"
#include "pitches.h"

//Temperature sensor
#define DHTPIN   7 // DHT11 signal pin
#define DHTTYPE DHT11
DHT dht(DHTPIN, DHTTYPE);

const int ledPin = 11;
const int micPin = A0;
const int speakerPin = 9;
const int buttonPin = 2;
const int threshold = 515;  //How loud the mic needs to be to turn on the LED

int buttonStates[] = {1,1,1}; //Holds the most recent 3 button states to check if it's being held 
int stateIndex = 0;
String buttonState = "NOT SET";



int notes[] = { 
    NOTE_C4, NOTE_G2, NOTE_G3, NOTE_A3, NOTE_G3, 0, NOTE_B3, NOTE_C4  //These are just numbers in the pitches.h file that are used for the different frequencies 
  };

// note durations: 4 = quarter note, 8 = eighth note, etc.:
int noteDurations[] = {
    4, 8, 8, 4, 4, 4, 4, 4
};



void setup() {
  Serial.begin(9600);
  delay(500); //delay to let system boot

  pinMode(ledPin, OUTPUT);
  pinMode(micPin, INPUT);
  pinMode(speakerPin, OUTPUT);
  pinMode(buttonPin, INPUT_PULLUP);
  dht.begin(); // Start the DHT sensor

}

void loop() {
  delay(1000);
  int buttonNum = digitalRead(buttonPin);
  setButtonState(buttonNum);

  float temp = dht.readTemperature();
  temp = (is_numeric(temp)) ? (temp * 1.8) + 32 : 000;  //If temp is a number it converts it to fahrenheit 

  int micVolume = analogRead(micPin);
  String allValues = "Temperature: "  +  String(temp) + "   --- Button: " +  String(buttonState) + "   --- Mic: " + String(micVolume);
  Serial.println(allValues);

  // if(buttonState == LOW){
  //   startMelody(notes, noteDurations);
  //   // delay(100);
  // } else {
  //   // Serial.println("Not pressed.");
  // }


  if (micVolume >= threshold) {
    digitalWrite(ledPin, HIGH);
    // Serial.println(micVolume);
    delay(100);
  } else {
    digitalWrite(ledPin, LOW);
  }
}

void setButtonState(int inputState){
    if(inputState == 1){ //Button not pressed
      buttonState = "UP";
      if(stateIndex > 0){
        int buttonStates[] = {1,1,1}; //Reset the holding streak 
        stateIndex = 0;
      }
    } 
    
    else if(inputState == 0){ //Button pressed 
      buttonState = "DOWN";
      if(stateIndex < 3){
        buttonStates[stateIndex] = 0;
        stateIndex += 1;
      } else if (inputState == 0 && stateIndex == 3){
          buttonState = "HOLD";
          startMelody(notes, noteDurations);
      }
    } else{
        buttonState = "BUTTON ERROR";

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

bool is_numeric(float x) {
  return !isnan(x);
}


