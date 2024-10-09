 /**
* Final Application Project, June 2022
* Télécom Paris
* Authors : Delhio Calves, Matthieu Carreau, Rémi Ducottet, Paul Triana
*
* traceAGraph : allows to plot the trajectory of the entities groups, and the regression
*/
  

//method that traces the courb of the displacement of the boids, y in functiun of x
 void traceAGraph(String Str, GPlot plot, ArrayList<Float> hues, int number,PApplet parent){
      //first we read from the csv file
      Table table = loadTable(Str,"header, csv"); //Str is the name of the file
      int size = int(0.74*min(parent.height,parent.width));//size is th value that forces our two windows to have the same size (boids and graph)
      ArrayList<ArrayList<Float[]>> values = new ArrayList<ArrayList<Float[]>>();//values [x,,y,t] of each cluster
      int nRow=0;
      for (TableRow row : table.rows()){
        for (int nColumn=0; nColumn<table.getColumnCount();nColumn++){
          if (nColumn%3 ==0){
            if (nRow ==0){
              ArrayList group=new ArrayList<Float[]>();
              values.add(group);
            }  
            float x0 = row.getFloat(floor(nColumn/3) +"_" + nColumn%3);
            if (x0!=-1){
              Float[] list = new Float[3];       
              list[0]=x0;
              values.get(floor(nColumn/3)).add(list);
              
            }
          }
          else if (nColumn%3 ==1){
            float y0=row.getFloat(floor(nColumn/3) +"_" + nColumn%3);
            if (y0!=-1){
              values.get(floor(nColumn/3)).get(nRow)[1]=y0;
            }
          }
          else {
            float t=row.getFloat(floor(nColumn/3) +"_" + nColumn%3);
            values.get(floor(nColumn/3)).get(nRow)[2]=t;
            
          }
        }
        nRow ++;
      }
      //now that the csv file is read, save in the ArrayList values, we just have to plot it 

      plot.setDim(size,size);//size of the graph

      plot.setTitleText("ordonnée des cluster d'agents en fonction de leur abscisse");
      plot.getXAxis().setAxisLabelText("abscisse des cluster");
      plot.getYAxis().setAxisLabelText("ordonnée des cluster");
      
      int x=0;//number of cluster
      for (ArrayList<Float[]> groups : values){//groups = each cluster
        
        GPointsArray points = new GPointsArray(groups.size());
        for (int i=0; i<groups.size();i++){
          points.add(groups.get(i)[0],groups.get(i)[1]);
        }
        
        plot.addLayer("Courbe" + x + "_" +number, points); //I have to name differently the clusters, they are named : "courbe" + number of the cluster + number of the time we plot it 
        
        colorMode(HSB);
        plot.getLayer("Courbe" + x + "_"+ number).setLineColor(color(hues.get(x),100,100)); //hues is the color of the cluster, we force the layer to have the same color
        plot.getLayer("Courbe" + x + "_"+ number).setPointColor(color(hues.get(x),100,100));
        x++;
      }
      plot.defaultDraw();
    }
    
//trace A graph v2 is the method that shows the regression in a slightly lighter way
    void traceAGraphv2(ArrayList<ArrayList<Float[]>> regPol, GPlot plot, ArrayList<Float> hues,int number2, PApplet parent){
      int size = int(0.74*min(parent.height,parent.width));//size of the window
      plot.setDim(size,size);    
      int x=0;//number of cluster
      for (ArrayList<Float[]> groups : regPol){
        GPointsArray points = new GPointsArray(groups.size());
        for (int i=0; i<groups.size();i++){
          points.add(groups.get(i)[0],groups.get(i)[1]);//regression
        }
        
        plot.addLayer("Courbereg" + x + "_"+ number2 , points);//the id of the layer is "courbereg" + number of group + number of plot
        plot.getLayer("Courbereg" + x+ "_"+number2).setLineColor(color(hues.get(x),50,100)); //the 50 makes the color lighter
        colorMode(HSB);
        plot.getLayer("Courbereg" + x+ "_"+number2).setPointColor(color(hues.get(x),50,100));
        x++;
      }
      plot.defaultDraw();
      
    }

  
    
