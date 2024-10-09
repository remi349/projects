/**
* Final Application Project, June 2022
* Télécom Paris
*
* Flocking 
* by Daniel Shiffman and enhanced by Delhio Calves, Matthieu Carreau, Rémi Ducottet, Paul Triana
*
* An implementation of Craig Reynold's Boids program to simulate
* the flocking behavior of birds. Each boid steers itself based on 
* rules of avoidance, alignment, and coherence.
* 
* Click the mouse to add a new boid.
**/

Flock flock;
Obstacles obstacles;
Grid gr;
boolean locked = false;
float radius = 20;
float posx;
float posy;
float bx;
float by;
float xOffset = 0.0; 
float yOffset = 0.0; 
float facteur = 5;
float delta;

String date;

float lastFrame;


int s;

ChildApplet child;//settings Applet
ChildApplet2 child2 = null;//Applet of the graph


boolean regression;
final int initWidth = 800;
final int initHeight = 800;
final int xScale = 1;
final int yScale = 1;

void settings() {
  size(initWidth*xScale,initHeight*yScale);
  //pixelDensity(5);
}

void setup() {
  colorMode(HSB,100);
  background(0,0,0);
  //surface.setResizable(true);
  surface.setLocation(300,100);
  surface.setTitle("Boid Simulation PAF 2022");
  //frameRate(1);
  lastFrame = frameCount;
  bx = width/2.0;
  by = height/2.0;
  flock = new Flock();
  gr = flock.grid;
  obstacles = new Obstacles();
  
  obstacles.addObstacle(new Wall(0,0,width,0,false,gr));
  obstacles.addObstacle(new Wall(0,0,0,height,false,gr));
  obstacles.addObstacle(new Wall(0,height,width,height,false,gr));
  obstacles.addObstacle(new Wall(width,0,width,height,false,gr));
  child = new ChildApplet(this);
  child2 = new ChildApplet2(this);
  s = second();    
  date = day() + "_" + month() + "_" + hour() + "_" + minute() + "_" + second();
}


void draw() {
  background(0);
  if ((locked) &&!child.create.on) {
    stroke(0,255,0);
    tint(255,50);
    circle(posx, posy, radius);
  }
  if (child.graphe.on) {
    flock.graphing();
  }
  try {
    flock.run(obstacles.obstacles);
  } catch (Exception e){
    println(e);
  }
  obstacles.run();
  if (frameCount-lastFrame>100) {
    lastFrame = frameCount;
  }
  if(frameCount%10==0) {
    flock.colourByGroup();
  }


}

//draws a Paf sign, we used it for the poster
void draw_PAF() {
  Grid gr = flock.grid;
  
  //Draw a P
  obstacles.addObstacle(new Wall(200,250,200,550,true, gr));
  int N = 30;
  float r = 75;
  float x_center = 200;
  float y_center = 325;
  float angle;
  for (int i=0; i<N; i++) {
    angle = (float)i/N*PI-PI/2;
    obstacles.addObstacle(new Wall( x_center+cos(angle)*r,
                                    y_center+sin(angle)*r,
                                    x_center+cos(angle+PI/N)*r,
                                    y_center+sin(angle+PI/N)*r,
                                    true,gr));
  }
  
  //Draw a A
  obstacles.addObstacle(new Wall(400,250,320,550,true,gr));
  obstacles.addObstacle(new Wall(400,250,480,550,true,gr));
  obstacles.addObstacle(new Wall(360,400,440,400,true,gr));
  
  //Draw an F
  obstacles.addObstacle(new Wall(540,250,540,550,true,gr));
  obstacles.addObstacle(new Wall(540,250,620,250,true,gr));
  obstacles.addObstacle(new Wall(540,380,600,380,true,gr));
  

}

// Add a new boid into the System
void mousePressed() {
  locked = true;
  float mX = mouseX;
  float mY = mouseY;
 
  posx = mX*xScale;
  posy = mY*yScale;
  xOffset = mX*xScale;
  yOffset = mY*yScale;
  stroke(0,255,0);
  tint(255,50);
}

