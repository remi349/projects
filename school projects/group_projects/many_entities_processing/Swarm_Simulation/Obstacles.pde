/**
* Final Application Project, June 2022
* Télécom Paris
* Authors : Delhio Calves, Matthieu Carreau, Rémi Ducottet, Paul Triana
*
* Ostacles class: represents a collection of obstacles which will be rendered in the simulation
*/

//Classe de la liste d'obstacles
class Obstacles {
  
  ArrayList<Obstacle> obstacles;
  
  Obstacles() {
    obstacles = new ArrayList<Obstacle>();
  }
  
  void run() {
    for (Obstacle w : obstacles) {
      w.run();
    }
  }
  
  void addObstacle(Obstacle o) {
    obstacles.add(o);
  }
}
