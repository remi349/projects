/**
* Final Application Project, June 2022
* Télécom Paris
* Authors : Delhio Calves, Matthieu Carreau, Rémi Ducottet, Paul Triana
*
* Toggle class: is used in the interactive graphic interface to change between Boid and Obstacle modes,
* and allows to show prediction and plot the trajectory graphs
*/

class Toggle {
  
  PApplet app;
  float h; //height
  float w; //width
  PVector pos; //top left corner position
  boolean on;  //toggle state
  float animationTime; //number of frames for slide animation
  boolean animationLoop = false; //when animation is activated
  float animationStart = 0; //frame when animation starts
  String onText; //text when toggled on
  //Keep text short ( < 10 character) or modify render to fit text
  String offText; //text when toggled off
  color onColor; //color when toggled on
  color offColor; //color when toggled off
  String title;
  
  Toggle (PApplet app, String title, float x, float y, float h, float w, boolean on, String onText, String offText, 
  color onColor, color offColor) {
    this.title = title;
    this.app = app;
    pos = new PVector(x,y);
    this.h = h;
    this.w = w;
    this.on = on;
    this.onText = onText;
    this.offText = offText;
    this.onColor = onColor;
    this.offColor = offColor;
    animationTime = floor(0.5*app.frameRate);
  }
  
  void run() {
    render();
  }
  
  //Call update when switch is activated/deactivated
  void update() { 
    on = !on;
    animationLoop = true;
    animationStart = app.frameCount;
  }
  
  void render() {
    if ((animationLoop) && (app.frameCount < animationStart + animationTime)){
      float t = (app.frameCount - animationStart)/animationTime;
      drawAnimation(t);
    } else {
      animationLoop = false;
      drawStill();
    }
  }
  
  
  //Donne les paramètres d'affichage pour pouvoir avoir une animation de transition entre l'état ON et OFF
  void drawAnimation(float t) {
    app.noStroke();
    color interColor;
    if (on) {
      interColor = interColor(offColor, onColor, t);
      app.fill(interColor);
      app.rect(pos.x, pos.y, w, h, h/2);
      PVector center = new PVector(pos.x + h/2 + t*(w - h), pos.y + h/2);
      app.fill(255,255,255);
      app.circle(center.x, center.y, 0.95*h);
      if (t<0.5) {
        app.fill(interColor(app.color(0,0,0), app.color(255,255,255), 2*t));
        app.textSize(h/3);
        app.textAlign(CENTER,CENTER);
        app.text(offText, center.x, center.y  - h/15);
      } else {
        app.fill(interColor(app.color(255,255,255), app.color(0,0,0), 2*(t-0.5)));
        app.textSize(h/3);
        app.textAlign(CENTER,CENTER);
        app.text(onText, center.x, center.y  - h/15);
      }
    } else {
      interColor = interColor(onColor, offColor, t);
      app.fill(interColor);
      app.rect(pos.x, pos.y, w, h, h/2);
      PVector center = new PVector(t*(pos.x + h/2) + (1-t)*(pos.x+w - h/2), pos.y + h/2);
      app.fill(255,255,255);
      app.circle(center.x, center.y,  0.95*h);
      if (t<0.5) {
        app.fill(interColor(app.color(0,0,0), app.color(255,255,255), 2*t));
        app.textSize(h/3);
        app.textAlign(CENTER,CENTER);
        app.text(onText, center.x, center.y  - h/15);
      } else {
        app.fill(interColor(app.color(255,255,255), app.color(0,0,0), 2*(t-0.5)));
        app.textSize(h/3);
        app.textAlign(CENTER,CENTER);
        app.text(offText, center.x, center.y  - h/15);
      }
    }
  }
  
  //Affichage dans la cas sans animation, statique
  void drawStill() {
    app.noStroke();
    if (on) {
      app.fill(onColor);
      app.rect(pos.x, pos.y, w, h, h/2);
      PVector center = new PVector(pos.x + w - h/2, pos.y + h/2);
      app.fill(255,255,255);
      app.circle(center.x, center.y, 0.95*h);
      app.fill(0);
      app.textSize(h/3);
      app.textAlign(CENTER,CENTER);
      app.text(onText, center.x, center.y  - h/15); //correcting position because textAlign incorrectly aligns vertically
    } else {
      app.fill(offColor);
      app.rect(pos.x, pos.y, w, h,h/2);
      PVector center = new PVector(pos.x + h/2, pos.y + h/2);
      app.fill(255,255,255);
      app.circle(center.x, center.y,  0.95*h);
      app.fill(0);
      app.textSize(h/3);
      app.textAlign(CENTER,CENTER);
      app.text(offText, center.x, center.y - h/15);
    }
  }
  
  //Détermine les couleurs entre les deux couleurs correspondantes à ON et OFF, utile pour l'animation de transition
  color interColor (color a, color b, float t) {
    //app.colorMode(RGB);
    /*println("color 1 :");
    print(red(a));
    print(green(a));
    println(blue(a));
    println("color 2 :");
    print(red(b));
    print(green(b));
    println(blue(b));*/
    int newRed = floor((1-t)*app.red(a)+t*app.red(b));
    int newGreen = floor((1-t)*app.green(a)+t*app.green(b));
    int newBlue = floor((1-t)*app.blue(a)+t*app.blue(b));
    color c = app.color(newRed, newGreen, newBlue);
    /*println("color 3 :");
    print(newRed);
    print(newGreen);
    println(newBlue);*/
    return c;
  }
  
  //Fonction qui change l'état et déclenche l'animation si on active le Toggle
  boolean clicked() {
    return (app.mouseX>pos.x) && (app.mouseX<pos.x + w) 
    && (app.mouseY>pos.y) && (app.mouseY<pos.y + h);
  }
  
}
