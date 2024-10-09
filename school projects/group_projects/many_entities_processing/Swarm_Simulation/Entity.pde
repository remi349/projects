/**
* Final Application Project, June 2022
* Télécom Paris
* Authors : Delhio Calves, Matthieu Carreau, Rémi Ducottet, Paul Triana
*
* Boid class: represents an entity in the simulation, interacts with its neighbours and its environment,
* its movements are ruled by different types of forces that apply on it
*/




class Boid {
  
  PVector position; //position
  PVector velocity; //speed 
  PVector acceleration; //acceleration
  float r; //radius of the agent, useful for the borders conditions of the simulation
  float neighbordist; //observation radius, the agent's behaviour can be influenced by other agents if they are closer than this distance
  float maxforce;    //maximum steering force
  float maxspeed;    //maximum speed
  float hue; //agent's color
  int trailLength; //length of the agent's trail
  ArrayList<PVector> trail; //positions of the agent's trail
  ArrayList<Boid> neighbors; //agent's neighbours
  ArrayList<Float> neighbors_dist; //distance to neighbours
  Mesh mesh; //the mesh in which the agent is located
  Grid grid; //the grid
  boolean periodic; //boolean to determine whether the simulation environment is periodic or closed
  int clusterId; //unique identier of the agent's swarm
  int self_id; //agent's unique identifier
  
  //The agent's constructor
  Boid(float x, float y, Grid gr, float neighbordistance, int id) {
    hue = 0; //random(100);
    periodic = false;
    trailLength = 50;
    //need_to_recluster_flag = false;
    self_id = id;
    acceleration = new PVector(0, 0);
    clusterId = -1; // not in a cluster

    // This is a new PVector method not yet implemented in JS
    // velocity = PVector.random2D();

    // Leaving the code temporarily this way so that this example runs in JS
    float angle = random(TWO_PI);
    velocity = new PVector(cos(angle), sin(angle));

    position = new PVector(x, y);
    r = 1.0;
    maxspeed = 2;
    maxforce = 0.03;
    neighbordist = neighbordistance;
    
    trail = new ArrayList<PVector>();
    trail.add(new PVector(x,y));
    for (int j = 1; j < trailLength; j++) {
      trail.add(new PVector(0,0));
    }
    grid = gr;
    mesh = grid.getMesh(0,0);
    this.updateMesh();
    updateNeighbors();
  }
  

  void run(ArrayList<Boid> boids, ArrayList<Obstacle> obstacles) {
    //need_to_recluster_flag = false;
    flock(boids, obstacles);
    update();
    borders();
    render();
  }
 
  //Apply the force to agent's acceleration
  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  // We accumulate a new acceleration each time based on three rules
  void flock(ArrayList<Boid> boids, ArrayList<Obstacle> obstacles) {
    updateNeighbors();
    //updateHue(boids);
    PVector sep = separate();   // Separation
    PVector ali = align();      // Alignment
    PVector coh = cohesion();   // Cohesion
    PVector col = collision(obstacles);  // Collision
    // Arbitrarily weight these forces
    sep.mult(1.0);
    ali.mult(1.0);
    coh.mult(1.0);
    col.mult(1.5);
    // Add the force vectors to acceleration
    
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
    applyForce(col);
  }
  
  PVector copy(PVector p) {
    return new PVector(p.x, p.y);
  }

  //Updates the trail
  void updateTrail(PVector pos) {
    trail.remove(0);
    trail.add(copy(pos));
  }
  
  // Method to update position
  void update() {
    float dt = 0.1;
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    borders();
    position.add(velocity);
    // Reset acceleration to 0 each cycle
    acceleration.mult(0);
    updateTrail(position);
    updateMesh();
  }

  // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, position);  // A vector pointing from the position to the target
    // Scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);