void mouseDragged() {
  if (child.create.on) {
    stroke(0,255,0);
    tint(255,50);
    float mX = mouseX;
    float mY = mouseY;
    obstacles.addObstacle(new Wall(xOffset, yOffset, mX*xScale, mY*yScale, flock.grid));
    xOffset = mX*xScale;
    yOffset = mY*yScale;
  } else if (locked) {
    float mX = mouseX;
    float mY = mouseY;
    delta = (mX*xScale - xOffset) + (mY*yScale - yOffset);
    xOffset = mX*xScale;
    yOffset = mY*yScale;
    radius+=delta/facteur;
    stroke(0,255,0);
    tint(255,50); 
  }
}

void mouseReleased() {
  locked = false; 
  PVector dir = new PVector(mouseX*xScale-posx, mouseY*yScale-posy);
  float angle = dir.heading();
  if (!child.create.on){ 
    flock.addCluster(floor(dir.mag()/5), posx, posy, floor(sqrt(dir.mag())), angle);
  }
  radius = 20;
  posx = 0;
  posy = 0;
}

class ChildApplet extends PApplet {
  Toggle regression;
  Toggle create;
  Toggle courbe;
  Toggle graphe;
  PApplet parent;
  float r = 0;

  public ChildApplet(PApplet parent) {
    super();
    this.parent = parent;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }
  
  public void settings() {
    size(200,parent.height/yScale);
  }  
  
  public void setup() {
    background(230);
    this.colorMode(RGB);
    surface.setTitle("Settings");
    surface.setLocation(100,100);
    regression = new Toggle(this, "Regression", 10, 55, 90, 180, false, "ON", "OFF", 
    color(110, 194, 106), color(211, 211, 211));
    create = new Toggle(this, "Create", 10, 200, 90, 180, false, "OBS.", "BOID", 
    color(250, 0, 0), color(0, 0, 255));
    courbe = new Toggle(this, "Courbe",10, 395,90,180,false,"ON","OFF",
    color(128, 0, 128), color(211, 211, 211));
    graphe = new Toggle(this, "Graphe", 10, 540, 90, 180, false, "ON", "OFF", 
    color(110, 194, 106), color(211, 211, 211));
  }
  
  public void draw() {
    background(255);
    this.colorMode(RGB);
    //delay(10);
    
    this.noStroke();
    this.fill(255,255,255);
    this.rect(5,0,this.width,40);
    this.fill(0,0,0);
    this.textAlign(LEFT,TOP);
    this.textSize(30);
    this.text("Regression :", 5,5,10);
    this.noStroke();
    this.fill(255,255,255);
    this.rect(5,145,this.width,40);
    this.fill(0,0,0);
    this.textAlign(LEFT,TOP);
    this.textSize(30);
    this.text("Create :", 5,150,10); 
    this.text("Courbe :",5,345,10);
    this.text("Graphe :",5,490,10);

    if ((r>0) && regression.on) {
      showR();
    }
    regression.run();
    create.run();
    courbe.run();
    graphe.run();
  }
  
  void showR() {
    this.fill(255,0,0);
    this.textAlign(LEFT,TOP);
    this.textSize(22);
    this.text("R^2 = "+r,5,300);
  }
  
  public void mouseClicked() {
    if (regression.clicked()){
      regression.update();
    }
    if (create.clicked()){
      create.update();
    }
    if (courbe.clicked()){
      courbe.update();
    }
    if (graphe.clicked()){
      graphe.update();
    }
  }

}


//class that creates a new window that traces graph, using grafica
class ChildApplet2 extends PApplet {
  ArrayList<Boolean> firstTime=new ArrayList<Boolean>();
  int number;//used to have different id in layers for the graph of the clusters's position
  int number2;//used to have different id in layers for the graph of the clusters's regression
  PApplet parent;
  GPlot plot;
  float plotxScale = 1.7;
  float plotyScale = 1;
  int timelapse;
  
