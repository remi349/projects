
float p = min(15,100); // population as percentage of area

Organism organism;
color bc = color(255,255,255);
color oc = color(0,0,0);

void setup() {
  size(900, 900);
  int numSlime = int(p*0.01*width*height);
  organism = new Organism();
  for (int i = 0; i < numSlime; i++) {
    organism.addSlime(new Slime(random(width),random(height), random(TWO_PI)));
  }
  loadPixels();
  for (int j = 0; j< width*height; j++) {
    pixels[j] = colorVar(organism.trail.get(j));
  }
  updatePixels();
}

void draw() {
  organism.run();
  loadPixels();
  for (int j = 0; j< width*height; j++) {
     pixels[j] = colorVar(organism.trail.get(j));
  }
  updatePixels();
}

color colorVar(float p) {
  return color(floor(255 - 255*p),floor(255 - 255*p),floor(255 - 255*p));
}
