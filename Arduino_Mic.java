import processing.serial.*;

int angle = 0;

float centerX =  height / 2;
float centerY = width / 2;

float mainX =  centerX + 400;
float mainY = centerY + 300;

float secondX = mainX  + 200;
float secondY = mainY  + 200;

float thirdX = mainX - 200;
float thirdY = mainY - 100;

float shapeSize;

float volume;


Serial myPort; // Ports for reading the volume level 
    
color[] coolColors = {
  #89CFF0,  // Baby blue
  #7393B3,  // Blue gray
  #088F8F,  // Blue green
  #CCCCFF,  // Periwinkle
  #6082B6   // Glaucous
};

void setup() {
  size(900,950);
  //fullScreen();
  
  fill(0,102);
  myPort = new Serial(this, Serial.list()[0], 9600); //Computer port used to read volume values sent from arduinoIde
  
}

void draw() {
  background(coolColors[0]); // background color 
  
  //Getting the volume level 
    if (myPort.available() > 0) {
      String input = myPort.readStringUntil('\n');
      print(input);
      print(myPort.readString());
      
    if (input != null) {
      input = trim(input);
      if (input.length() > 0) {
        volume = float(input);
      }
    } //<>//
  }  
  shapeSize = map(volume, 490, 510, 20, 35);
  
  fill(coolColors[3]);
  //ellipse(400, 184, 220, 220);
  
  noStroke();

//Create the flower shape
    angle += 5;

    float val = cos(radians(angle)) * shapeSize;
    for (int a = 0; a < 360; a += 75) {
      float xoff = cos(radians(a)) * val;
      float yoff = sin(radians(a)) * val;
      
      fill(coolColors[3]);
      ellipse(mainX + xoff, mainY + yoff, val, val);
      ellipse(secondX + xoff, secondY + yoff, val, val);
      ellipse(thirdX + xoff, thirdY + yoff, val, val);
      
      //ellipse(mouseX + xoff, mouseY + yoff, val, val);
    }
    fill(coolColors[2]);
    ellipse(mainX, mainY, 2, 2);
    ellipse(secondX, secondY, 2, 2);
    ellipse(thirdX, thirdY, 2, 2);

  
}
