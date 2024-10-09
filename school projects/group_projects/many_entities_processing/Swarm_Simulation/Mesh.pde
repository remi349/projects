/**
* Final Application Project, June 2022
* Télécom Paris
* Authors : Delhio Calves, Matthieu Carreau, Rémi Ducottet, Paul Triana
*
* Mesh class: represents a cell of the global grid, a mesh is able to tell which entities are present on itself in real-time
*/

class Mesh{
  Grid grid; //la grille mère
  int i;
  int j;
  ArrayList<Boid> boids; //boids present in a mesh
  Obstacles obstacles; //obstacles present in a Mesh
  ArrayList<Float> wall_sizes;//length of each obstacle
  boolean covered = false;
  Vertice v; //Noeuf coresspondant à la maille pour l'algorithme de prédiction par parcours de graphe
  
  Mesh(Grid grid, int i, int j){
    boids = new ArrayList<Boid>();
    obstacles = new Obstacles();
    this.grid = grid;
    this.i=i;
    this.j=j;
    wall_sizes = new ArrayList<Float>();
  }
  

  
  //returns the Neighbors of a Mesh and the Mesh itself
  ArrayList<Mesh> getNeighbors(){
    ArrayList<Mesh> neighbors = new ArrayList<Mesh>();
    int i = this.getI();
    int j = this.getJ();

    neighbors.add(this.grid.getMesh(i,j));
    //there is many different cases whether the mesh is at a corner or not
    if (i>0){
      neighbors.add(this.grid.getMesh(i-1,j));
      if (j>0){
        neighbors.add(this.grid.getMesh(i-1,j-1));
      }
      if (j<this.grid.getWidth()-1) {
        neighbors.add(this.grid.getMesh(i-1,j+1));
      } 
    }
    if (i<this.grid.getHeight()-1){
      neighbors.add(this.grid.getMesh(i+1,j));
      if (j>0){
        neighbors.add(this.grid.getMesh(i+1,j-1));
      }
      if (j<this.grid.getWidth()-1){
        neighbors.add(this.grid.getMesh(i+1,j+1));
      }
    }
    if (j>0){
      neighbors.add(this.grid.getMesh(i,j-1));
    }
    if (j<this.grid.getHeight()-1) {
      neighbors.add(this.grid.getMesh(i,j+1));
    }
    return neighbors;
  }
  
  //Renvoie l'indice i
  int getI(){
    return this.i;
  }
  
  //Renvoie l'indice j
  int getJ(){
    return this.j;
  }
  
  //Renvoie la position selon x
  float getX() {
    return i*width/grid.width_grid;
  }
  
  //Renvoie la position selon y
  float getY() {
    return j*height/grid.height_grid;
  }
  
  //Renvoie le vecteur position
  PVector getPos(){
    return new PVector(getY(), getX());  
  }
  
  //Renvoie le Grid dans lequel se trouve la maille
  Grid  getGrid(){
    return grid;
  }
  
  //Renvoie les agents présents dans la maille 
  ArrayList<Boid> getBoids(){
    return this.boids;
  }
  
  //Ajoute un agent à la maille=
  void addBoidToMesh(Boid b){
    this.boids.add(b); 
  }
}

  
  
