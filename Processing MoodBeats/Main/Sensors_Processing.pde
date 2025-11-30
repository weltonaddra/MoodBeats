import processing.serial.*;
import processing.core.PApplet;

class Sensor {
  private Serial myPort;

  private float temperature = 70.0;
  private String buttonState = "UP";
  private int micLevel = 0;

  Sensor(PApplet parent) {
    // --- IMPORTANT ---
    // Change Serial.list()[0] to the specific port your Arduino is on
    // if it's not the first one in the list.
    // You can print Serial.list() in setup() to see all available ports.
    String portName = Serial.list()[0];
    myPort = new Serial(parent, portName, 9600);
    myPort.bufferUntil('\n');
  }

  public void update() {
    String inData = myPort.readStringUntil('\n');

    if (inData != null) {
      inData = inData.trim();
      String[] matches = match(inData, "Temperature: (.*) --- Button: (.*) --- Mic: (.*)");

      if (matches != null && matches.length == 4) {
        // matches[0] is the full string, matches[1-3] are the captured groups
        try {
          temperature = float(matches[1]);
          buttonState = matches[2];
          micLevel = int(matches[3]);
        } catch (NumberFormatException e) {
          println("Error parsing sensor data: " + e.getMessage());
        }
      }
    }
  }

  public float getTemperature() {
    return temperature;
  }

  public String getButtonState() {
    return buttonState;
  }

  public int getMicLevel() {
    return micLevel;
  }
}