  ArrayList<ArrayList<ArrayList<Float[]>>> hugeArray;//Arraylist of the regression


  
  public ChildApplet2(PApplet parent) {
    super();
    this.parent = parent;
    number=0;
    number2=0;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
    timelapse=0;
    hugeArray = new ArrayList<ArrayList<ArrayList<Float[]>>>();
    

  }
  
  public void settings() {
    size(int(parent.width/plotxScale),int(parent.height/plotyScale));
  }  
  
  public void setup() {
    background(255);
    surface.setTitle("Courbes");
    surface.setLocation(300+parent.width,100);
  }
  
  public void draw() {
    this.plot=new GPlot(this);
    this.colorMode(HSB);
    if (child.courbe.on){
      surface.setLocation(1100,100);//the two windows are next to each other
      String S = flock.clusterer.listPositions(date);//we write in a csv file, so the values can be exported and analysed with python later
      traceAGraph(S,this.plot,flock.clusterer.hues, number,this);//graph traced
      number++;
    } 
    if(!child.courbe.on){
      surface.setLocation(11000,11000);//hide window far away from the user's screen 
      background(255);//clear window
    }
  }
  public void keyPressed(){
    //maintain key k pressed, and the regression will be plot
      if (key =='k'){
        if (timelapse>10*flock.clusterer.sizeValidityPolinomialRegression){//we are adding an offset in order to show be able to compare regression and actual positions
          flock.clusterer.updatePolReg();//update the linear regression
          traceAGraphv2(hugeArray.get(timelapse-flock.clusterer.sizeValidityPolinomialRegression*10), this.plot, flock.clusterer.hues,number2, this);
          hugeArray.add(flock.clusterer.regPol);
          number2++;
          timelapse++;
        }
        else {
          timelapse++;
          flock.clusterer.updatePolReg();
          hugeArray.add(flock.clusterer.regPol);
        }        
      }
  }
  public void keyReleased(){
    if(key=='k'){
      this.timelapse =0;
      this.hugeArray.clear();
    }//if the key k is released we stop to trace the regression
    
  }
  
 
}

public void keyPressed() {
  if (key == 's') {
    // Saves the data in a csv file
    flock.clusterer.listPositions(day() + "_" + month() + "_" + hour() + "_" + minute() + "_" + second());
  }
  
  if (key == 'h') {
    // Saves the data in a csv file
    flock.clusterer.listHues(date);
  }
  
  
  if (key == 'm') {
    //create two swarms that should merge
    int N1 = 50;
    float std1 = 10;
    float x1 = 50;
    float y1 = 280;
    float angle1 = 0;
    flock.addCluster(N1, x1, y1, std1, angle1);
    
    int N2 = 50;
    float std2 = 10;
    float x2 = 280;
    float y2 = 50;
    float angle2 = PI/2;
    flock.addCluster(N2, x2, y2, std2, angle2);
  }
  
  
  if (key == 'p') {
    //create a swarm that should split
    int N1 = 60;
    float std1 = 25;
    float x1 = 50;
    float y1 = 50;
    float angle1 = PI/4;
    flock.addCluster(N1, x1, y1, std1, angle1);
    
    //create an obstacle
    obstacles.addObstacle(new Circle(300,300,20,true, flock.grid));
    
    
  }
  
  if (key == 'o') {
    //create a swarm that should split
    /*int N1 = 60;
    float std1 = 25;
    float x1 = 50;
    float y1 = 50;
    float angle1 = PI/4;
    flock.addCluster(N1, x1, y1, std1, angle1);*/
    
    //create an obstacle
    obstacles.addObstacle(new Circle(300,300,20,true, flock.grid));
    
    
  }
  
  if (key == 'c') {
     obstacles.addObstacle(new Circle(random(width),random(height),random(80),true, flock.grid));
  }
  
}
