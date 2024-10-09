/**
* Final Application Project, June 2022
* Télécom Paris
* Authors : Delhio Calves, Matthieu Carreau, Rémi Ducottet, Paul Triana
*
* Wall class: represents a wall in the simulation, entities cannot pass through it
*/

class Wall extends Obstacle{
  
  PVector start;
  PVector end;
  
  //constructer, deux points représentant un segment, un boolean pour afficher le mur dans la simulation et le Grid associé 
  Wall(float xs, float ys, float xe, float ye, boolean show, Grid gr) {
    super(show, gr);
    end = new PVector(xe, ye); 
    start = new PVector(xs, ys); 
    addToMeshs();
  }
  
  //constructeur, par default show = true
  Wall(float xs, float ys, float xe, float ye, Grid gr) {
    super(true, gr);
    start = new PVector(xs, ys);
    end = new PVector(xe, ye); 
    addToMeshs();
  }
  
  //ajout le mur à une maille, utile pour l'algorithme de prédiction parcours de graphe
  void addToMeshs(){
    float mesh_width = width/this.grid.height_grid;
    float mesh_height = height/this.grid.width_grid;
    ArrayList<Mesh> meshList = new ArrayList<Mesh>();
    PVector start_pt = new PVector(start.x, start.y);
    Mesh mesh = this.grid.getMeshFromPos(start_pt.x, start_pt.y);
    Mesh end_mesh = this.grid.getMeshFromPos(end.x, end.y);
    meshList.add(this.grid.getMeshFromPos(start_pt.x, start_pt.y));
    
    while(mesh!=end_mesh && PVector.sub(start_pt, end).mag()>1) {
      PVector intersect = first_intersection(start_pt, end, mesh_width, mesh_height);
      mesh = this.grid.getMeshFromPos(intersect.x, intersect.y);
      meshList.add(mesh);
      mesh.wall_sizes.add(start_pt.dist(intersect));
      start_pt = intersect;
    }
    if (meshList.size()==1) {
      mesh.wall_sizes.add(start_pt.dist(end));
    }
    
    for (Mesh m : meshList) {
      m.obstacles.addObstacle(this);
    }
    
    
  }
  
  //Trouve la première intersection entre un obstacle Wall et une maille, utile pour déterminer la longueur d'un Wall présent dans une maille pour calculer la fonction du poids dans la prédiction par parcours de graphe.
  PVector first_intersection(PVector start, PVector end, float mesh_width, float mesh_heigth) {
    //Calculates the first intersection of the line with the grid
    
    
    float eps = 0.01;
    //first horizontaly
    float t_horizontal = 1;
    if (start.x>end.x) {
      float x_intersect = mesh_width*ceil(start.x/mesh_width-1);
      t_horizontal = (start.x-x_intersect)/(start.x-end.x);
    }
    else if (start.x<end.x) {
      float x_intersect = mesh_width*floor(start.x/mesh_width+1);
      t_horizontal = (start.x-x_intersect)/(start.x-end.x);
    }
    
    //then verticaly
    float t_vertical = 1;
    if (start.y>end.y) {
      float y_intersect = mesh_width*ceil(start.y/mesh_heigth-1);
      t_vertical = (start.y-y_intersect)/(start.y-end.y);
    }
    else if (start.y<end.y) {
      float y_intersect = mesh_width*floor(start.y/mesh_heigth+1);
      t_vertical = (start.y-y_intersect)/(start.y-end.y);
    }
    
    
    //take the first of both
    //println(t_vertical,t_horizontal);
    float t = min(t_vertical,t_horizontal);
    
    if (t+eps<1) {
      t += eps; //to make sure to go out of the mesh
      return PVector.mult(start,(1-t)).add(PVector.mult(end,t));
    }
    else return new PVector(end.x, end.y);
    
    
  }
  
  float norm() {
    return PVector.dist(start,end);
  }
  //Renvoie la distance minimale entre l'obstacle Wall et une agent de position pos et de direction dir
  PVector distance(PVector pos, PVector dir) {
    
    PVector q = new PVector();
    PVector l = new PVector();
    
    PVector.sub(pos,start,q);
    PVector.sub(end,start,l);
    float dot = q.dot(l);
    float norm = sq(l.mag());
    
    //float a = abs(pos.x - start.x);
    //float b = abs(pos.y - start.y);
    float c = end.x - start.x;
    float d = end.y -start.y;
    //float dot = a*d + b*c;
    //float len = c*c+d*d;
    float param=dot/norm;
    //println(param);
    if (param<0) {
      //line(pos.x, pos.y, start.x, start.y);
      return new PVector(pos.x-start.x, pos.y-start.y);
    } else if (param > 1) {
      //line(pos.x, pos.y, end.x, end.y);
      return new PVector(pos.x-end.x, pos.y-end.y);
    } else {
      PVector pop = new PVector( start.x + param*c,start.y + param*d);
      //println(pop.mag());
      return PVector.sub(pos, pop);
      //line(pos.x, pos.y, start.x + param*c, start.y + param*d);
    }
  }
  
  void run() {
    render();
  }
  
  void render() {
    if (getShow()) {
      stroke(0, 10, 100);
      line(start.x, start.y, end.x, end.y);
    } 
  }
}
