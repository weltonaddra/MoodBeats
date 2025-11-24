import ddf.minim.*;

Minim minim;
AudioInput mic;

int angle = -15;

float centerX =  height / 2;
float centerY = width / 2;

float mainX =  centerX + 350;
float mainY = centerY + 100;

//To the right of the main flower
float secondX = mainX  + 200;
float secondY = mainY  + 200;

//To the left of the main flower
float thirdX = mainX - 200;
float thirdY = mainY + 200;

float shapeSize = 20;
float volume = 0;
    
String xcord;
String ycord;
String cord;
String empty;

// This variable holds whichever palette is chosen on startup
color[] chosenPalette;

void setup() {
  size(800,800);
  //fullScreen();
  
  chosenPalette = pickColorPallete();  //Randomly selects a color pallete 
  minim = new Minim(this);
  mic = minim.getLineIn(Minim.MONO, 512);
  
  //fill(0,102);  
}

void draw() {
  background(chosenPalette[0]); // background color 
  
  //Getting the volume level 
  float micLevel = mic.mix.level() * 1000;
  println(micLevel);
  volume = lerp(volume, micLevel, 0.15);

//Converts the mic level to the factor we can use to scale for our shapes 
  shapeSize = map(volume, 0, 200, 20, 60);   
  shapeSize = constrain(shapeSize, 20, 60);
  
  fill(chosenPalette[3]);  
  noStroke();

//Create the flower shape
    flowerEffect(chosenPalette, mainX, mainY);
    flowerEffect(chosenPalette, secondX, secondY);
    flowerEffect(chosenPalette, thirdX, thirdY);
    
//Rectangles 
    soundBars(chosenPalette, 1, mainX);
    
//Mouse postiions used for reference 
    xcord = Integer.toString(mouseX);
    ycord = Integer.toString(mouseY);
    empty = " , ";
    cord = xcord.concat(empty).concat(ycord);
    text(cord, mouseX - 15, mouseY - 10);
    

}


void flowerEffect(color[] colors, float posX, float posY){
   angle += 0;

    float val = cos(radians(angle)) * shapeSize * 5;
    for (int a = 0; a < 360; a += 75) {
      float xoff = cos(radians(a)) * val;
      float yoff = sin(radians(a)) * val;
      
      fill(colors[3]);
      ellipse(posX + xoff, posY + yoff, val, val);
    }
    
    fill(colors[1]);
    ellipse(posX, posY, 10, 10);  
}

void soundBars(color[] colors, int numOfBars, float xcord){
  int margin = 120;
  float barH = shapeSize * 11 - 15 * numOfBars;   // height scales with volume
  float barY = height - barH;          // moves upward as it grows

  fill(colors[1]);
  
  if(numOfBars == 1){
    rect(mainX - 60, barY, 90, barH);    

  }
  if(numOfBars < 10){
    rect(mainX - 180, barY, 90, barH);    // grows upward from bottom
    rect(mainX - 60 + margin, barY, 90, barH);    // grows upward from bottom
    soundBars(colors, numOfBars + 1, xcord + 300);
  }
}


void particles(color[] colors, float posX, float posY){
    int x = 0;

}

color[] pickColorPallete(){
  // Hot Temperature Colors - set 1
  color[] hotColors1 = {
    #880808,  // Blood Red
    #A52A2A,  // Brown
    #C41E3A,  // Cardinal Red
    #811331,  // Claret
    #F88379   // Coral Pink
  };
  
  // Hot Temperature Colors - set 2
  color[] hotColors2 = {
    #F88379,   // Coral Pink
    #C41E3A,  // Cardinal Red
    #880808,  // Blood Red
    #A52A2A,  // Brown
    #811331  // Claret
  };
  
  // Cool Temperature Colors - Set 1
  color[] coolColors1 = {
    #89CFF0,  // Baby Blue
    #7393B3,  // Blue Gray
    #088F8F,  // Blue Green
    #CCCCFF,  // Periwinkle
    #6082B6   // Glaucous
  };
  
  // Cool Temperature Colors - Set 2 
  color[] coolColors2 = {
    #6082B6,  // Glaucous
    #CCCCFF,  // Periwinkle
    #088F8F,  // Blue Green
    #7393B3,  // Blue Gray
    #89CFF0   // Baby Blue
  };
  
  //Pick a random set of color
  color[][] allPalettes = { hotColors1, hotColors2, coolColors1, coolColors2 };
  //color[] pallete = allPalettes[int(random(allPalettes.length))];
  color[] pallete = coolColors1;
  return pallete;
  


}
