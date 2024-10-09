FloatList X;
FloatList Y;
ArrayList<PVector> P = new ArrayList<PVector>();
PVector col;
Bezier bint;
int sizep;
Polynome p;
int m;
int n;
int r = 5;
int a;
boolean anchorSelected = false;
boolean circulaire;
int selectedBezier = 0;
ArrayList<Bezier> bezier = new ArrayList<Bezier>();

void setup() {
  size(500,500);
  background(0);
  /*X = new FloatList();
  X.append(100);
  X.append(200);
  //X.append(300);
  Y = new FloatList();
  Y.append(300);
  Y.append(100);*/
  //Y.append(100);
  //stroke(255,255,255);
  //m = X.size();
  /*for (int i=0; i<m; i++) {
    circle(X.get(i), Y.get(i), 5);
  }
  p = new Lagrange(X,Y);
  p.print();*/
  
  init();
  
  //circulaire = true;
  sizep = P.size();
  for (int i=0; i<sizep; i++) {
    if (i==0) {
      bezier.add(new Bezier(P.get(i), P.get(i+1)));
      col = bezier.get(i).getSecondAnchor();
    } else if (i==sizep-1) {
      if (circulaire) {
        bezier.add(new Bezier(P.get(i), P.get(0), col));
        col = bezier.get(i).getSecondAnchor();
        bezier.get(0).setOpAnchor(1, col);
      }       
    } else {
      bezier.add(new Bezier(P.get(i), P.get(i+1), col));
      col = bezier.get(i).getSecondAnchor();
    }
  }
  
  n = bezier.size();
  print("number of curves : ");
  println(n);
  fill(255,255,255);
  for (Bezier b : bezier) {
    stroke(255,100,0);
    noFill();
    circle(b.X.x,b.X.y,r);
    circle(b.a1.x,b.a1.y,r);
    line(b.X.x,b.X.y,b.a1.x,b.a1.y);
    circle(b.a2.x,b.a2.y,r);
    circle(b.Y.x,b.Y.y,r);
    line(b.Y.x,b.Y.y,b.a2.x,b.a2.y);
    stroke(255,255,255);
    bezier(b.X.x,b.X.y,b.a1.x,b.a1.y,b.a2.x,b.a2.y,b.Y.x,b.Y.y);
  }
}

void draw() {
  background(0);
  /*fill(255,255,255);
  for (int i=0; i<m; i++) {
    circle(X.get(i), Y.get(i), 5);
  }
  noFill();
  stroke(100,100,100);
  float y = p.f(0);
  for (int x=1; x<width; x++) {
    line(x-1, y , x, p.f(x));
    y = p.f(x);
  }*/
  for (int i = 0; i<n; i++) {
    noFill();
    Bezier b = bezier.get(i);
    if (anchorSelected && (selectedBezier == i)) {
      if (a==1) {
        stroke(100,255,100);
        circle(b.X.x,b.X.y,r);
        circle(b.a1.x,b.a1.y,r);
        line(b.X.x,b.X.y,b.a1.x,b.a1.y);
        stroke(255,100,0);
        circle(b.a2.x,b.a2.y,r);
        circle(b.Y.x,b.Y.y,r);
        line(b.Y.x,b.Y.y,b.a2.x,b.a2.y);
        stroke(255,255,255);
        bezier(b.X.x,b.X.y,b.a1.x,b.a1.y,b.a2.x,b.a2.y,b.Y.x,b.Y.y);
      } else if (a==2){
        stroke(255,100,0);
        circle(b.X.x,b.X.y,r);
        circle(b.a1.x,b.a1.y,r);
        line(b.X.x,b.X.y,b.a1.x,b.a1.y);
        stroke(100,255,100);
        circle(b.a2.x,b.a2.y,r);
        circle(b.Y.x,b.Y.y,r);
        line(b.Y.x,b.Y.y,b.a2.x,b.a2.y);
        stroke(255,255,255);
        bezier(b.X.x,b.X.y,b.a1.x,b.a1.y,b.a2.x,b.a2.y,b.Y.x,b.Y.y);
      }
    } else {
      stroke(255,100,0);
      circle(b.X.x,b.X.y,r);
      circle(b.a1.x,b.a1.y,r);
      line(b.X.x,b.X.y,b.a1.x,b.a1.y);
      circle(b.a2.x,b.a2.y,r);
      circle(b.Y.x,b.Y.y,r);
      line(b.Y.x,b.Y.y,b.a2.x,b.a2.y);
      stroke(255,255,255);
      bezier(b.X.x,b.X.y,b.a1.x,b.a1.y,b.a2.x,b.a2.y,b.Y.x,b.Y.y);
    }
  }
}

void init() {
  P.add(new PVector(40,100));
  P.add(new PVector(100,100));
  P.add(new PVector(200,140));
  P.add(new PVector(300,300));
  P.add(new PVector(100,450));
  P.add(new PVector(40,230));
}

void mousePressed() {
   for (int i = 0; i<n; i++) {
    int b = bezier.get(i).touchAnchor(mouseX,mouseY, r);
    if (!(b==0)){
      a = b;
      selectedBezier = i;
      anchorSelected = true;
      print("anchor selected : ");
      println(selectedBezier);
      return;
    }
  }
}

void mouseDragged() {
  if (anchorSelected) {   
      bezier.get(selectedBezier).setAnchor(a, mouseX, mouseY);
      PVector newAnc = bezier.get(selectedBezier).getAnchor(a);
      if (a==1){
        if (selectedBezier == 0) {
          if (circulaire){
            bezier.get(n-1).setOpAnchor(op(a),newAnc);
          }
        } else {        
          bezier.get(selectedBezier-1).setOpAnchor(op(a), newAnc);
        }
      } else if ((a==2)) {
        if (selectedBezier == n-1) {
          if (circulaire){
            bezier.get(0).setOpAnchor(op(a),newAnc);
          }
        } else {        
          bezier.get(selectedBezier+1).setOpAnchor(op(a), newAnc);
        }
      }
  }
}

void mouseReleased() {
  anchorSelected = false;
}

int op(int l) {
  if (l==1) {
    return 2;
  } else if (l==2) {
    return 1;
  } else {
    return 0; 
  }
}
