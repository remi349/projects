class Organism {
  
  ArrayList<Slime> slimes;
  Trail trail;
  int diffK = 3; // diffusion kenrel size
  float decayT = 0.01; //diffusion decay factor
  float wProj = 0.05; // pre-pattern stimuli projection weight

  
  Organism() {
    slimes = new ArrayList<Slime>();
    trail = new Trail();
    int size = width*height;
    for (int i = 0; i < size; i++) {
      trail.append(0);
    }
  }
  
  void addSlime(Slime slime) {
    slimes.add(slime);
    trail.set(int(slime.position.x)+int(slime.position.y)*height,1);
  }
  
  void run() {
    for (Slime slime : slimes) {
      slime.run(trail); 
    }
    diffuse();
    decay();
  }
  
  int getY(int i) {
    return (i-i%width)/width;
  }
  
  int getX(int i) {
    return i%width;
  }
  
  float mean(int i) {
    int x = getX(i);
    int y = getY(i);
    /*if ((x<width-1) && (x>0) && (y<height-1) && (y>0)) {
      return (trail.get(i) + trail.get(i+1) + trail.get(i - 1) + trail.get(i + width - 1) + trail.get(i+ width) + trail.get(i+ width + 1) + trail.get(i - width - 1) + trail.get(i- width) + trail.get(i- width + 1))/9;
    } else {
      return trail.get(i);
    }*/
    if (x==0) {
      if (y==0) {
        return (trail.get(i) + trail.get(i+1) + trail.get(i+width) + trail.get(i+width + 1))/4;
      } else if (y==height-1) {
        return (trail.get(i) + trail.get(i+1) + trail.get(i-width) + trail.get(i-width + 1))/4;
      } else {
        return (trail.get(i) + trail.get(i+1) + trail.get(i - width) + trail.get(i - width + 1) + trail.get(min(i+ width,width*height-1)) + trail.get(min(i+ width + 1,width*height-1)))/6;
      }
    } else if (x==width-1) {
      if (y==0) {
        return (trail.get(i) + trail.get(i-1) + trail.get(i + width) + trail.get(i + width - 1))/4;
      } else if (y==height-1) {
        return (trail.get(i) + trail.get(i-1) + trail.get(i-width) + trail.get(i-width - 1))/4;
      } else {
        return (trail.get(i) + trail.get(i-1) + trail.get(i - width) + trail.get(i - width - 1) + trail.get(i+ width) + trail.get(i+ width - 1))/6;
      }
    } else {
      if (y==0) {
        return (trail.get(i) + trail.get(i+1) + trail.get(i - 1) + trail.get(i + width - 1) + trail.get(i+ width) + trail.get(i+ width + 1))/6;
      } else if (y==height-1) {
        return (trail.get(i) + trail.get(i+1) + trail.get(i - 1) + trail.get(i - width - 1) + trail.get(i- width) + trail.get(i- width + 1))/6;
      } else {
        return (trail.get(i) + trail.get(i+1) + trail.get(i - 1) + trail.get(i + width - 1) + trail.get(i+ width) + trail.get(i+ width + 1) + trail.get(i - width - 1) + trail.get(i- width) + trail.get(i- width + 1))/9;
      }
    }
  }
  
  void diffuse() {
    Trail processedTrail = new Trail();
    for (int i = 0; i < trail.size(); i++) {
      processedTrail.append((7*trail.get(i)+2*mean(i))/9);
    }
    trail = processedTrail;
  }
  
  void decay(){
    for (int i = 0; i < trail.size(); i++) {
      trail.set(i, trail.get(i)-decayT);
    }
  }
  
}
