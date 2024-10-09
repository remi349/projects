/**
* Final Application Project, June 2022
* Télécom Paris
* Authors : Delhio Calves, Matthieu Carreau, Rémi Ducottet, Paul Triana
*
* Clustering class: its role is to identify the different clusters of entities every 50 frames
*/

import grafica.*; 

class Clustering {
  
  static final boolean print_clustering_events = false;
  
  boolean[] visited; 
  float [][] distMatrix;
  int N; // number of boids
  int nb_clusters; // number of cluster
  ArrayList<Cluster> clusters;
  ArrayList<ArrayList<Float[]>> regPol;
  int sizeValidityPolinomialRegression = 10;//size where we are going to plot the regression
  int t0;//time

  ArrayList<Float> hues = new ArrayList<Float>();  
  //GPlot plot;


  
  Clustering() { 
    for (int i = 0; i<15; i++) {
      getHueFromIndex(i);
    }
    println();
    clusters = new ArrayList<Cluster>();

  }
  
  void find(ArrayList<Boid> boids) {
    
    //Initialize variables
    N = boids.size();
    int clusters_found = 0; // number of clusters found this time
    // for each index i, matching table will contain the index of 
    // the main origin cluster of the boids in the cluster i just found
    ArrayList<Integer> matching_table = new ArrayList<Integer>(); 
    // for each old cluster index i, 'nb_new_clusters_from_old'
    // contains the number of new clusters 
    // in which it is the main origin of boids
    int [] nb_new_clusters_from_old = new int[nb_clusters];
    int nb_isolated = 0;
    
    visited = new boolean[N]; 
    ArrayList<Cluster> new_cluster_list = new ArrayList<Cluster>();
    
    for (int b = 0; b<N; b++) {
      if(!visited[b]) {
        //int nb_boids = 1;
        Cluster new_cluster = new Cluster(new ArrayList<Boid>());
        ArrayList<Integer> toCheck = new ArrayList<Integer>();
        //counter counts among the boids found the number that were in each old 
        //clusters (index nb_clusters for -1), in order to fill the matching table
        int[] counter = new int[nb_clusters+1]; 
        visited[b] = true;
        toCheck.add(b);
        new_cluster.add(boids.get(b));
        
        if (boids.get(b).clusterId == -1) counter[nb_clusters]++;
        else counter[boids.get(b).clusterId]++;
        
        while (toCheck.size()>0) {
          //Check if there are neighbours to add to the cluster
          int k = toCheck.get(0); // first boid to visit
          for(Boid neighbor : boids.get(k).neighbors) {
             int n = neighbor.self_id;
             if (!visited[n]) { 
               //Add a condition about the distance ?
               //(more restrictive than the one used for behavior
               toCheck.add(n);
               visited[n] = true;
               //cluster[n] = nb_clusters;
               //boids.get(n).clusterId = nb_clusters;
               new_cluster.add(boids.get(n));
               //nb_boids++;
               if (boids.get(n).clusterId == -1) counter[nb_clusters]++;
               else counter[boids.get(n).clusterId]++;
             }
          }
          toCheck.remove(0);
        }
        
        if (new_cluster.boids.size()>1) {
            new_cluster_list.add(new_cluster);
            //search the most representated old cluster
            int cluster_max = nb_clusters; //index of the most representated
            int max_boids = 0;
            for (int i = 0; i<nb_clusters+1; i++) {
              if (counter[i] > max_boids) {
                cluster_max = i;
                max_boids = counter[i];
              }
            }
            
            if (cluster_max == nb_clusters) { 
              //most of the boids didn't have clusters
              matching_table.add(-1);
            }
            else {
              nb_new_clusters_from_old[cluster_max] ++;
              matching_table.add(cluster_max);
              }
        clusters_found ++;
        }
        else { 
          boids.get(b).clusterId = -1;
          nb_isolated ++;
        }
      }
        
      
    }
    //match the new and old clusters
    //first, we look for new clusters where boids were mainly not assigned
    for (int i = 0; i< clusters_found; i++) {
      if (matching_table.get(i)==-1) {
        //create a cluster
        new_cluster_list.get(i).id = nb_clusters;
        clusters.add(new_cluster_list.get(i));
        for (Boid b : new_cluster_list.get(i).boids) {
          //set the clusterId
          b.clusterId = nb_clusters;
        }
        hues.add(getHueFromIndex(nb_clusters));
        nb_clusters++;
        
      }
    }
    
    //then we look for the clusters that have splitted
    for (int o = 0; o< nb_new_clusters_from_old.length; o++) {
      if (nb_new_clusters_from_old[o]>1) {
        //old cluster 'o' has splitted in at least two parts
        //we search which of the parts contains the most boids
        ArrayList<Integer> indexes_of_new = new ArrayList<Integer>();
        int index_of_max = 0;
        int max_boids = 0;
        for (int n = 0; n<clusters_found; n++) {
          if (matching_table.get(n) == o) {
            indexes_of_new.add(n);
            if (new_cluster_list.get(n).boids.size()>max_boids) 
              index_of_max = n;
              max_boids = new_cluster_list.get(n).boids.size();
          }
        }
        
        if (print_clustering_events) {
          println("Cluster ",o, " splitted in ", indexes_of_new);
          println(index_of_max);
        }
        //update the original cluster
        clusters.get(o).boids = new_cluster_list.get(index_of_max).boids;
        for (Boid b : clusters.get(o).boids) {
          b.clusterId = o;
        }
        
        //create the new clusters
        for (int i : indexes_of_new) {
          if (i!=index_of_max) {
            //create a cluster
            new_cluster_list.get(i).id = nb_clusters;
            clusters.add(new_cluster_list.get(i));
            for (Boid b : new_cluster_list.get(i).boids) {
              //set the clusterId
              b.clusterId = nb_clusters;
            }
            hues.add(getHueFromIndex(nb_clusters));
            nb_clusters++;
          }
          
          if (print_clustering_events) {
            println("split cluster ",i, " contains ", new_cluster_list.get(i).boids.size());
          }
        }
      }
      
    }
    
    //Then we look for clusters that are still here
    for (int o = 0; o< nb_new_clusters_from_old.length; o++) {
      if (nb_new_clusters_from_old[o]==1) {
        //Cluster o is still here (maybe with some new boids)
        //update the original cluster
        clusters.get(o).boids = new_cluster_list.get(matching_table.indexOf(o)).boids;
        for (Boid b : clusters.get(o).boids) {
          b.clusterId = o;
        }
      }
    }
    
    //Finally, we look for clusters that have merged into another one
    for (int o = 0; o< nb_new_clusters_from_old.length; o++) {
      if (nb_new_clusters_from_old[o]==0 && clusters.get(o).boids.size()>0) { 
        //the second condition avoids considering old_clusters that are already empty
        //cluster o has merged in another cluster
        //we find which one it is by looking the main new 
        //cluster of its old boids
        int [] nb_boids_in_new = new int[nb_clusters];
        for (Boid b : clusters.get(o).boids) {
          if (b.clusterId>=0) nb_boids_in_new[b.clusterId]++;
        }
        int main_cluster = 0;
        int max_boids = 0;
        for (int n = 0; n<nb_clusters; n++) {
          if (nb_boids_in_new[n] > max_boids) {
            max_boids = nb_boids_in_new[n] ;
            main_cluster = n;
          }
        }
        clusters.get(o).boids = new ArrayList<Boid>();
        
        if (print_clustering_events) {
          println("Merge ! Cluster ",o, " has joined cluster ",main_cluster);
        } 
      }
    }
    
    if (print_clustering_events) {
      print("Clustering done, found : ");
      print(nb_clusters);
      print(" clusters and ");
      print(nb_isolated);
      print(" boids isolated for a total of ");
      print(boids.size());
      println(" boids.\n");
      
      
      for (int c = 0; c<clusters.size(); c++) {
        print("Cluster number ");
        print(c);
        print(" contains ");
        print(clusters.get(c).boids.size());
        print(" boids.");
        println();
      }
    }
  }
   
