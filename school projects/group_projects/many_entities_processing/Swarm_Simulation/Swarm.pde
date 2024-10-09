/**
* Final Application Project, June 2022
* Télécom Paris
* Authors : Delhio Calves, Matthieu Carreau, Rémi Ducottet, Paul Triana
*
* Flock class: represents the set of all the entities in the simulation, appears as one or many swarms in the simulation
*/

class Flock {
  ArrayList<Boid> boids; // An ArrayList for all the boids
  Clustering clusterer;
  PVector center = new PVector(0,0);
  Grid grid;
  float rmean; //coeff de determination moyen de toutes les régressions polynomiales des essaimes
  int numreg; //nombre de régressions
  boolean graphing = false; //booleans pour l'affichage de la prédiction par parcours de graphe
  boolean graphed = false;
  int q = 20;
  
  static final float neighbordist = 50; // distance for research of neighbors
  int RESOLUTION_X = ceil((float)width/neighbordist) ;
  int RESOLUTION_Y = ceil((float)height/neighbordist) ;

  Flock() {
    boids = new ArrayList<Boid>(); // Initialize the ArrayList
    clusterer = new Clustering();
    grid = new Grid(RESOLUTION_Y, RESOLUTION_X);
  }

  void run(ArrayList<Obstacle> obstacles) throws Exception{
    //boolean need_to_recluster_flag = false;
    for (Boid b : boids) {
      b.run(boids, obstacles);  // Passing the entire list of boids to each boid individually
      //need_to_recluster_flag = need_to_recluster_flag || b.need_to_recluster_flag;
    }
    rmean = 0;
    int numclusters = clusterer.clusters.size();
    numreg = 0;
    for (int c = 0; c<numclusters; c++){
      //println(clusterer.clusters.get(c).rtot);
      if (!(clusterer.clusters.get(c).rtot == 0)) {
        rmean += clusterer.clusters.get(c).rtot;
        numreg++;
        
      }
      //println(numreg);
      Cluster clu =clusterer.clusters.get(c);
      clu.run(clusterer.hues.get(clu.id));
    }
    //if (need_to_recluster_flag) colourByGroup();
    
    if (!(numreg==0) && child.regression.on) {
      //println("go");
      rmean = rmean/numreg;
      child.r = rmean;
      /*textSize(50);
      fill(120,100,100);
      text("R**2 = " + rmean,10,50);*/
    }
    if (graphing & !graphed) {
      graphed = true;
      Cluster c = clusterer.clusters.get(0);
      graph(c);
    }
  }
  
  void graphing() {
    graphing = true;
  }
  
  //Colorer chaque groupe d'une couleur différente
  void colourByGroup() {
    clusterer.find(boids);
    /*
    for (int c = 0; c<clusterer.clusters.size(); c++){
      clusterer.clusters.get(c).run((float)c/((float)clusterer.nb_clusters)*100.0);
    }*/
    
    int N = boids.size();
    for (int i = 0; i< N; i++) {
      if (boids.get(i).clusterId>=0) boids.get(i).hue = clusterer.hues.get(boids.get(i).clusterId);
      else boids.get(i).hue = 0;
    }
    
    
  }

  //Ajoute un agent à la simulation
  void addBoid(float x, float y) {
    int id = boids.size();
    boids.add(new Boid(x, y, grid, neighbordist, id));
  }
  
  //Ajoute un essaim à la simulation, le nombre d'agents dans cet essaiml est N
  void addCluster(int N, float x, float y, float std, float angle) {
    /* Creates a cluster of N boids, centered around pos, with std */
    PVector pos = new PVector(x,y);
    for (int i = 0; i<N; i++) {
       PVector p = PVector.random2D().mult(randomGaussian()*std).add(pos);
       int id = boids.size();
       Boid b = new Boid(max(5, min(width-5,p.x)), max(5, min(height-5,p.y)), grid, neighbordist, id);
       b.velocity = new PVector(cos(angle), sin(angle));
       boids.add(b);
    }
  }
  
  //Créer le graphe avec la prédiction à partir du premier essaim (nous n'avons pas eu le temps d'implémenter cette fonction pour tous les essaims)
  void graph(Cluster c) throws Exception{
     ArrayList<Edge> T = new ArrayList<Edge>();
     ArrayList<Vertice> CC = new ArrayList<Vertice>();
     Graph g = new Graph(CC, T);
     PVector vel = c.vel;
     //int q = 1;
     Vertice root;
     for (int i=0; i<grid.height_grid; i++) {
       for (int j=0; j<grid.width_grid; j++) {
         Mesh a = grid.boxes[i][j];
         if (grid.getMeshFromPos(c.center) == a) {
                //println(a.getPos());
                //println(c.center);
                //println("root");
                a.v = new Vertice(a.getPos());
                g.CC.add(a.v);
                root = a.v;
                //q = min(min(i,grid.height_grid-i),min(i,grid.width_grid-i));
                g.CC.add(root);
                g.root = root;
                a.covered = true;
           
           ArrayList<Mesh> neighbors = a.getNeighbors();
           for (Mesh b : neighbors) {
             if (!(a==b)) {
              if (!b.covered) { 
                b.v = new Vertice(b.getPos());
                g.CC.add(b.v);
                b.covered = true;
              }             
              float weight = grid.poidsArete(a,b,vel);
              Edge e = new Edge(a.v,b.v,weight);
              g.T.add(e);
             }
           }
         } else {
           if (!a.covered) { 
                a.v = new Vertice(a.getPos());
                g.CC.add(a.v);
                a.covered = true;
           } 
           //Vertice A = new Vertice(a.getPos());
           //g.CC.add(A);
           ArrayList<Mesh> neighbors = a.getNeighbors();
           for (Mesh b : neighbors) {
             if (!(a==b)) {
             if (!b.covered) { 
                b.v = new Vertice(b.getPos());
                g.CC.add(b.v);
                b.covered = true;
              }             
              float weight = grid.poidsArete(a,b,vel);
              Edge e = new Edge(a.v,b.v,weight);
              g.T.add(e);
           }
           }
         }
       }
     }
     g.setSuccessors();
     //g.Dijkstra();
     g.shortestPath(q);
     c.graph = g;
     c.graphed = true;
     c.graph.dec = height/(2*grid.height_grid);
   }
   
}
