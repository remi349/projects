class Graph {
  
  ArrayList<Vertice> CC;
  IntList Connexe;
  ArrayList<Edge> T;
  Tree tree;
  float infinity = 1e38;
  ArrayList<Vertice> A;
  int ex = 0;
  Vertice root;
  
  Graph(ArrayList<Vertice> CC, ArrayList<Edge> T) {
    this.CC = CC;
    int n = CC.size();
    this.T = T;
    //A = new ArrayList<Edge>();
    Connexe = new IntList(n);
    for (int i = 0; i<n; i++) {
      Connexe.set(i,i);
    }
  }
  
  void Dijkstra(Vertice root) throws Exception{
    this.root = root;
    A = new ArrayList<Vertice>();
    A.add(root);
    Vertice pivot;
    pivot = root;
    for (Vertice v : CC) {
      v.pi = infinity;
    }
    root.pi = 0;
    Edge e;
    for (int i =0; i<CC.size()-1; i++) {
      for (Vertice v : CC) {
        if (!in(A,v) && pivot.succesor(v)) {
          e = edge(pivot,v);
          if (pivot.pi + e.weight < v.pi) {
            v.pi = pivot.pi + e.weight;
            if (v.mainSuccessor == null) {
              e.inTree = true;
              v.mainSuccessor = e;
            } else {
              v.mainSuccessor.inTree = false;
              e.inTree = true;
              v.mainSuccessor = e;
            }
          }
        }
      }
      Vertice v = minPi();
      A.add(v);
      pivot = v;
    }
    //println(ex);
  }
  
  boolean in(ArrayList<Vertice> B, Vertice v) {
    for (Vertice ve : B) {
      if (ve==v) {
        return true;
      }
    }
    return false;
  }
  
  Edge edge(Vertice pivot, Vertice v) throws Exception{
    Edge res = null;
    for (Edge e : T) {
      if (((pivot == e.start) && (v == e.end)) || ((pivot == e.end) && (v == e.start))) {
        res = e;
      }
    }
    if (res == null) {
      throw new Exception("edge does not exist");
    }    
    return res;
  }
  
  Vertice minPi() throws Exception{
    Vertice res = null;
    float pi = infinity;
    for (Vertice v : CC) {
      if ((v.pi <= pi) && !in(A,v)) {
        res = v;
        pi = v.pi;
      }
    }
    if (res == null) {
      ex++;
      throw new Exception("no min");
    }
    return res;
  }
  
  void setSuccessors() {
    for (Edge e : T) {
      e.start.successors.add(e);
      e.end.successors.add(e);
    }
  }
  
  /*ArrayList<Vertice> getVertices(int n) {
    //println(root.mainSuccessor);
    ArrayList<ArrayList<Vertice>> N  = new ArrayList<ArrayList<Vertice>>();
    boolean already = true;
    for (int l=0; l<n; l++) {
      if (l==0) {
        N.add(new ArrayList<Vertice>());
        for (Vertice v : root.successors) {
          N.get(l).add(v);
        } 
      } else {
        N.add(new ArrayList<Vertice>());
        for (Vertice v : N.get(l-1)) {
          for (Vertice s : v.successors) {
            already = true;
            for (int k=0; k<l+1; k++) {
              for (Vertice ve : N.get(k)) {
                if (s == ve) {
                  already = false;
                }
              }
            }
            if (already) {
              if (l==n-1) {
                s.isTarget = true;
              }
              N.get(l).add(s);
            }
          }
        }
      }
    }
    //println(N.get(n-1).size());
    return N.get(n-1);
    //ArrayList<Vertice> N = new ArrayList<Vertice>();
    
  }*/
    
    
    
  
  void shortestPath(int n) throws Exception{
    /*ArrayList<Vertice> A = getVertices(n);
    ArrayList<Path> paths = new ArrayList<Path>();
    Path shortest = null;
    boolean cont = true;
    for (Vertice v : A) {
      
      paths.add(new Path(v));
    }
    for (Path path : paths) {
      if (shortest == null) {
        shortest = path;
      } else {
        if (path.weight < shortest.weight) {
          shortest = path;
        }
      }
    }
    if (shortest == null) {
      throw new Exception("no shortest path");
    }
    for (Edge e : shortest.path) {
      e.inShortPath = true;
    }*/
    ArrayList<Vertice> B = new ArrayList<Vertice>();
    Vertice pivot;
    B.add(root);
    pivot = root;
    int i = 0;
    while (i<n) {
      float min = infinity;
      boolean start = false;
      Edge mine = new Edge();
      for (Edge e : pivot.successors) {
        if (e.inTree) {
          if (e.start == pivot) {
            if (!in(B,e.end) && e.weight < min) {
              //print(n);
              //println(i);
              start = false;
              mine = e;
            }
          } else {
            if (!in(B,e.start) && e.weight < min) {
              //print(n);
              //println(i);
              start = true;
              mine = e;
            }
          }
        }
      }
      mine.inShortPath = true;
        if (start) {
          pivot = mine.start;
        } else {
          pivot = mine.end;
        }
        i++;
    }
  }

}

class Pair<K, V> {

    final K element0;
    final V element1;

    Pair(K element0, V element1) {
        this.element0 = element0;
        this.element1 = element1;
    }

    K first() {
        return element0;
    }

    V second() {
        return element1;
    }

}

class Vertice {
  
  PVector pos;
  float pi;
  //int connexe;
  ArrayList<Edge> successors;
  Edge mainSuccessor = null;
  boolean isTarget = false;
  
  Vertice( float x, float y) {
    pos = new PVector(x,y);
    successors = new ArrayList<Edge>();
  }
  
  boolean succesor(Vertice v) {
    for (Edge e : successors) {
      if (((e.start==v) || (e.end==v)) && !(v==this)) {
        return true;
      }
    }
    return false;
  }
  
}

class Edge {
  
  Vertice start;
  Vertice end;
  float weight;
  boolean inTree;
  boolean inShortPath;
  
  Edge(Vertice start, Vertice end, float weight) {
    this.start = start;
    this.end = end;
    this.weight = weight;
    inTree = false;
    inShortPath = false;
  }
  
  Edge() {
    
  }
}

class Path {
  
  ArrayList<Edge> path;
  float weight;
  
  Path(Vertice v) {
    path = new ArrayList<Edge>();
    path.add(v.mainSuccessor);
    weight = 0;
    extend();
  }
  
  void extend() {
    boolean cont = true;
    int i = 0;
    while ((cont) && (i<sq(CC.size()))) {
      if (path.get(i).start.mainSuccessor == null) {
        cont = false;
      } else {
        path.add(path.get(i).start.mainSuccessor);
        weight += path.get(i).weight;
      }
      i++;
      println(i);
    }
  }
  
}
