class Bezier {
  
  PVector X;
  PVector Y;
  PVector a1;
  PVector a2;
  boolean selected;
  float alpha = 0.35;
  
  Bezier(PVector X,PVector Y,PVector a1,PVector a2) {
    this.X=X;
    this.Y=Y;
    this.a1=a1;
    this.a2=a2;
    selected = false;
  }
  
  Bezier(PVector X, PVector Y) {
    this.X=X;
    this.Y=Y;
    a1 = X.copy().add(PVector.sub(Y,X).mult(alpha));
    a2 = Y.copy().add(PVector.sub(X,Y).mult(alpha));
    selected = false;
  }
  
  Bezier(PVector X, PVector Y, PVector col) {
    this.X=X;
    this.Y=Y;
    a1 = X.copy().add(PVector.sub(X,col));
    a2 = Y.copy().add(PVector.sub(X,Y).mult(alpha));
    selected = false;
  }
  
  PVector getSecondAnchor() {
    return a2.copy();
  }
  
  PVector getAnchor(int n) {
    if (n==1) {
      return a1.copy();
    } else {
      return a2.copy();
    }
  }
  
  void setAnchor(int a, float x, float y) {
    if (a==1) {
      a1 = new PVector(x,y);
    } else if (a==2) {
      a2 = new PVector(x,y);
    }
  }
  
  int touchAnchor(float x, float y, int r) {
    if (sqrt(sq(x-a1.x) + sq(y-a1.y)) <= 5) {
      print(1);
      return 1;
    } else if (sqrt(sq(x-a2.x) + sq(y-a2.y)) <= 5) {
      print(2);
      return 2;
    } else {
      print(0);
      return 0;
    }
  }
  
  void select() {
    selected = true;
  }
  
  void deselect() {
    selected = false;
  }
  
  PVector bezier(float t) {
    return new PVector(pow(1-t,3)*X.x+3*t*pow(1-t,2)*a1.x+3*(1-t)*pow(t,2)*a2.x +pow(t,3)*Y.x,pow(1-t,3)*X.y+3*t*pow(1-t,2)*a1.y+3*(1-t)*pow(t,2)*a2.y +pow(t,3)*Y.y);
  }
  
  void setOpAnchor(int a, PVector op) {
    if (a==1) {
      a1 = X.copy().add(PVector.sub(X,op));
    } else if (a==2) {
      a2 = Y.copy().add(PVector.sub(Y,op));
    }
  }
  
  
}