    // Above two lines of code below could be condensed with new PVector setMag() method
    // Not using this method until Processing.js catches up
    // desired.setMag(maxspeed);

    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    return steer;
  }

  //Draws the agent and its trail
  void render() {
    
    
    // Draws a triangle rotated in the direction of velocity
    float theta = velocity.heading2D() + radians(90);
    // heading2D() above is now heading() but leaving old syntax until Processing.js catches up
    
    color c ;
    c = color(this.hue, 100, 100);
    stroke(c);
    fill(c);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
    
    //draw trail
    noStroke();
    //pushMatrix();
    for (int k = 0; k < trailLength; k++) {
      PVector p = trail.get(k);
      //translate(p.x,p.y);
      fill(hue,100,floor(k*100/trailLength));
      //fill(hue,floor(k*100/trailLength),100);
      circle(p.x, p.y, r);
    }
  }

  // Separation
  // Method checks for nearby boids and steers away
  PVector separate () {
    float desiredseparation = 25.0f;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    // For every boid in the neighborhood, check if it's too close
    for (Boid other : neighbors) {
      float d = neighbors_dist.get(neighbors.indexOf(other));
      // If the distance is less than an arbitrary amount 
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(position, other.position);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
      // First two lines of code below could be condensed with new PVector setMag() method
      // Not using this method until Processing.js catches up
      // steer.setMag(maxspeed);

      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Alignment
  // For every nearby boid in the system, calculate the average velocity
  PVector align () {
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Boid other : neighbors) {
      sum.add(other.velocity);
      count++;
      
    }
    if (count > 0) {
      sum.div((float)count);
      // First two lines of code below could be condensed with new PVector setMag() method
      // Not using this method until Processing.js catches up
      // sum.setMag(maxspeed);

      // Implement Reynolds: Steering = Desired - Velocity
      sum.normalize();
      sum.mult(maxspeed);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      return steer;
    } 
    else {
      return new PVector(0, 0);
    }
  }

  // Cohesion
  // For the average position (i.e. center) of all nearby boids, calculate steering vector towards that position
  PVector cohesion () {
    PVector sum = new PVector(0, 0);   // Start with empty vector to accumulate all positions
    int count = 0;
    for (Boid other : neighbors) {
      sum.add(other.position); // Add position
      count++;
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);  // Steer towards the position
    } 
    else {
      return new PVector(0, 0);
    }
  }
  
  // Collision
  // Each wall forces the boid away within an arbitriary range
  PVector collision (ArrayList<Obstacle> obstacles) {
    float desiredcollisionavoidance = 70.0f;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    float coeff = 1;
    float urgent = 1;
    int n = 1;
    // For every boid in the system, check if it's too close
    for (Obstacle other : obstacles) {
      PVector diff = other.distance(position, velocity);
      float d = diff.mag();
      //print("so...  ");
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredcollisionavoidance)) {
        //println("force");
        // Calculate vector pointing away from neighbor
        diff.normalize();
        diff.mult(coeff*((desiredcollisionavoidance/(n*d)) - (1/(n+3))));
        //diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;  // Keep track of how many
        //urgent = 1;
        if (d < 6) {
          urgent = 9;
        }
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
      // First two lines of code below could be condensed with new PVector setMag() method
      // Not using this method until Processing.js catches up
      // steer.setMag(maxspeed);

      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce*coeff);
      steer.mult(urgent);
    }
    return steer;
  }
  
  // 'Walls' ; the boids will glance off of it they hit them
 void borders() {  
   if (periodic) { 
     if (position.x < -r) position.x = width+r;
     if (position.y < -r) position.y = height+r;
     if (position.x > width+r) position.x = -r;
     if (position.y > height+r) position.y = -r;
   } else {
    if ((position.x < 0)) {
     velocity.x = velocity.x * -1;
     position.x = 1;
    } else if (position.x > width) {
      velocity.x = velocity.x * -1;
     position.x = width - 1;
    }
    if ((position.y < 0)) {
      velocity.y = velocity.y * -1;
      position.y = 1;
    } else if (position.y > width) {
      velocity.y = velocity.y * -1;
      position.y = width - 1;
      }
    }
  } 
  
  //Group color
  float calcHue (ArrayList<Boid> boids) {
    PVector sum = new PVector(0,0);   
    int count = 0 ;
    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < neighbordist)) {
        float x = cos(other.hue/100*TWO_PI) ;
        float y = sin(other.hue/100*TWO_PI) ;
        sum.add(new PVector(x,y)) ; // Add color member to vector
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      float angle = sum.heading();
      float mean = (angle/(TWO_PI))*100 ;
      float offset = -(this.hue - mean) ;
      if (offset < - 50){
        offset += 100 ;
      }
      else if (offset > 50){
        offset -= 100 ;
      }
      return sum.mag()*0.1*offset;
    }
    else {
      return 0 ;
    }
  }
  
  //Updates the color of a group
  void updateHue(ArrayList<Boid> boids){
    hue += calcHue(boids);
  //  hue+=random(5)-2.5;
    if (hue < 0){
      hue += 100;
    }
    if (hue > 100){
      hue -= 100;
    }
  }
 

//update the boids neighbors using a grah
  void updateNeighbors(){
   neighbors = new ArrayList<Boid>();
   ArrayList<Mesh> meshNeighbors = this.mesh.getNeighbors();
   neighbors_dist = new ArrayList<Float>();
   for (Mesh meshNear : meshNeighbors){
     for (Boid b : meshNear.boids){
      float d = PVector.dist(position, b.position);
      if ((d > 0) && (d < neighbordist)) {
        neighbors.add(b);
        neighbors_dist.add(d);
      }
     }
   }
 }
 
 //Updates the grid
 void updateMesh(){
    int self_index = mesh.boids.indexOf(this);
    if(self_index != -1) mesh.boids.remove(self_index);
    this.mesh = grid.getMeshFromPos(position.x,position.y);
    mesh.boids.add(this);
  }
}
