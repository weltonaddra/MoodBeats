import ddf.minim.*;

class Comp_Visuals {
  Minim minim;
  AudioInput mic;

  float centerX, centerY;
  float mainX, mainY;
  float secondX, secondY;
  float thirdX, thirdY;

  float shapeSize = 20;
  float volume = 0;

  float randNoise1, randNoise2;

  color[] chosenPalette;
  color backgroundCol, flowerCol1, flowerCol2, barMiddle;

  int angle = 0;


  // CONSTRUCTOR
  Comp_Visuals(int h, int w) {

    minim = new Minim(this);
    mic = minim.getLineIn(Minim.MONO, 512);

    centerX = w / 2;
    centerY = h / 2;

    mainX = centerX ;
    mainY = centerY - 250;

    secondX = mainX + 200;
    secondY = mainY + 200;

    thirdX = mainX - 200;
    thirdY = mainY + 200;


    // Pick palette
    chosenPalette = pickColorPalette();
    backgroundCol = chosenPalette[0];
    flowerCol1 = chosenPalette[int(random(1, chosenPalette.length))];
    flowerCol2 = chosenPalette[int(random(1, chosenPalette.length))];
    barMiddle = chosenPalette[int(random(1, chosenPalette.length))];
  }

//How to start the visualizer
  void startVisuals() {
    background(backgroundCol);

// Volume + smoothing
    float micLevel = mic.mix.level() * 1000;
    volume = lerp(volume, micLevel, 0.15);

    // Size of visuals from audio
    shapeSize = map(volume, 0, 200, 20, 60);
    shapeSize = constrain(shapeSize, 20, 60);

    noStroke();

    // Draw flowers
    flowerEffect(flowerCol1, mainX, mainY);
    flowerEffect(flowerCol2, secondX, secondY);
    flowerEffect(flowerCol2, thirdX, thirdY);

    // Draw bars
    soundBars(chosenPalette, 1, mainX);

  }


  // Flowers
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


//Visualizer at the bottom of the visuals screen 
  void soundBars(color[] colors, int numOfBars, float xAxis) {
    int margin = 95;
    float barH = shapeSize * 11 - 15 * numOfBars;   // height scales with volume
    float barY = height - barH;          // moves rectangle upward as it grows
  
    fill(flowerCol1);
    
    float xcord = xAxis;
    
    if(numOfBars == 1){
       xcord = xAxis - 60;      
      rect(xcord, barY + 10, 90, barH + 100);    
  
    }  
     
     fill(flowerCol2);
    if(numOfBars < 20){
      rect(xcord + margin * numOfBars, barY, 90, barH + 500);    
      
      rect(xcord - margin * numOfBars, barY , 90, barH + 500);    
      soundBars(colors, numOfBars + 1, xcord);
    } 
}



  // COLOR PALETTE
  color[] pickColorPalette() {

    color[] hot1 = {
      #811331, #702963, #880808,
      #C04000, #A52A2A, #C41E3A, #F88379
    };

    color[] hot2 = {
      #F88379, #C41E3A, #880808,
      #FAA0A0, #A95C68, #A52A2A, #811331
    };

    color[] cool1 = {
      #89CFF0, #7393B3, #088F8F,
      #CCCCFF, #00A36C, #4682B4, #6082B6
    };

    color[] cool2 = {
      #6082B6, #CCCCFF, #088F8F,
      #5F9EA0, #7393B3, #89CFF0
    };

    color[][] allP = { hot1, hot2, cool1, cool2 };

    return allP[int(random(allP.length))];
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
}
