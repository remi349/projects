/**
* Final Application Project, June 2022
* Télécom Paris
* Authors : Delhio Calves, Matthieu Carreau, Rémi Ducottet, Paul Triana
*
* Obstacle class: represents an obstacle which will have a repulsive effet on the entities
*/

//Classe abstraite mère des classes Wall et Circle
abstract class Obstacle {
  
  boolean show;
  Grid grid;
  
  Obstacle(boolean show, Grid gr) {
    this.show = show;
    this.grid = gr;
    
  }
  
  boolean getShow() {
    return show;
  }
  
  abstract void run();
  abstract void render();
  abstract PVector distance(PVector pos, PVector dir);
}
