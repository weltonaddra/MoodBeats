import ddf.minim.*;

Comp_Visuals visuals;

void setup() {
  size(800, 800);

  // Create visuals object
  visuals = new Comp_Visuals(height, width);
}

void draw() {
  visuals.startVisuals();
}
