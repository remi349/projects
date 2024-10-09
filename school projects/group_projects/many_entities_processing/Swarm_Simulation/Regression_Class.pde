/**
* Final Application Project, June 2022
* Télécom Paris
* Authors : Delhio Calves, Matthieu Carreau, Rémi Ducottet, Paul Triana
*
* Regression class: a regression approximates a trajectory by a polynomial of a given degree minimizing the error between the studied trajectory and this polynomial
*/

import pallav.Matrix.*;

class Regression {
  
  FloatList yn; //Liste de coeff X des points
  FloatList xn; //Liste de coeff Y des points
  int nmax; //nombre max d'itérations pour l'alogrithme du gradient
  float alpha; //pas d'apprentissage pour l'algorithme du gradient
  float rmin; //coefficient de détermination min
  float r; //coefficient de détermination 
  int degree; //degré du polynôme qu'on souhaite obtenir dans la régression polynomiale
  
  Regression(FloatList yn, FloatList xn, int nmax, float alpha, float rmin, int degree) {
    this.yn = yn;
    this.xn =xn;
    this.nmax = nmax;
    this.alpha = alpha;
    this.rmin = rmin;
    this.degree = degree;
  }
  
  //Renvoie le polynôme à partir de la régression polynomiale matricielle
  Polynome PolyRegMatrix() {
    int n = xn.size();
    float max = xn.max();
    float xmin = xn.min();
    FloatList x = new FloatList();
    //FloatList x = xn.copy();
    float[][] y = new float[n][1];
    float ymin = yn.min();
    for (int i = 0; i<n; i++) {
      y[i][0] = (yn.get(i)-ymin)/max; 
      x.append((xn.get(i)-xmin)/max); 
      //y[i][0] = yn.get(i);
    }
    Matrix v = vandermondeInverse(x);
    /*print(Matrix.dimensions(v)[0]);
    print(Matrix.dimensions(v)[1]);
    print(Matrix.dimensions(Matrix.array(y))[0]);
    println(Matrix.dimensions(Matrix.array(y))[1]);*/
    Matrix beta = Matrix.Multiply(v,Matrix.array(y));
    FloatList a = new FloatList();
    for (int j = 0; j<n; j++) {
      a.append(beta.array[j][0]);
    }
    //this.r = r;
    //Polynome normalizedPoly = new Polynome(a);
    //println(a);
    //println();
    for (int i=0; i<n; i++) {
      if (i==0) {
        a.mult(0,max);
      } else if (i==1) {
        
      } else {
        //print(max);
        //println(pownum(i-1,max));
        //println(pownum(i-1,max));
        a.div(i-1,pownum(i,max));
      }
    }
    //a.add(0,ymin);
    //println(a);
    Polynome normalizedPoly = new Polynome(a);
    return normalizedPoly;
  }
  
  //Renvoie le polynôme pour un régression quadratique
  Polynome QuadReg() {
    //println("let's go !");
    float max = xn.max();
    //max = 1;
    FloatList x = normalize(xn, max);
    //println(x);
    FloatList y = normalize(yn, max);
    //println(y);
    float a0 = 0;      
    float a1 = 0;      
    float a2 = 0;
    float r = 0;       //coefficient of determination (R**2)
    float rss;         // residual sum of squares
    float cost_func0;  //first coordinate of cost function
    float cost_func1;  //second coordinate of cost function
    float cost_func2;
    //float partial_d0;  //partial derivative of cost function in respect to a0;
    //float partial_d1;  //partial derivative of cost function in respect to a1;
    FloatList H;       //y values from linear function
    
    //FloatList error = new FloatList();
    
    int n = y.size();
    H = new FloatList(n);
    float yvar = variance(y);
    int k = 0;
    while ((k<nmax) && (r<rmin)) {
      rss = 0;     
      cost_func0 = 0;
      cost_func1 = 0;
      cost_func2 = 0;
      for (int j = 0; j<n; j++) {
        cost_func0 += a0 + a1*x.get(j)+a2*x.get(j)*x.get(j)-y.get(j);
        //println(cost_func0);
        cost_func1 += x.get(j)*(a0 + a1*x.get(j)+a2*x.get(j)*x.get(j)-y.get(j));
        cost_func2 += x.get(j)*x.get(j)*(a0 + a1*x.get(j)+a2*x.get(j)*x.get(j)-y.get(j));
      }        
      //println(cost_func0);
      a0 = a0-2*alpha*cost_func0/n;
      a1 = a1-2*alpha*cost_func1/n;
      a2 = a2-2*alpha*cost_func2/n;
      //println();
      //println(a1);
      //println();
      for (int i = 0; i<n; i++) {
        H.set(i,a0 + a1*x.get(i)+a2*x.get(i)*x.get(i));
        rss += (y.get(i)-H.get(i))*(y.get(i)-H.get(i));
      }  
      r = 1-rss/yvar;
      //println(r);
      k++;
    }
    this.r = r;
    FloatList coeff = new FloatList();
    coeff.append(max*a0);
    coeff.append(a1);
    coeff.append(a2/max);
    return new Polynome(coeff);
  }
  
