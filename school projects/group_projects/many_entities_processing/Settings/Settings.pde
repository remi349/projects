//Create settings window to toggle modes, reset simulation

Toggle toggle;

void settings() {
    size(200,300);
  }  
  
void setup() {
  background(255);
  colorMode(RGB);
  surface.setTitle("Settings");
  surface.setLocation(100,100);
  toggle = new Toggle( 10, 55, 90, 180, false, "ON", "OFF", 
  color(RGB, 110, 194, 106), color(RGB, 211, 211, 211));
} 

void draw() {
    toggle.run();
}

void mouseClicked() {
  if (toggle.clicked()){
    toggle.update();
  }
}
