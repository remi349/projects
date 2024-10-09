/**
* Final Application Project, June 2022
* Télécom Paris
* Authors : Delhio Calves, Matthieu Carreau, Rémi Ducottet, Paul Triana
*
* Circle class: represents a circle-shaped obstacle
*/

class Circle extends Obstacle {
  
  PVector center;
  float radius;
  
  Circle(float x, float y, float radius, boolean show, Grid gr) {
    super(show, gr);
    center = new PVector(x, y);
    this.radius = radius;
    addToMeshs();
  }
  
  Circle(int x, int y, float radius, Grid gr) {
    super(true, gr);
    center = new PVector(x, y);
    this.radius = radius;
    addToMeshs();
  }
  
  //Renvoie la distance minimale entre le cercle et un agent de position pos et de direction dir
  PVector distance(PVector pos, PVector dir) {
    
    PVector u = PVector.sub(center,pos);
    float dis = u.mag() - radius/2;
    u.normalize();
    PVector v = new PVector(-u.y,u.x);
    float dot = dir.dot(u)/dir.mag();;
    float dotorth = dir.dot(v);
    float det = 4*sq(dir.dot(u.copy().mult(-1)))-4*(sq(u.mag())-sq(radius));
    if ((dot > 0) && (abs(det) >= 0)){
      if(dotorth > 0) {
        return v.copy().mult(dot*dis);
      } else {
        return v.copy().mult(-dot*dis);
      }
    } else {
      return new PVector(1000,1000);      
    }
  }
  
  void run() {
    render();
  }
  
  //Ajoute l'obstacle à une maille de la grille
  void addToMeshs() {
    float mesh_width = width/this.grid.height_grid;
    float mesh_height = height/this.grid.width_grid;
    int j_min = min(this.grid.width_grid-1, max(0,floor(((center.x-radius)/mesh_width))));
    int j_max = min(this.grid.width_grid-1, max(0,floor(((center.x+radius)/mesh_width))));
    int i_min = min(this.grid.height_grid-1, max(0,floor(((center.y-radius)/mesh_height))));
    int i_max = min(this.grid.height_grid-1, max(0,floor(((center.y+radius)/mesh_height))));
    //println(center.x, center.y, radius);
    for (int i = i_min; i<=i_max; i++) {
      for (int j = j_min; j<=j_max; j++) {
        if (intersectWithMesh(i, j, mesh_width, mesh_height)) {
          grid.getMesh(i,j).obstacles.addObstacle(this);
        }
      }
    }
    
  }
  
  //Détermine si un obstacle Circle s'interecte avec une maille
  boolean intersectWithMesh(int i, int j, float mesh_width, float mesh_height) {
    float x_min = mesh_width*j;
    float x_max = mesh_width*(j+1);
    float y_min = mesh_height*i;
    float y_max = mesh_height*(i+1);
    float d = 0;
    
    if (center.x < x_min) {
      if (center.y < y_min) {
        //distance between center and top left corner
        d = center.dist(new PVector(x_min, y_min));
      }
      else if (center.y < y_max) {
        //distance between center and left side
        d = x_min-center.x;
      }
      else {
        //distance between center and bottom left corner
        d = center.dist(new PVector(x_min, y_max));
      }
    }
    
    else if (center.x < x_max) {
      if (center.y < y_min) {
        //distance between center and top side
        d = y_min-center.y;
      }
      else if (center.y < y_max) {
        //center is in the square
        d = 0;
      }
      else {
        //distance between center and bottom side
        d = center.y-y_max;
      }
    }
    
    else {
      if (center.y < y_min) {
        //distance between center and top right corner
        d = center.dist(new PVector(x_max, y_min));
      }
      else if (center.y < y_max) {
        //distance between center and right side
        d = center.x-x_max;
      }
      else {
        //distance between center and bottom right corner
        d = center.dist(new PVector(x_max, y_max));
      }
    }    
    //println(j, i, d, x_min, x_max, y_min, y_max);
    
    return (d<radius);
  } 
  
  void render() {
    if (getShow()) {
      stroke(0,0,60);
      fill(0,0,60);
      circle(center.x, center.y, 2*radius);
    }
  }
   

}