  //Renvoie le polynôme pour un régression linéaire
  PVector LinReg() {
    //println("let's go !");
    float max = xn.max();
    FloatList x = normalize(xn, max);
    //println(x);
    FloatList y = normalize(yn, max);
    //println(y);
    float a0 = 0;      //initial parameter (value at zero)
    float a1 = 0;      //initial parameter (slope)
    float r = 0;       //coefficient of determination (R**2)
    float rss;         // residual sum of squares
    float cost_func0;  //first coordinate of cost function
    float cost_func1;  //second coordinate of cost function
    //float partial_d0;  //partial derivative of cost function in respect to a0;
    //float partial_d1;  //partial derivative of cost function in respect to a1;
    FloatList H;       //y values from linear function
    
    //FloatList error = new FloatList();
    
    int n = y.size();
    H = new FloatList(n);
    float yvar = variance(y);
    int k = 0;
    while ((k<nmax) && (r<rmin)) {
      rss = 0;     
      cost_func0 = 0;
      cost_func1 = 0;
      for (int j = 0; j<n; j++) {
        cost_func0 += a0 + a1*x.get(j)-y.get(j);
        //println(cost_func0);
        cost_func1 += x.get(j)*(a0 + a1*x.get(j)-y.get(j));
      }        
      //println(cost_func0);
      a0 = a0-2*alpha*cost_func0/n;
      a1 = a1-2*alpha*cost_func1/n;
      //println();
      //println(a1);
      //println();
      for (int i = 0; i<n; i++) {
        H.set(i,a0+a1*x.get(i));
        rss += (y.get(i)-H.get(i))*(y.get(i)-H.get(i));
      }  
      r = 1-rss/yvar;
      //println(r);
      k++;
    }
    this.r = r;
    return new PVector(max*a0,a1,r);
  }
  
  //Renvoie le polynôme pour un régression polynomiale de degré quelconque, dans ce cas degré est la variable définie au début de la classe
  Polynome PolyRegCost() {
    //println("let's go !");
    int m = degree+1;
    int n = xn.size();
    float max = xn.max();
    FloatList x = normalize(xn, max);
    FloatList y = normalize(yn, max);
    FloatList a = new FloatList();      //initial polynomail coefficients
    for (int i=0; i<m; i++) {
      a.append(0);
    }
    float r = 0;       //coefficient of determination (R**2)
    float rss;         // residual sum of squares
    FloatList cost_func = new FloatList(m);  //n coordinates of cost function
    FloatList H;       //y values from linear function
    H = new FloatList(n);
    float yvar = variance(y);
    int k = 0;
    while ((k<nmax) && (r<rmin)) {
      rss = 0;     
      for (int i=0; i<m; i++) {
        cost_func.set(i,0);
      }
      for (int j = 0; j<n; j++) {
        for (int i = 0; i<m; i++) {
          cost_func.add(i,costDerivative(a,x.get(j),y.get(j))*pownum(i,x.get(j)));
        }
      }        
      //println(cost_func0);
      for (int i = 0; i<m; i++) {
          a.add(i,-2*alpha*cost_func.get(i)/n);
      }
      for (int i = 0; i<n; i++) {
        H.set(i,costDerivative(a,x.get(i),0));
        rss += (y.get(i)-H.get(i))*(y.get(i)-H.get(i));
      }  
      r = 1-rss/yvar;
      k++;
    }
    this.r = r;
    //print(a);
    //println();
    for (int i=0; i<m; i++) {
      if (i==0) {
        a.mult(0,max);
      } else if (i==1) {
        
      } else {
        float b = a.get(i)/(pownum(i-1,max));
        a.set(i,b);
      }
    }
    //println(a);
    Polynome normalizedPoly = new Polynome(a);
    return normalizedPoly;
  }
  
