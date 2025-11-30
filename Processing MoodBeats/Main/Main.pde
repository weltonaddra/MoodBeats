Comp_Visuals visuals;
Sensor sensor;
AudioSource currentAudioSource = AudioSource.COMPUTER_MIC;

void setup() {
  size(1250, 800);
  
  sensor = new Sensor(this);
  visuals = new Comp_Visuals(this, height, width);
  
  println("Setup complete.");
  println("Press 'm' to toggle between COMPUTER MIC and ARDUINO MIC.");
  println("Current audio source: " + currentAudioSource);
}

void draw() {
  // 1. Read the latest data from the Arduino
  sensor.update();
  
  // 2. Update the visuals with the current audio source and temperature
  visuals.update(currentAudioSource, sensor.getTemperature());
  
  // 3. Draw the visuals, passing in the mic level from the Arduino
  visuals.startVisuals(sensor.getMicLevel());
}

void keyReleased() {
  if (key == 'm' || key == 'M') {
    if (currentAudioSource == AudioSource.COMPUTER_MIC) {
      currentAudioSource = AudioSource.ARDUINO_MIC;
    } else {
      currentAudioSource = AudioSource.COMPUTER_MIC;
    }
    println("Audio source switched to: " + currentAudioSource);
  }
}
