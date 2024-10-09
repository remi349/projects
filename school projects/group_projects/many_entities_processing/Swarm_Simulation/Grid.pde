/**
* Final Application Project, June 2022
* Télécom Paris
* Authors : Delhio Calves, Matthieu Carreau, Rémi Ducottet, Paul Triana
*
* Grid class: divides the simulation window into a grid which contains equal-sized meshes
*/

class Grid{
  int height_grid; //taille de la grille
  int width_grid;  //taille de la grille
  Mesh[][] boxes;  //les mailles de la grille
  float alpha = 4;  //coefficient alpha pour le poids dans le parcours de graphe
  float beta = 5; //beta = alpha + 1
  int numPath = 4;
  
  Grid(int height_grid,int width_grid){
    this.height_grid = height_grid;
    this.width_grid = width_grid;
    boxes = new Mesh[height_grid][width_grid]; 
    for (int i =0; i<height_grid; i++){
      for (int j=0;j<width_grid;j++){
        boxes[i][j]= new Mesh(this,i,j);
      }
    }
  }
  
  void run(PVector v, PVector pos) {
    render();
  }
  
  //Renvoie la maille d'indice i,j
  Mesh getMesh(int i, int j){
    return boxes[i][j];
  }
  
  //Renvoie la maille correspondante à une position (x,y)
  Mesh getMeshFromPos(float x, float y) {
    int i = floor(y/height*height_grid);
    int j = floor(x/width*width_grid);
    i = max(0, min(i, height_grid-1));
    j = max(0, min(j, width_grid-1));
    return getMesh(i,j);
  }
  
  //Renvoie la maille correspondante à une position pos
  Mesh getMeshFromPos(PVector pos) {
    return getMeshFromPos(pos.x, pos.y);
  }
  

  int getHeight(){
    return this.height_grid;
  }
  int getWidth(){
    return this.width_grid;
  }
  
  void render(){
    for (int l=0; l<height_grid;l++){
      for (int m=0; m<width_grid;m++){
        line(l*height/height_grid,m*width/width_grid,(l+1)*height/height_grid,m*width/width_grid);
        stroke(255,0,255);
        line(l*height/height_grid,m*width/width_grid,l*height/height_grid,(m+1)*width/width_grid);
        stroke(255,0,255);
        line(l*height/height_grid,(m+1)*width/width_grid,(l+1)*height/height_grid,(m+1)*width/width_grid);
        stroke(255,0,255);
        line((l+1)*height/height_grid,m*width/width_grid,(l+1)*height/height_grid,(m+1)*width/width_grid);
        stroke(255,0,255);
        textSize(10);
        //text(,(e.start.pos.x+e.end.pos.x)/2,(e.start.pos.y+e.end.pos.y)/2);*/
      }
    }
    
    // The next commented section can render a circle in each mesh, 
    // with the radius proportional to the number of walls in it
    
    for (int j =0; j< boxes.length; j++) {
      for (int i =0; i< boxes[0].length; i++) {
        Mesh box = boxes[i][j];
        if (box.obstacles.obstacles.size() >=1) {
          float x0 = (0.5+box.j)*width/width_grid;
          float y0 = (0.5+box.i)*height/height_grid;
          //float r = box.obstacles.obstacles.size();
          float r = 0;
          for (float d : box.wall_sizes) {
            r+=d;
          }
          stroke(0,50,100);
          fill(0,0,40);
          circle(x0, y0, r);
        }
      }
    }    
  }
  
  //Renvoie le facteur de poids d'une arête entre deux mailles correspondant aux obstacles présents
  float poidsObstacle(Mesh b) {
    float diag = sqrt(sq(height/height_grid)+sq(width/width_grid));
    float weight = 1;
    for (float t : b.wall_sizes) {
      weight += t;
    }
    weight = weight/diag;
    return weight;
  }
  
  //Renvoie le facteur de poids d'une arête entre deux mailles correspondant aux essaims voisins
  float poidsCluster(Mesh b) {
    if (b.boids.size() == 0) {
      return beta;
    } else {
      return 1;
    }
  }
  
  //Renvoie le facteur de poids d'une arête entre deux mailles correspondant à la direction de l'essaim
  float poidsOmega(Mesh a, Mesh b, PVector v) {
    PVector dir = new PVector((b.getY()-a.getY()),(b.getX()-a.getX()));
    dir.normalize();
    v.normalize();
    float weight = 1 + alpha*(1-PVector.dot(dir,v))/2;
    return weight;
  }
   
   //Renvoie le poids total à attribuer à une arête entre deux mailles pour la prédiction de trajectoire par parcours de graphe
   float poidsArete(Mesh a, Mesh b, PVector vel) {
     float weight;
     weight = poidsOmega(a,b, vel.copy())*poidsObstacle(b);
     return weight;
   } 
}