  //fonction puissance
  float pownum(int i, float x){
    float pow = 1;
    for (int j=0; j<i; j++) {
      pow = pow*x;
    }
    return pow;
  }
   
  //Renvoie la valeur de la dérivée partielle de la fonction de coût
  float costDerivative(FloatList a, float x , float y) {
    float sum = -y;
    int m = a.size();
    for (int i=0; i<m; i++) {
      /*println();
      println(a.get(i));
      println(x);
      println(i);
      println(pownum(i,x));
      println();*/
      sum += a.get(i)*pownum(i,x);
    }
    return sum;
  }
  
  //Somme d'une FloatList
  float sum(FloatList X) {
    float sum = 0;
    for (float x : X) {
      sum += x; 
    }
    return sum;
  }
  
  //Renvoie la moyenne d'une FloatList
  float mean(FloatList X) {
    return sum(X)/X.size();
  }
  
  //Renvoie la variance d'une FloatList
  float variance(FloatList X) {
    return sum(sqAll(mathAll(X,1,-mean(X))));
  }
  
  //Multiplie et additione un scalaire à tous les éléments d'une FloatList
  FloatList mathAll(FloatList X, float a, float b) {
    FloatList Y = X.copy();
    int n = X.size();
    for (int i = 0; i<n; i++) {
      Y.set(i, a*X.get(i) + b);
    }
    return Y;
  }
  
  //Met au carré tous les éléments d'une FloatList
  FloatList sqAll(FloatList X) {
    FloatList Y = X.copy();
    int n = X.size();
    for (int i = 0; i<n; i++) {
      Y.set(i, sq(X.get(i)));
    }
    return Y;
  }
  
  //Normalise une FloatList par x
  FloatList normalize(FloatList X, float x) {
    return mathAll(X.copy(),1/x,0);
  }
  
  //Renvoie la matrice de Vandermonde
  Matrix vandermonde(FloatList X) {
    int n = X.size();
    float[][] v = new float[n][n];
    for (int i = 0; i<n; i++) {
      for (int j = 0; j<n-1; j++) {
        v[i][j] = pow(X.get(i),j);;
      }
    }
    return Matrix.array(v);
  }
  
  //Renvoie l'inverse de la matrice de Vandermonde
  Matrix vandermondeInverse(FloatList X) {
    Matrix v = vandermonde(X);
    Matrix u = inverseU(X);
    Matrix l = inverseL(X);
    return Matrix.Multiply(u,l);
  }
  
  //Renvoie la matrice L-1 dans le méthode d'inverse de Vandermonde (voir les références dans le rapport)
  Matrix inverseL(FloatList X) {
    int n = X.size();
    float[][] l = new float[n][n];
    for (int i=0; i<n; i++) {
      for (int j=0; j<n; j++) {
        if ((i==1) && (j==1)) {
          l[i][j] = 1;
        } else if (i<j) {
          l[i][j] = 0;
        } else {
          l[i][j] = 1;
          for (int k=0; k<i; k++) {
            if (!(k==j)) {
              l[i][j] = l[i][j]/(X.get(j)-X.get(k));
            }
          }
        }
      }
    }
    return Matrix.array(l);
  }
  
  //Renvoie la matrice U-1 dans le méthode d'inverse de Vandermonde (voir les références dans le rapport)
  Matrix inverseU(FloatList X) {
    int n = X.size();
    float[][] u = new float[n][n];
    for (int i=0; i<n; i++) {
      for (int j=0; j<n; j++) {
        if ((i==1) && (j==1)) {
          u[i][j] = 1;
        } else if (i<j) {
          u[i][j] = 0;
        } else {
          u[i][j] = 1;
          for (int k=0; k<i; k++) {
            if (!(k==j)) {
              u[i][j] = u[i][j]/(X.get(j)-X.get(k));
            }
          }
        }
      }
    }
    return Matrix.array(u);
  }
  
}
