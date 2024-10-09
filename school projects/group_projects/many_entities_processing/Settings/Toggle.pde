class Toggle {
  
  float h; //height
  float w; //width
  PVector pos; //top left corner position
  boolean on;  //toggle state
  float animationTime = floor(0.5*frameRate); //number of frames for slide animation
  boolean animationLoop = false; //when animation is activated
  float animationStart = 0; //frame when animation starts
  String onText; //text when toggled on
  //Keep text short ( < 10 character) or modify render to fit text
  String offText; //text when toggled off
  color onColor; //color when toggled on
  color offColor; //color when toggled off
  
  Toggle (float x, float y, float h, float w, boolean on, String onText, String offText, 
  color onColor, color offColor) {
    pos = new PVector(x,y);
    this.h = h;
    this.w = w;
    this.on = on;
    this.onText = onText;
    this.offText = offText;
    this.onColor = onColor;
    this.offColor = offColor;
  }
  
  void run() {
    render();
  }
  
  //Call update when switch is activated/deactivated
  void update() { 
    on = !on;
    animationLoop = true;
    animationStart = frameCount;
  }
  
  void render() {
    if ((animationLoop) && (frameCount < animationStart + animationTime)){
      float t = (frameCount - animationStart)/animationTime;
      drawAnimation(t);
    } else {
      animationLoop = false;
      drawStill();
    }
  }
  
  void drawAnimation(float t) {
    noStroke();
    color interColor;
    if (on) {
      interColor = interColor(offColor, onColor, t);
      fill(interColor);
      rect(pos.x, pos.y, w, h, h);
      PVector center = new PVector(pos.x + h/2 + t*(w - h), pos.y + h/2);
      fill(255,255,255);
      circle(center.x, center.y, 0.95*h);
      if (t<0.5) {
        fill(interColor(color(0,0,0), color(255,255,255), 2*t));
        textSize(h/3);
        textAlign(CENTER,CENTER);
        text(offText, center.x, center.y  - h/15);
      } else {
        fill(interColor(color(255,255,255), color(0,0,0), 2*(t-0.5)));
        textSize(h/3);
        textAlign(CENTER,CENTER);
        text(onText, center.x, center.y  - h/15);
      }
    } else {
      interColor = interColor(onColor, offColor, t);
      fill(interColor);
      rect(pos.x, pos.y, w, h, h/2);
      PVector center = new PVector(t*(pos.x + h/2) + (1-t)*(pos.x+w - h/2), pos.y + h/2);
      fill(255,255,255);
      circle(center.x, center.y,  0.95*h);
      if (t<0.5) {
        fill(interColor(color(0,0,0), color(255,255,255), 2*t));
        textSize(h/3);
        textAlign(CENTER,CENTER);
        text(onText, center.x, center.y  - h/15);
      } else {
        fill(interColor(color(255,255,255), color(0,0,0), 2*(t-0.5)));
        textSize(h/3);
        textAlign(CENTER,CENTER);
        text(offText, center.x, center.y  - h/15);
      }
    }
  }
  
  void drawStill() {
    noStroke();
    if (on) {
      fill(onColor);
      rect(pos.x, pos.y, w, h, h);
      PVector center = new PVector(pos.x + w - h/2, pos.y + h/2);
      fill(255,255,255);
      circle(center.x, center.y, 0.95*h);
      fill(0);
      textSize(h/3);
      textAlign(CENTER,CENTER);
      text(onText, center.x, center.y  - h/15); //correcting position because textAlign incorrectly aligns vertically
    } else {
      fill(offColor);
      rect(pos.x, pos.y, w, h,h);
      PVector center = new PVector(pos.x + h/2, pos.y + h/2);
      fill(255,255,255);
      circle(center.x, center.y,  0.95*h);
      fill(0);
      textSize(h/3);
      textAlign(CENTER,CENTER);
      text(offText, center.x, center.y - h/15);
    }
  }
  
  color interColor (color a, color b, float t) {
    int newRed = floor((1-t)*red(a)+t*red(b));
    int newGreen = floor((1-t)*green(a)+t*green(b));
    int newBlue = floor((1-t)*blue(a)+t*blue(b));
    return color(newRed, newGreen, newBlue);
  }
  
  boolean clicked() {
    return (mouseX>pos.x) && (mouseX<pos.x + w) 
    && (mouseY>pos.y) && (mouseY<pos.y + h);
  }
  
}
