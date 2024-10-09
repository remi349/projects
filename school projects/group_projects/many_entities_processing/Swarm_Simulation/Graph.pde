/**
* Final Application Project, June 2022
* Télécom Paris
* Authors : Delhio Calves, Matthieu Carreau, Rémi Ducottet, Paul Triana
*
* Graph class: the environment is represented as a graph, each vertex of it represents a mesh of the grid and
* each edge carries a value whic representsthe cost of moving towards the next mesh
*/
class Graph {
  
  ArrayList<Vertice> CC; // Les noeuds
  //IntList Connexe;
  ArrayList<Edge> T; //Les arêtres
  Tree tree;
  float infinity = 1e38; //L'infini
  ArrayList<Vertice> A;
  int ex = 0;
  Vertice root; //Le noeud de départ pour Dijkstra
  boolean clicked;
  float dec = 0;
  
  
  //Constructeur d'un graphe non-orienté à partir des arêtes T et des noeuds CC
  Graph(ArrayList<Vertice> CC, ArrayList<Edge> T) {
    this.CC = CC;
    int n = CC.size();
    this.T = T;
    //A = new ArrayList<Edge>();
    /*Connexe = new IntList(n);
    for (int i = 0; i<n; i++) {
      Connexe.set(i,i);
    }*/
    clicked = false;
  }
  
  void run() {
    render();
  }
    
  //Dessine le graphe dans la simulation
  void render() {
    strokeWeight(1);
    for (Edge e : T) {
      if (e.inShortPath) {
        stroke(255,100,100);
        line(e.start.pos.x+dec, e.start.pos.y+dec, e.end.pos.x+dec,e.end.pos.y+dec);
      }
      
    }
    stroke(255,0,0);
    strokeWeight(9);
    point(root.pos.x, root.pos.y);
  }
  
  //Applique l'alogrithme de Dijkstra au graphe
  void Dijkstra() throws Exception{
    //this.root = root;
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
      if (!(pivot == null)) {
        //println(CC.size() - i);
        for (Vertice v : CC) { 
          if ((!in(A,v)) && (pivot.succesor(v))) {
            println("ok");
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
    }
  }
  
  //vérifie l'appartenant
  boolean in(ArrayList<Vertice> B, Vertice v) {
    for (Vertice ve : B) {
      if (ve==v) {
        return true;
      }
    }
    return false;
  }
  
  //Renvoie l'arête de pivot à v
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
  
  //Renvoie le minimum de la fonction Pi dans Disjktra
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
  
  //Initialise tous les successors de tous les noeuds
  void setSuccessors() {
    for (Edge e : T) {
      //print("yes");
      e.start.successors.add(e);
      e.end.successors.add(e);
    }
  }
  
  //Trouve le plus court chemin depuis root de longueur n
  void shortestPath(int n) throws Exception{
    ArrayList<Vertice> B = new ArrayList<Vertice>();
    Vertice pivot;
    pivot = root;
    int i = 0;
    while (i<n) {
      if (!(pivot == null)) {
        float min = infinity;
        boolean start = false;
        Edge mine = new Edge();
        for (Edge e : pivot.successors) {
          if (true) {
            if (e.start == pivot) {
              if (!in(B,e.end)) {
                if (e.weight < min) {
                  start = false;
                  mine = e;
                  min = e.weight;
                }
              }
            }
          }
        }
        mine.inShortPath = true;
        pivot = mine.end;
      }
    i++;
    }
  }
  

}

//Classe d'un couple d'objets (pas utilisée)
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

//Classe des noeuds
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
  
  Vertice(PVector pos) {
    this.pos = pos;
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

//Classe des arêtes
class Edge {
  
  Vertice start;
  Vertice end;
  float weight;
  boolean inTree;
  boolean inShortPath; //Boolean si l'arête est dans le plus court chemin trouvé dans void shortestPath(int n)
  PVector dir;
  
  Edge(Vertice start, Vertice end, float weight) {
    this.start = start;
    this.end = end;
    this.weight = weight;
    dir = new PVector(end.pos.x - start.pos.x,end.pos.y - start.pos.y);
    dir.normalize();
    inTree = false;
    inShortPath = false;
  }
  
  Edge() {
    
  }
}

//Classe d'un chemin (pas utilisée)
class Path {
  
  ArrayList<Edge> path;
  float weight;
  
  Path(Vertice v) {
    path = new ArrayList<Edge>();
    path.add(v.mainSuccessor);
    weight = 0;
    //extend();
  }
  
  /*void extend() {
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
  }*/
  
}

//Classe d'un arbre (pas utilisée)
class Tree{
  
  Tree(ArrayList<Edge> T) {
    ArrayList<Vertice> CC = new ArrayList<Vertice>();
  }  
  
}
