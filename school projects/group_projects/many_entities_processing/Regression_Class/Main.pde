FloatList x;
FloatList y;
int n = 0;
int nmax = 1000000;
float alpha = 0.0001;
float rmin = 0.999;
PVector theta;
//Regression reg;
boolean linear = false;
boolean changed = true;
PVector start;
PVector end;
ArrayList<PVector> plot;
StringList degree = new StringList();
//int deg = 3;
int drag = 0;
Polynome p;
int deg;
Regression reg;
float rmax;

void setup() {
  size(800,800);
  background(0);
  
  degree.append("linear");
  degree.append("quadratic");
  degree.append("cubic");
  degree.append("th degree polynomial");
  
  x = new FloatList();
  y = new FloatList();
  /*float[][] a = new float[2][2];
  a[0][0] = 0f;
  a[0][1] = -1f;
  a[1][0] = 1f;
  a[1][1] = 0f;
  float[][] b = new float[2][2];
  b[0][0] = 1f;
  b[0][1] = 2f;
  b[1][0] = 3f;
  b[1][1] = 4f;
  //println(a[0][0]);
  Matrix m = Matrix.Multiply(Matrix.array(a),Matrix.array(b));
  Matrix.print(m);*/
}

void draw() {
  background(0);
  float xval;
  noStroke();
  fill(255,0,0);
  for (int k = 0; k<n; k++) {
       circle(x.get(k),height - y.get(k), 6);
  }
  /*for (int k = 0; k<n; k++) {
    xval = floor(width/n)*k;
    x.append(xval);
    y.append(max(xval+random(-50,50),0));
  }*/
  //println(x);
  //println(y);
  if (x.size() > 1) {
    if (changed) {
      //println("polynomial regression");
      float xmin = x.min();
      ArrayList<Regression> regs = new ArrayList<Regression>();
      ArrayList<Polynome> polys = new ArrayList<Polynome>();
      for (int i=0; i<4; i++) {
        regs.add(new Regression(y,x,nmax,alpha,rmin,i+1));
        polys.add(regs.get(i).PolyRegCost());
      }
      deg = 0;
      reg = regs.get(0);
      p = polys.get(0);
      rmax = regs.get(0).r;
      for (int i=0; i<3; i++) {
        if (regs.get(i).r > rmax) {
          reg = regs.get(i);
          deg = i;
          p = polys.get(i);
          rmax = reg.r;
        }
      }
      plot = new ArrayList<PVector>();
      float max = 0;
      for (int i = 0; i<width/10; i++) {
        if (p.f(i)>max) {
          max = p.f(i);
        }
        plot.add(new PVector(10*i,p.f(10*i)));
      }
      /*for (int i = 0; i<width/10; i++) {
        plot.get(i).y = plot.get(i).y*(height/max);
      }*/
      //print(plot);
      changed = false;
      
      Regression kejfijez = new Regression(y,x,nmax,alpha,rmin,1);
      PVector ppp = kejfijez.LinReg();
      plot = new ArrayList<PVector>();
      max = 0;
      for (int i = 0; i<width/10; i++) {
        if (p.f(i)>max) {
          max = p.f(i);
        }
        plot.add(new PVector(10*i,ppp.x+ppp.y*10*i));
      }
      
    }
    int q = plot.size();
    for (int k = 0; k<q-1; k++) {
      noFill();
      stroke(255,255,255);
      line(plot.get(k).x, height - plot.get(k).y, plot.get(k+1).x, height - plot.get(k+1).y);
    }
    textSize(50);
    fill(0,255,0);
    text("R**2 = " + rmax,10,50);
    String degr = degree.get(min(4,deg));
    text("Regression Type : " + degr, 10, 100);
  }
}
 

void mouseDragged() {
  if (drag%10==0) {
    x.append(mouseX);
    y.append(height-mouseY);
    n++;
    changed = true;
  }
  drag++;
}