 String listPositions(String date){
   // Writes the positions of the trails in a csv file
   ArrayList<ArrayList<Float[]>> values = new ArrayList<ArrayList<Float[]>>();// position [x,y,t] of the different clusters
   for (Cluster c : this.clusters){
     ArrayList<PVector> vec = c.centertrail;
     ArrayList<Float[]> pos = new ArrayList<Float[]>();
     for (int i=0; i<vec.size();i++){
       Float[] xyt = new Float[3];
       xyt[0]=vec.get(i).x;
       xyt[1]=height - vec.get(i).y;
       xyt[2]=(float)c.frameCounts.get(i);
       pos.add(xyt);       
     }
     values.add(pos);
   }
   Table table = new Table();
   for (int i=0; i<values.size()*3;i++){
     table.addColumn(floor(i/3) + "_" + i%3);
   }
   int maxLength = this.getBiggestTrail();
   for (int j=0;j<maxLength;j++){//loop on the lines
     TableRow newRow =table.addRow();
     for (int i=0; i<values.size()*3;i++){//loop on the columns
       if (j<values.get(floor(i/3)).size()){
         newRow.setFloat(floor(i/3)+"_"+i%3, values.get(floor(i/3)).get(j)[i%3]);
       }
     }
   }
   
   String filename = "csv/deplacement_"+date+".csv";
   saveTable(table, filename);
   return filename;
 }//eache column is named "number of group"_"(0 if x, 1 if y, 2 if z) 
 
