//beware you have to download graphica

import grafica.*;
GPlot plot; 
 


////////////////super fonction qui trace un graph////////////////
 //la table a pour appellation n°groupe__(0 ou 1 selon si c'est x ou y)
 //elle renvoie ArrayList<<[x,y],[x1,y1],....>,<...>,....>>
 //si dans le csv y'a des -1, c'est vide
 
    void traceAGraph(String S){
      GPlot plot;
      //first we read from the csv
      Table table =loadTable(S,"header");
      ArrayList<ArrayList<Float[]>> values = new ArrayList<ArrayList<Float[]>>();
      int nRow=0;
      for (TableRow row : table.rows()){
        for (int nColumn=0; nColumn<table.getColumnCount();nColumn++){
          if (nColumn%2 ==0){
            if (nRow ==0){
              ArrayList group=new ArrayList<Float[]>();
              values.add(group);
            }  
            float x0 = row.getFloat(floor(nColumn/2) +"_" + nColumn%2);
            if (x0!=-1){
              Float[] list = new Float[2];       
              list[0]=x0;
              values.get(floor(nColumn/2)).add(list);
              
            }
          }
          else {
            float y0=row.getFloat(floor(nColumn/2) +"_" + nColumn%2);
            if (y0!=-1){
              values.get(floor(nColumn/2)).get(nRow)[1]=y0;
            }
          }
        }
        nRow ++;
      }
      plot = new GPlot(this);
      plot.setDim(700,300);//taille du graph
      plot.setTitleText("y=f(x)");
      plot.getXAxis().setAxisLabelText("x");
      plot.getYAxis().setAxisLabelText("y");
      int x=0;
      for (ArrayList<Float[]> groups : values){
        GPointsArray points = new GPointsArray(groups.size());
        for (int i=0; i<groups.size();i++){
          points.add(groups.get(i)[0],groups.get(i)[1]);
        }
        plot.addLayer("Courbe" + x, points);
        plot.getLayer("Courbe" + x).setLineColor(color(255,100,255));
        x++;
      }
      plot.activatePointLabels();
      plot.defaultDraw();
    }





//ça marche ;)
void test(){
  Table table1=new Table();
  table1.addColumn("0_0");
  table1.addColumn("0_1");
  table1.addColumn("1_0");
  table1.addColumn("1_1");
  table1.addColumn("2_0");
  table1.addColumn("2_1");
  for (float i=0; i<2; i = i+0.1){
    TableRow newRow = table1.addRow();
    newRow.setFloat("0_0",i);
    newRow.setFloat("0_1",i/10);
    newRow.setFloat("1_0",i+2);
    newRow.setFloat("1_1",i*10);
    newRow.setFloat("2_0",i*i);
    newRow.setFloat("2_1",i);
 /*newRow = table1.addRow();
 newRow.setFloat("0_0",3);
 newRow.setFloat("0_1",3/10);
 newRow.setFloat("1_0",-1);
 newRow.setFloat("1_1",-1);
 newRow.setFloat("2_0",-1);
 newRow.setFloat("2_1",-1);*/
 saveTable(table1, "test.csv");
  }
  
}
  
    
    
    
