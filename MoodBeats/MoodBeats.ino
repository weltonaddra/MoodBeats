#include "DHT.h"
#include "pitches.h"

/*
Welcome to MoodBeats!! 
An interactive physical and digital activity. Before running the code, 
make sure to download the proper Arduino libraries:  Bonezegi DHT11, and adafruit unified sensor .
Then set up the proper wirring on your Arduino and breadboard.
*/



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
int stateIndex = 0;    //Checks how long the button is being held
String buttonState = "NOT SET";

float temp = 000;
String allValues = "";

int micVolume = 00;

void setup() {
  Serial.begin(9600);
  delay(500); //delay to let system boot

  pinMode(ledPin, OUTPUT);
  pinMode(micPin, INPUT);
  pinMode(speakerPin, OUTPUT);
  pinMode(buttonPin, INPUT_PULLUP);
  DHT dht(DHTPIN, DHTTYPE);

  dht.begin(); // Start the temperature sensor

}

void loop() {
  delay(2000);

  ReadButton();
  ReadTemperature();
  ReadMic();

 allValues = "Temperature: "  +  String(temp) + "   --- Button: " +  String(buttonState) + "   --- Mic: " + String(micVolume);
  Serial.println(allValues);
}

void ReadAllSensors(){
  ReadButton();
  ReadTemperature();
  ReadMic();
}

void ReadMic(){
  int rawMicVolume = analogRead(micPin);
  //Mic's output goes down with sound, so we "flip" the reading.
  micVolume = 1023 - rawMicVolume;

  String allValues = "Temperature: "  +  String(temp) + "   --- Button: " +  String(buttonState) + "   --- Mic: " + String(micVolume);
  if (micVolume >= threshold) {
    digitalWrite(ledPin, HIGH);
    delay(100);
  } else {
    digitalWrite(ledPin, LOW);
  }
}

void ReadButton(){
  int buttonNum = digitalRead(buttonPin);
    if(buttonNum == 1){     //Button released
      buttonState = "UP";
      if(stateIndex > 0){
        int buttonStates[] = {1,1,1}; //Reset the holding streak 
        stateIndex = 0;
      }
    } 
    
    else if(buttonNum == 0){      //Button pressed 
      buttonState = "DOWN";

      if(stateIndex < 3){
        buttonStates[stateIndex] = 0;
        stateIndex += 1;
      } else if (buttonNum == 0 && stateIndex == 3){
          buttonState = "HOLD";
          startMelody(marioNotes, marioDurations, marioSize);
        }
    } else{
        buttonState = "BUTTON ERROR";

    } 
}

void ReadTemperature(){
  temp = dht.readTemperature();
  temp = (is_numeric(temp)) ? (temp * 1.8) + 32 : 000;  //If temp is a number it converts it to fahrenheit 
}

void startMelody(int inputNotes[], int inputDurations[], int size){
    // iterate over the notes of the melody:

    for (int noteIndex = 0; noteIndex < size; noteIndex++) {

      // to calculate the note duration, take one second divided by the note type.

        int noteDuration = 1000 / inputDurations[noteIndex];

        tone(speakerPin, inputNotes[noteIndex], noteDuration);

        // to distinguish the notes, set a minimum time between them.
        int pauseBetweenNotes = noteDuration * 1.30;

        delay(pauseBetweenNotes);

      noTone(speakerPin);
      
      if(noteIndex >= 7){
        ReadAllSensors();
        if(buttonState == "HOLD"){
          return;
        }
      }   

  }
}


bool is_numeric(float x) {
  return !isnan(x);
}


