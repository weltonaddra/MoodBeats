import ddf.minim.*;

Minim minim;
AudioInput mic;

int angle = -15;

//Gets the center of the canvas 
float centerX =  height / 2;
float centerY = width / 2;

//These are use as a reference point for all the visuals
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
float lastVolume = 0; //Used to check if the volume jumps
    
Boolean volumeLoud = false;

String xcord;
String ycord;
String cord;
String empty;

float randNoise1 = int(random(0, 200));
float randNoise2 = int(random(0, 200));


// This variable holds whichever palette is chosen on startup
color[] chosenPalette = pickColorPallete();  //Randomly selects a color pallete 

color backgroundCol = chosenPalette[0];
color flowerCol1 = chosenPalette[int(random(1,chosenPalette.length))];
color flowerCol2 = chosenPalette[int(random(1,chosenPalette.length))];
color barMiddle = chosenPalette[int(random(1,chosenPalette.length))];


void setup() {
  size(800,800);
  //fullScreen();
  

  minim = new Minim(this);
  mic = minim.getLineIn(Minim.MONO, 512);
  
}

void draw() {
  background(backgroundCol); // background color 
  
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
    flowerEffect(flowerCol1, mainX, mainY);
    flowerEffect(flowerCol2, secondX, secondY);
    flowerEffect(flowerCol2, thirdX, thirdY);
    
//Rectangles 
    soundBars(chosenPalette, 1, mainX);
    
//Mouse postiions used for reference 
    xcord = Integer.toString(mouseX);
    ycord = Integer.toString(mouseY);
    empty = " , ";
    cord = xcord.concat(empty).concat(ycord);
    text(cord, mouseX - 15, mouseY - 10);
        
  }


void flowerEffect(color petalColor,float posX, float posY){
   angle += 0;

    float val = cos(radians(angle)) * shapeSize * 5;
    for (int a = 0; a < 360; a += 75) {
      float xoff = cos(radians(a)) * val;
      float yoff = sin(radians(a)) * val;
      
      fill(petalColor);
      ellipse(posX + xoff, posY + yoff, val, val);
    }
    
    fill(chosenPalette[5]);
    ellipse(posX, posY, 10, 10);  
}

void soundBars(color[] colors, int numOfBars, float xAxis){
  int margin = 95;
  float barH = shapeSize * 11 - 15 * numOfBars;   // height scales with volume
  float barY = height - barH;          // moves rectangle upward as it grows

  fill(flowerCol1);
  
  float xcord = xAxis;
  
  if(numOfBars == 1){
     xcord = xAxis - 60;      
    rect(xcord, barY + 10, 90, barH + 100);    

  }
   //fill(colors[int(random(colors.length))]);

   
   fill(flowerCol2);
  if(numOfBars < 20){
    rect(xcord + margin * numOfBars, barY, 90, barH + 500);    // grows upward from bottom
    
    rect(xcord - margin * numOfBars, barY , 90, barH + 500);    // grows upward from bottom
    soundBars(colors, numOfBars + 1, xcord);
  } 
}


void particles(color[] colors, float posX, float posY){
    int x = 0;

}

color[] pickColorPallete(){
  // Hot Temperature Colors - set 1
  color[] hotColors1 = {
    #811331,  // Claret
    #702963,  //Byzantium (Dark purple)
    #880808,  // Blood Red
    #C04000,  //Mahogany
    #A52A2A,  // Brown
    #C41E3A,  // Cardinal Red
    #F88379   // Coral Pink
  };
  
  // Hot Temperature Colors - set 2
  color[] hotColors2 = {
    #F88379,  // Coral Pink
    #C41E3A,  // Cardinal Red
    #880808,  // Blood Red
    #FAA0A0,  //Pastel Red  
    #A95C68,  //Puce (light purple)
    #A52A2A,  // Brown
    #811331   // Claret
  };
  
  // Cool Temperature Colors - Set 1
  color[] coolColors1 = {
    #89CFF0,  // Baby Blue
    #7393B3,  // Blue Gray
    #088F8F,  // Blue Green
    #CCCCFF,  // Periwinkle
    #00A36C,  // Jade
    #4682B4,  //Steel Blue 
    #6082B6   // Glaucous
  };
  
  // Cool Temperature Colors - Set 2 
  color[] coolColors2 = {
    #6082B6,  // Glaucous
    #CCCCFF,  // Periwinkle
    #088F8F,  // Blue Green
    #5F9EA0,  //Cadet Blue 
    #7393B3,  // Blue Gray
    #89CFF0   // Baby Blue
  };
  
  //Pick a random set of color
  color[][] allPalettes = { hotColors1, hotColors2, coolColors1, coolColors2 };
  //color[] pallete = allPalettes[int(random(allPalettes.length))];
  color[] pallete = hotColors2;
  return pallete;
  


}