    String listHues(String date){
   // Writes the clusters' colors of the trails in a csv file
   Table table = new Table();
   table.addColumn("color");
   for (int i = 0 ; i<hues.size() ; i++){
     TableRow newRow =table.addRow();
     newRow.setFloat("color",hues.get(i));
   }
   String filename = "csv/hues_";
   filename += date;
   filename += ".csv";
   saveTable(table, filename);
   return filename;
 }

 //return the size of the biggest tail
 int getBiggestTrail(){
   int n=0;
   for (Cluster c : this.clusters){
     int m=c.centertrail.size();
     if (m>n){
       n=m;
     }
   }
   return n;
 }
 
 float getHueFromIndex(int index) {
   int i = index+1;
   if (i<=0) {
     println("function getHueFromIndex should be used only with >=0 arguments !");
     return 0;
   }
   int l = floor(log(i)/log(2));
   int a = i-floor(pow(2,l));
   float ans = (pow(2,-l-1) + a*pow(2,-l))*100;
   
   return ans;
 }
 
   void updatePolReg(){
    //it calculates the regression (array of [P1(t), P2(t), t] where P1 is the regression of the x axis and P2 of the y axis, for each cluster)
    ArrayList<ArrayList<Float[]>> regPol = new ArrayList<ArrayList<Float[]>>();
    this.regPol=regPol;
    for (Cluster c : this.clusters){
      Polynome p1 =c.p;
      Polynome p2 = c.p2;
       ArrayList<Float[]> swarni = new ArrayList<Float[]>(); //each cluster
       //for (int i=0; i<c.numPoints;i++){
       for (int i=0; i<this.sizeValidityPolinomialRegression;i++){
         Float[] xyt = new Float[3];
         xyt[0]=p1.f(c.t.get(c.t.size()-1)+i*c.framediff);
         xyt[1]=height-p2.f(c.t.get(c.t.size()-1)+i*c.framediff);
         xyt[2]=(float)t0 +i;
         swarni.add(xyt);       
     }
     regPol.add(swarni);
   } 
  }
  
}
