class Slime {
  
  PVector position;
  float angle;
  float speed = 1;
  float time = 1;
  
  float SA = 22.5*PI/180;
  float RA = 10*PI/180;
  int SO = 15;
  int SW = 1;
  int SS = 1;
  int depT = 5;
  float pCD = 0;
  float RR = 90*PI/180; //random rotation
  float sMin = 0;

  
  Slime(float x, float y, float angle) {
    position = new PVector(x,y);
    this.angle = angle;
  }
  
  
  void run(Trail trail) {
    update(trail);
    border();
    render(trail);
  }
  
  float sense(float angle, Trail trail) {
    PVector sensor = new PVector(position.x + SO*cos(angle), position.y + SO*sin(angle));
    return trail.get(max(0,min(int(sensor.x) + int(sensor.y)*width, height*width-1)));
  }
  
  void steer(Trail trail) {
    float F = sense(angle, trail);
    float FL = sense(angle + SA, trail);
    float FR = sense(angle - SA, trail);
    if ((F<FR) && (F<FL)) {
      if (random(-1,1) < 0) {
        angle += RA;
      } else {
        angle -= RA;
      }      
      //angle += random(-1,1)*RA;
    } else if (FL<FR) {
      angle -= RA;
    } else if (FR<FL) {
      angle += RA;
    } else {
      angle +=random(-RR,RR);
    }
  }
  
  void update(Trail trail) {
    steer(trail);
    PVector direction = new PVector(cos(angle), sin(angle));
    //direction.mult(speed*time);
    position =  position.add(direction);
  }
  
  void border() {
    if( (position.x < 0) || (position.x > width)) {
      position.x = min( width-1.01, max(0 , position.x));
      angle = PI-angle;
    } 
    if ((position.y < 0) || (position.y > height)) {
      position.y = min( height-1.01, max(0 , position.y));
      angle = -angle;
    }
  }
    
  void render(Trail trail) {
    int x = floor(position.x);
    int y = floor(position.y);
    trail.set(y*height + x, 1);
  }
  
}
