import ddf.minim.*;

enum AudioSource {
  COMPUTER_MIC,
  ARDUINO_MIC
}

class Comp_Visuals {
  Minim minim;
  AudioInput computerMic;
  AudioSource audioSource = AudioSource.COMPUTER_MIC;

  float centerX, centerY;
  float mainX, mainY, secondX, secondY, thirdX, thirdY, fourthX, fourthY, fifthX, fifthY;

  float shapeSize = 20;
  float volume = 0;
  int angle = 0;

  color[] currentPalette;
  color backgroundCol, flowerCol1, flowerCol2, flowerCol3, barMiddleCol;

  color[] hotColors1 = {
    #811331,  // Claret
    #702963,  // Byzantium
    #880808,  // Blood Red
    #C04000,  // Mahogany
    #A52A2A,  // Brown
    #C41E3A,  // Cardinal Red
    #F88379   // Coral Pink
  };
  color[] hotColors2 = {
    #F88379,  // Coral Pink
    #C41E3A,  // Cardinal Red
    #880808,  // Blood Red
    #FAA0A0,  // Pastel Red
    #A95C68,  // Puce
    #A52A2A,  // Brown
    #811331   // Claret
  };
  color[] coolColors1 = {
    #89CFF0,  // Baby Blue
    #7393B3,  // Blue Gray
    #088F8F,  // Blue Green
    #CCCCFF,  // Periwinkle
    #00A36C,  // Jade
    #4682B4,  // Steel Blue
    #6082B6   // Glaucous
  };
  color[] coolColors2 = {
    #6082B6,  // Glaucous
    #CCCCFF,  // Periwinkle
    #088F8F,  // Blue Green
    #5F9EA0,  // Cadet Blue
    #7393B3,  // Blue Gray
    #89CFF0   // Baby Blue
  };

  color[][] hotPalettes = { hotColors1, hotColors2 };
  color[][] coolPalettes = { coolColors1, coolColors2 };


  Comp_Visuals(PApplet parent, int h, int w) {
    minim = new Minim(parent);
    computerMic = minim.getLineIn(Minim.MONO, 512);

    centerX = w / 2;
    centerY = h / 2;
    mainX = centerX;
    mainY = centerY - 250;
    secondX = mainX + 200;
    secondY = mainY + 200;
    thirdX = mainX - 200;
    thirdY = mainY + 200;
    fourthX = mainX + 440;
    fourthY = mainY - 10;
    fifthX = mainX - 440;
    fifthY = mainY - 10;

    setPaletteByTemperature(70.0);
  }

  public void update(AudioSource newAudioSource, float temperature) {
    this.audioSource = newAudioSource;
    setPaletteByTemperature(temperature);
  }

  public void startVisuals(int arduinoMicLevel) {
    background(0,0,0);

    // Step 1: Determine the audio level based on the current source
    float currentMicLevel = 0;
    if (audioSource == AudioSource.COMPUTER_MIC) {
      currentMicLevel = computerMic.mix.level() * 1000;
    } else { // ARDUINO_MIC
      currentMicLevel = map(arduinoMicLevel, 0, 1023, 0, 1000);
    }

    // Step 2: Smooth the volume
    volume = lerp(volume, currentMicLevel, 0.15);

    // Step 3: Map volume to the size of the visual elements
    shapeSize = map(volume, 0, 400, 20, 100);
    shapeSize = constrain(shapeSize, 20, 100);

    // Step 4: Draw the visual elements
    noStroke();
    flowerEffect(flowerCol1, mainX, mainY);
    flowerEffect(flowerCol2, secondX, secondY);
    flowerEffect(flowerCol2, thirdX, thirdY);
    flowerEffect(flowerCol3, fourthX, fourthY);
    flowerEffect(flowerCol3, fifthX, fifthY);
    soundBars(currentPalette, 1, mainX);
  }

  private void setPaletteByTemperature(float temp) {
    float tempThreshold = 75.0; // F
    color[][] targetPalettes;

    if (temp > tempThreshold) {
      targetPalettes = hotPalettes;
    } else {
      targetPalettes = coolPalettes;
    }

    boolean needsUpdate = true;
    for (color[] p : targetPalettes) {
      if (p == currentPalette) {
        needsUpdate = false;
        break;
      }
    }

    if (needsUpdate) {
      currentPalette = targetPalettes[int(random(targetPalettes.length))];
      assignPaletteColors();
    }
  }

  private void assignPaletteColors() {
    backgroundCol = currentPalette[0];
    flowerCol1 = currentPalette[int(random(1, currentPalette.length))];
    flowerCol2 = currentPalette[int(random(1, currentPalette.length))];
    flowerCol3 = currentPalette[int(random(1, currentPalette.length))];
    barMiddleCol = currentPalette[int(random(1, currentPalette.length))];
  }

  void flowerEffect(color petalColor, float posX, float posY) {
    angle += 0;
    float val = cos(radians(angle)) * shapeSize * 5;
    for (int a = 0; a < 360; a += 75) {
      float xoff = cos(radians(a)) * val;
      float yoff = sin(radians(a)) * val;
      fill(petalColor);
      ellipse(posX + xoff, posY + yoff, val, val);
    }
    fill(currentPalette[5]);
    ellipse(posX, posY, 10, 10);
  }

  void soundBars(color[] colors, int numOfBars, float xAxis) {
    int margin = 95;
    float barH = shapeSize * 11 - 15 * numOfBars;
    float barY = height - barH;

    fill(barMiddleCol);
    float xcord = xAxis;

    if (numOfBars == 1) {
      xcord = xAxis - 60;
      rect(xcord, barY + 10, 90, barH + 100);
    }

    fill(flowerCol2);
    if (numOfBars < 20) {
      rect(xcord + margin * numOfBars, barY, 90, barH + 500);
      rect(xcord - margin * numOfBars, barY, 90, barH + 500);
      soundBars(colors, numOfBars + 1, xcord);
    }
  }
}
