/**
* Final Application Project, June 2022
* Télécom Paris
* Authors : Delhio Calves, Matthieu Carreau, Rémi Ducottet, Paul Triana
*
* Polynome class: a polynomial is represented by its coefficients, and is used to implement the regression method
*/

public class Polynome {
  
  FloatList coeff;
  
  void print() {
    println(coeff);
  }
  
  Polynome(FloatList coeff) {
    this.coeff = coeff;
  }
  
  Polynome() {
    coeff = new FloatList();
  }
  
  Polynome(int d) {
    coeff = new FloatList();
    for (int i=0; i<d+1; i++) {
      coeff.append(0);
    }
  }
  
  FloatList getCoeff() {
    return coeff;
  }
  
  void changeCoeff(int i, float x) {
    coeff.set(i, x);
  }
  
  void multCoeff(int i, float x) {
    coeff.mult(i, x);
  }
  
  void divCoeff(int i, float x) {
    coeff.div(i, x);
  }
  
  void addCoeff(int i, float x) {
    coeff.add(i, x);
  }
  
  void copyCoeff(Polynome p) {
    FloatList coeffp = p.getCoeff();
    coeff = coeffp;
  }
  
  int deg() {
    return coeff.size()-1;
  }
  
  void addCoeff(float a) {
    coeff.append(a);
  }
  
  float coeff(int k) {
    int n = deg();
    if (k<n+1){
      return coeff.get(k);
    } else {
      return 0;
    }
  }
  
  float power(float x, int n) {
    float power = 1;
    for (int i=0; i<n; i++) {
      power = power*x;
    }
    return power;
  }
  
  float f(float x) {
    float sum = 0;
    int n = deg();
    for (int i=0; i < n+1; i++) {
      sum += coeff.get(i)*power(x, i);
    }
    return sum;
  }
  
  Polynome mult(Polynome p) {
    int n = deg();
    int m = p.deg();
    Polynome produit = new Polynome();
    float c;
    for (int k=0; k<n+m+1; k++) {
      c=0;
      for (int j=0; j<k+1; j++) {
        c+=coeff(j)*p.coeff(k-j);
      }
      produit.addCoeff(c);
    }
    return produit;
  }
  
  void mult(float a) {
    for (int i =0; i<deg()+1; i++) {
      coeff.mult(i, a);
    }
  }
  
  Polynome lin(float x) {
    Polynome p = new Polynome();
    p.addCoeff(1);
    p.addCoeff(-x);
    return p;
  }
  
  Polynome add(Polynome p) {
    Polynome sum = new Polynome();
    for (int i=0; i<max(deg()+1, p.deg()+1); i++) {
        sum.addCoeff(coeff(i)+p.coeff(i));
    }
    return sum;
  }
}

class Lagrange extends Polynome {
  
  FloatList Y;
  FloatList X;
  
  Lagrange(FloatList X, FloatList Y) {
    
    super();
    this.X = X;
    this.Y = Y;
    int d = X.size();
    Polynome p = new Polynome(d);
    for (int i=0; i<d; i++) {
      Polynome y = pLag(i);
      y.mult(Y.get(i));
      p = p.add(y);
    }
    copyCoeff(p);
  }
  
  Polynome pLag(int i) {
    Polynome p = new Polynome();
    int n = X.size();
    p.addCoeff(1);
    for (int j=0; j<n; j++) {
      if (!(i==j)) {
        p = p.mult(lin(X.get(j)));
        p.mult(1/(X.get(i)-X.get(j)));
      }  
    }
    return p;
  }
  
}
