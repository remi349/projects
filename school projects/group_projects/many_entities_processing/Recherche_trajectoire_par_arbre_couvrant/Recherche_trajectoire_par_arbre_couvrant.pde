float griddiv = 50;
float x = 2.0;
Graph graph;
ArrayList<Vertice> CC;
ArrayList<Edge> T;
Vertice root;
boolean clicked;

void settings() {
  size(500,500);
}

void setup() {
  background(0);
  int n = floor(width/griddiv)+1;
  int m = floor(height/griddiv)+1;
  CC = new ArrayList<Vertice>();
  T = new ArrayList<Edge>();
  for (int j = 0; j<n; j++) {
    for (int i = 0; i<m; i++) {
      CC.add(new Vertice(i*griddiv, j*griddiv));
    } 
  }
  float weight;
  for (int i = 0; i<n; i++) {
    for (int j = 0; j<m; j++) { 
      if (i == 0) {
        if (j == 0) {
          weight = random(0,x);
          T.add(new Edge(CC.get(i+1+j*n),CC.get(i+j*n), weight));
          weight = random(0,x)*sqrt(2);
          T.add(new Edge(CC.get(i+1+(j+1)*n),CC.get(i+j*n), weight));
          weight = random(0,x);
          T.add(new Edge(CC.get(i+(j+1)*n),CC.get(i+j*n), weight));
        } else if (j==m-1) {
          weight = random(0,x);
          T.add(new Edge(CC.get(i+1+j*n),CC.get(i+j*n), weight));
          weight = random(0,x)*sqrt(2);
          T.add(new Edge(CC.get(i+1+(j-1)*n),CC.get(i+j*n), weight));
          weight = random(0,x);
          T.add(new Edge(CC.get(i+(j-1)*n),CC.get(i+j*n), weight));
        } else {
          weight = random(0,x);
          T.add(new Edge(CC.get(i+1+j*n),CC.get(i+j*n), weight));
          weight = random(0,x)*sqrt(2);
          T.add(new Edge(CC.get(i+1+(j-1)*n),CC.get(i+j*n), weight));
          weight = random(0,x);
          T.add(new Edge(CC.get(i+(j-1)*n),CC.get(i+j*n), weight));
          weight = random(0,x)*sqrt(2);
          T.add(new Edge(CC.get(i+1+(j+1)*n),CC.get(i+j*n), weight));
          weight = random(0,x);
          T.add(new Edge(CC.get(i+(j+1)*n),CC.get(i+j*n), weight));
        }
      } else if (i==n-1) {
        if (j == 0) {
          weight = random(0,x);
          T.add(new Edge(CC.get(i-1+j*n),CC.get(i+j*n), weight));
          weight = random(0,x)*sqrt(2);
          T.add(new Edge(CC.get(i-1+(j+1)*n),CC.get(i+j*n), weight));
          weight = random(0,x);
          T.add(new Edge(CC.get(i+(j+1)*n),CC.get(i+j*n), weight));
        } else if (j==m-1) {
          weight = random(0,x);
          T.add(new Edge(CC.get(i-1+j*n),CC.get(i+j*n), weight));
          weight = random(0,x)*sqrt(2);
          T.add(new Edge(CC.get(i-1+(j-1)*n),CC.get(i+j*n), weight));
          weight = random(0,x);
          T.add(new Edge(CC.get(i+(j-1)*n),CC.get(i+j*n), weight));
        } else {
          weight = random(0,x);
          T.add(new Edge(CC.get(i-1+j*n),CC.get(i+j*n), weight));
          weight = random(0,x)*sqrt(2);
          T.add(new Edge(CC.get(i-1+(j-1)*n),CC.get(i+j*n), weight));
          weight = random(0,x);
          T.add(new Edge(CC.get(i+(j-1)*n),CC.get(i+j*n), weight));
          weight = random(0,x)*sqrt(2);
          T.add(new Edge(CC.get(i-1+(j+1)*n),CC.get(i+j*n), weight));
          weight = random(0,x);
          T.add(new Edge(CC.get(i+(j+1)*n),CC.get(i+j*n), weight));
        }
      } else {
        if (j == 0) {
          weight = random(0,x);
          T.add(new Edge(CC.get(i-1+j*n),CC.get(i+j*n), weight));
          weight = random(0,x)*sqrt(2);
          T.add(new Edge(CC.get(i-1+(j+1)*n),CC.get(i+j*n), weight));
          weight = random(0,x);
          T.add(new Edge(CC.get(i+(j+1)*n),CC.get(i+j*n), weight));
          weight = random(0,x)*sqrt(2);
          T.add(new Edge(CC.get(i+1+(j+1)*n),CC.get(i+j*n), weight));
          weight = random(0,x);
          T.add(new Edge(CC.get(i+1+j*n),CC.get(i+j*n), weight));
        } else if (j==m-1) {
          weight = random(0,x);
          T.add(new Edge(CC.get(i-1+j*n),CC.get(i+j*n), weight));
          weight = random(0,x)*sqrt(2);
          T.add(new Edge(CC.get(i-1+(j-1)*n),CC.get(i+j*n), weight));
          weight = random(0,x);
          T.add(new Edge(CC.get(i+(j-1)*n),CC.get(i+j*n), weight));
          weight = random(0,x)*sqrt(2);
          T.add(new Edge(CC.get(i+1+(j-1)*n),CC.get(i+j*n), weight));
          weight = random(0,x);
          T.add(new Edge(CC.get(i+1+j*n),CC.get(i+j*n), weight));
        } else {
          weight = random(0,x);
          T.add(new Edge(CC.get(i-1+j*n),CC.get(i+j*n), weight));
          weight = random(0,x)*sqrt(2);
          T.add(new Edge(CC.get(i-1+(j-1)*n),CC.get(i+j*n), weight));
          weight = random(0,x);
          T.add(new Edge(CC.get(i+(j-1)*n),CC.get(i+j*n), weight));
          weight = random(0,x)*sqrt(2);
          T.add(new Edge(CC.get(i-1+(j+1)*n),CC.get(i+j*n), weight));
          weight = random(0,x);
          T.add(new Edge(CC.get(i+(j+1)*n),CC.get(i+j*n), weight));
          weight = random(0,x);
          T.add(new Edge(CC.get(i+1+j*n),CC.get(i+j*n), weight));
          weight = random(0,x)*sqrt(2);
          T.add(new Edge(CC.get(i+1+(j-1)*n),CC.get(i+j*n), weight));
          weight = random(0,x)*sqrt(2);
          T.add(new Edge(CC.get(i+1+(j+1)*n),CC.get(i+j*n), weight));
        }
      }
    } 
  }
  graph = new Graph(CC, T);
  graph.setSuccessors();
  int i = floor(random(n/3,2*n/3));
  int j = floor(random(m/3,2*m/3));
  root = CC.get(i+j*n);
  int q = min(min(i,n-i),min(j,m-j));
  //println(q);
  try {
    graph.Dijkstra(root);
    graph.shortestPath(q);
  } catch (Exception e) {
    println(e);
  }
}

void draw() {
  background(0);
  strokeWeight(1);
  for (Edge e : T) {
    if (!clicked || e.inTree) {
      if (clicked && (e.inShortPath)) {
        //println("short");
        stroke(255,100,100);
        line(e.start.pos.x, e.start.pos.y, e.end.pos.x,e.end.pos.y);
      } else {
        stroke(100,100,100);
        line(e.start.pos.x, e.start.pos.y, e.end.pos.x,e.end.pos.y);
      }
    }
  }
  strokeWeight(4);
  for (Vertice v : CC) {
    if (v.isTarget) {
      stroke(0,255,255);
      strokeWeight(9);
    } else {
      strokeWeight(4);
      stroke(0,255,0);
    }
    point(v.pos.x, v.pos.y);
  }
  stroke(255,0,0);
  strokeWeight(9);
  point(root.pos.x, root.pos.y);
}

void mouseClicked() {
  clicked = !clicked;
}
