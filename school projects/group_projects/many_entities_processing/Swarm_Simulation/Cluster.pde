/**
* Final Application Project, June 2022
* Télécom Paris
* Authors : Delhio Calves, Matthieu Carreau, Rémi Ducottet, Paul Triana
*
* Cluster class: represents a bunch of entities which present a spatial proximity and are considered as a group
*/

class Cluster {
 ArrayList<Boid> boids;
 PVector center = new PVector(0,0);
 int N = 10;
 int Nreg = 15;

 int id = -1;
 int centertrailLength = 10000;
 ArrayList<PVector> centertrail;
 ArrayList<Integer> frameCounts;
 PVector vel;
 FloatList abs;
 FloatList ord;
 FloatList t;
 int regress = 0;
 //ArrayList<PVector> list;
 ArrayList<ArrayList<PVector>> regs;
 Regression reg;
 Regression reg2;
 Polynome p;
 Polynome p2;
 int numPoints = 20;
 int framediff = 10;
 int degre = 2;
 float rtot = 0;
 Graph graph;
 boolean graphed = false;


 
 Cluster(ArrayList<Boid> b) {
   boids = b;
   
   abs = new FloatList();
   ord = new FloatList();
   t = new FloatList();
   for (int i  = 0; i<N; i++) {
    t.append(framediff*i);
  }
  
   centertrail = new ArrayList<PVector>();
   regs = new ArrayList<ArrayList<PVector>>();
   
    
   frameCounts = new ArrayList<Integer>();
   frameCounts.add(frameCount);
 }
 
 PVector copy(PVector p) {
    return new PVector(p.x, p.y);
  }
  
 void run(float hue){
   if (boids.size()==0) {
     rtot = 0;
   }
   else {
     calcCenter();
     updatecenterTrail();
     if (frameCount%framediff == 0) {
       getCoordforReg();
     }
   }
   if (graphed) {
     graph.run();
   }
   render(hue);
 }
 
  void updatecenterTrail() {
    centertrail.add(copy(center));
    frameCounts.add(frameCount);
  }
 
 void add(Boid boid) {
   boids.add(boid);
 }
 
  //Calculate the center of a group
  void calcCenter(){
    PVector sum = new PVector(0,0);
    int count = 0;
    for (Boid boid : boids){
      sum.add(boid.position);
      count++;
    }
    if (count>0){
      center = sum.div(count);
    }
  }
  
  void render(float hue){
    int Q = centertrail.size();
    //Draw the tail as lines
    int max_points = 500; //number of points max in the tail
    strokeWeight(2);
    for (int k = max_points-1; k >=0; k--) {  
      if (Q-k>1){
          int lum = max(0,100-((frameCount-frameCounts.get(Q-k))*100)/max_points);
          stroke(hue,30,lum);
          line(centertrail.get(Q-k-1).x,centertrail.get(Q-k-1).y,centertrail.get(Q-k-2).x,centertrail.get(Q-k-2).y);
      }
    }
    strokeWeight(1);
    
    
    if (boids.size()>0)  {
      if ((regress > 1) && child.regression.on) {
          drawReg();
      }
      PVector dir;
      if (centertrail.size() >=2) {
        dir = new PVector(center.x-centertrail.get(centertrail.size()-2).x, center.y-centertrail.get(centertrail.size()-2).y);
      } else {
        dir = new PVector(0,0);
      }
      vel = dir;
      color c = color(hue,60,100);
      int r = 10;
      stroke(c);
      fill(c);
      pushMatrix();
      translate(center.x, center.y);
      rotate(dir.heading()+PI/2);
      beginShape(TRIANGLES);
      vertex(0, -r*2);
      vertex(-r, r*2);
      vertex(r, r*2);
      endShape();
      popMatrix();
      noStroke();
    }
  }
  
// used to apply the regression method on the positions of the center of the group
  void getCoordforReg(){

    if (abs.size() == N) {
      abs.remove(0);
      ord.remove(0);
    }
    abs.append(center.x);
    ord.append(center.y);
    if ((abs.size() == N) && child.regression.on){
      reg = new Regression(abs, t, 10000, 0.001, 0.999, degre);
      reg2 = new Regression(ord, t, 10000, 0.001, 0.999, degre);
      p = reg.PolyRegCost();
      p2 = reg2.PolyRegCost();
      rtot = (reg.r+reg2.r)/2;
      regress = 2;
      listforDraw();
   }
  }
    
  // used to draw the regression based on a list
  void drawReg(){
    int centsize = centertrail.size();
    for (int k=0; k<regs.size(); k++) {
      ArrayList<PVector> list = regs.get(regs.size()- 1 - k);
      for (int i=0; i<numPoints-1; i++){
        stroke(0,0,100*(regs.size()-k)/regs.size());
        line(list.get(i).x -list.get(0).x + centertrail.get(centsize-1-k*framediff).x, list.get(i).y - list.get(0).y +centertrail.get(centsize-1-k*framediff).y,list.get(i+1).x -list.get(0).x+centertrail.get(centsize-1-k*framediff).x, list.get(i+1).y - list.get(0).y +centertrail.get(centsize-1-k*framediff).y);
        textSize(50);
        fill(120,100,100);
      }
    }

  }
  

  // creates a list based on the polynomial regression
  void listforDraw(){
    if (regs.size() == Nreg) {
      regs.remove(0);
    }
    ArrayList<PVector> list = new ArrayList<PVector>();
    for (int i=0; i<numPoints; i++){
      list.add(new PVector(p.f(t.get(t.size()-1)+i*framediff), p2.f(t.get(t.size()-1)+i*framediff)));
    }
    regs.add(list);
  }
}
