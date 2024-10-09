class Trail extends FloatList {
  
  Trail() {
    super();
  }
  
  @Override
  float get(int i) {
    return super.get(Math.max(0, Math.min(i, size()-1)));
  }
  
}
