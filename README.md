# MoodBeats 🎶🎵🎼🔊
Mood beats is an audio/music visionlizer that contains multiple different music related options (detailed bellow) that can be enabled based on what the user wants to do. 
We combine software with hardware, using an Arduino uno along with many sensors, and the applications "Processing" and "Arduino Ide". 

Our goal was to fit as many options into this project to fit different needs, while keeping it fun and interactive. 

## Current options:
1. Computer Mic Mode: Uses the Minim library to read live audio from the laptop microphone.
2. Arduino Mic Mode: The Arduino sends live sound level numbers through USB port, and processing reads those in real time to animate the visuals.
3. Randomized colors with themes for hot and cool temperatures (Ready)
4. Connecting temperature sensor to change the visualizer color pallete (almost ready)
5. Outputing audio from an Arduino speaker sensor (In progress)
6. Changing songs based on temperature or user interaction (In progress)


--- 

# Running the program 
The steps may differ depending on what materials you have and how complicated you want the setup to be. 

## Simple Set up (Computer + Processing)
1. Download processing - https://processing.org/download
2. Download "Computer_mic" file from this github - https://github.com/weltonaddra/MoodBeats/blob/main/Computer_Mic.java#L58
3. Run the file in processing.
4. Test the visualizer

## Full Set up 

#### Needs
**Software** 
- Processing
- Arduino ide

**Hardware**
- Arduino Uno or similar
- Breadboard
- Jumping wires
- Dht11 Temperature sensor
- Big Sound Arduino mic sensor
- Arduino Speaker
- Arduino Button 

**Steps**
1. Download processing
2. Download Arduino ide
3. Download the "Arduino_Mic" file - https://github.com/weltonaddra/MoodBeats/blob/main/Arduino_Mic.java
4. Download the "SoundToLed" file - https://github.com/weltonaddra/MoodBeats/blob/main/SoundToLed.ino
5. Set up you breadboard depending on what sensors you're using. Our set up will be linked here --> 
4.( **Important** ) Run the SoundToLed file in the Arduino ide before running the Arduino mic file in processing.
  Make sure to close the serial monitor window in Arduino ide or it will cause an error in the next step.


