package maze;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import dijkstra.GraphInterface;
import dijkstra.VertexInterface;

/**
 * this is the class Maze, it will represent a maze
 * it has 3 atributes 
 * -a Matrix of MBoxes : the Maze
 * - an int  : the height
 * - another int ; the width
 * @author Remi Ducottet
 *
 */
public class Maze implements GraphInterface {
	/**
	 * the maze : matrix of MBoxes
	 */
	private MBox[][] maze;  
	/**
	 * the height of the maze (an int)
	 */
	private int height;
	/**
	 * the width of the maze ; an int
	 */
	private int width; 
	
	/** 	
	 * getDeparture : returns the departure of the Maze if there is one (and only one), otherwise it throws an exception
	 * @return a DBox, that is the departure of the maze
	 * @throws MazeReadingException
	 */
	public DBox getDeparture() throws MazeReadingException {
		/**
		 * here is the Departure
		 */
		DBox departure = null;
		/**
		 * this is the number of Departure : it counts how many Departure there is in the maze
		 */
		int numberDeparture =0;
		for (int i=0; i<height;i++) {
			for (int j=0; j< width; j++) {
				if (maze[i][j].getLabel()=='D'/*label of a DBox*/ ) {
					departure = (DBox) maze[i][j];
					numberDeparture+=1;//every time the program finds a departure, this numbers gets bigger
				}
			}
		}
		if (numberDeparture !=1){//We only want exactly one departure
			throw new MazeReadingException("Vous avez " + numberDeparture + " depart (s) , il faudrait qu'il y ait exactement un départ");
		}
		return departure;
	}

	/**		
	 * getArrival : returns the arrival of the Maze if there is one (and only one), otherwise it throws an exception
	 * @return an ABox, that is the arrival of the maze 
	 * @throws MazeReadingException
	 */
	public ABox getArrival() throws MazeReadingException {
		/**
		 * counts the number of arrival in the maze
		 */
		int numberArrival =0;
		/**
		 * here is the Arrival
		 */
		ABox arrival = null;
		for (int i=0; i<height;i++) {
			for (int j=0; j< width; j++) {
				if (maze[i][j].getLabel()=='A') {
					numberArrival +=1;
					arrival = (ABox) maze[i][j];
				}
			}
		}
		if (numberArrival !=1){
			throw new MazeReadingException(  "Vous avez" +numberArrival + " arrivées, il faudrait qu'il y ait exactement une arrivée");
		}
		return arrival;
	}

	/**		
	 * getAllVertices : method of the class GraphInterface, gives the vertices that are part of the maze (which is a MBox[][])
	 * basically, this method transform a matrix of MBox into an ArrayList of vertices 
	 * @param void
	 * @return the ArrayList of the vertices that are part of the Graph
	 */	
	public ArrayList<VertexInterface> getAllVertices(){
		/**
		 * ArrayList that will be returned, will be filled with all the vertices
		 */
		ArrayList<VertexInterface> vertices = new ArrayList <VertexInterface>();
		for (int i=0; i< height; i++) {
			for (int j = 0; j< width; j++) {
				vertices.add(maze[i][j]);
			}
		}
		return vertices;
	}

	/** 	
	 *getSuccessors : gives the vertices that are next to the VertexInterface vertex
	 * @param vertex 
	 * @return ArrayList<VertexInterface> : the arrayList of the neighbors
	 */	
	public ArrayList<VertexInterface> getSuccessors (VertexInterface vertex){
		/**
		 * ArrayList that will be returned, will be filled with all the Sucessors
		 */
		ArrayList<VertexInterface> sucessors = new ArrayList <VertexInterface>();
		/**
		 * ArrayList with all the vertices, we will be looking in this arrayList for the Successors
		 */
		ArrayList<VertexInterface> vertices =  this.getAllVertices();
		/**
		 * box extracted from our vertex in param
		 */
		MBox box = (MBox)vertex ;
		/**
		 * coordinate i of this box 
		 */
		int i = box.geti();
		/**
		 * coordinate j of this box
		 */
		int j = box.getj();
		for (VertexInterface otherVertex : vertices) {
			/**
			 * box that bay be the sucessor
			 */
			MBox otherBox = (MBox) otherVertex;
			/**
			 * coordinate of this box
			 */
			int i2 = otherBox.geti();
			/**
			 * coordinate of this box
			 */
			int j2 = otherBox.getj();
//The vertex must be above or next to, but can't be in diagonal, this explains the first big condition (I avoided two ifs thanks to the method Math.abs())
//The sucessors must me walkable through, hence the second condition (returns true only if label != 'W')
			if 	(((Math.abs(i-i2)== 1 && j2==j)||(i==i2 && Math.abs(j-j2) ==1)) && otherBox.getTraversable()) {
				sucessors.add(otherVertex);	//if these conditions are filled, otherBox is a neighbor of box
			}
		}
		return sucessors;
	}
	
	/**		
	 * getWeight : gives the weight between the vertex src and the vertex dst 
	 * @param src : the source
	 * @param dst : the destination
	 * @return int weight, the distance between src and dst
	 */
	public int getWeight (VertexInterface src, VertexInterface dst) {
		/**
		 * ArrayList of the successor of the vertex src, we will then be looking for dst in this ArrayList
		 */
		ArrayList<VertexInterface>successors = getSuccessors(src);
		if (successors.contains(dst)) {
			return 1;
//We notice that in the dijkstra method, the getWeight method is only used between the successors of 'pivot', who are at a distance of 1
		}
		return 0;
	}
	
//the method initFromTextFile create a maze from the textFile "fileName.txt" locate din the folder data
	/**		
	 * initFromTextFile : generates a maze (the class Maze implements GraphInterface) froma text file entitled fileName
	 * @param fileName
	 * @throws MazeReadingException
	 * @throws IOException
	 */
	public void initFromTextFile(String fileName) throws MazeReadingException, IOException, FileNotFoundException {
		//but in order to create a maze I had first to know the dimensions of this maze.
		//This is why I wrote a method size(fileName) that returns an ArrayList with the Dimensions of this maze
		//You can find this method right below
		/**
		 * dimensions is the ArrayList with the size of the maze
		 */
		int[] dimensions = size(fileName);
		/**
		 * height of the maze
		 */
		int height = dimensions[0];
		/**
		 * width of the maze
		 */
		int width = dimensions[1];
		/**
		 * new maze we will create from the text File
		 */
		MBox [][]maze = new MBox[height][width];
		BufferedReader br =null;		
		try {
			br = new BufferedReader(new FileReader(fileName));
			int i=0;

			for (String line =br.readLine(); line !=null; line=br.readLine()) {
				if (line.length() != width) {
					throw new MazeReadingException( "Nous détectons une erreur de dimensions (en largeur) dans le fichier "+ fileName + " veuillez vous assurer que toutes les lignes ient la même largeur.");
//the maze is supposed to be a rectangle, otherwise there is a mystake
				}
				for (int j=0; j<line.length(); j++) {
					char c = line.charAt(j);
						switch(c) {
						//switch on the Label
						case('W') : {maze[i][j]= new WBox(i,j);break;}
						case('E') : {maze[i][j]= new EBox(i,j);break;}
						case('A') : {maze[i][j]= new ABox(i,j);break;}
						case('D') : {maze[i][j]= new DBox(i,j);break;}
						case('.') : {maze[i][j]= new PBox(i,j);break;}
						default :{throw new MazeReadingException("Il y a un label incorrect dans votre fichier " + fileName + " l'un des caractères de votre texte de départ est incorrect");}
					}
				}
				i++;
			}
			br.close();	
			this.maze = maze;
			this.height=height;
			this.width=width;
			
		}catch (FileNotFoundException e) {
			e.printStackTrace();	
		} catch (IOException e) {
			e.printStackTrace();
		} finally {br.close();}  
	}
	
	/** size : takes as argument a String that is the name of a file that will become a maze (thanks to initFromTextFile). It returns the dimensions of this file to become a maze!
	 * @param fileName : the name of the file, that represents a maze
	 * @return an int[] (that we are going to name dimensions) : heightOfTheMaze = dimensions[0] and widthOfTheMAze = dimensions[1]
	 * @throws MazeReadingException
	 */
	public int[] size(String fileName) throws MazeReadingException{
		/**
		 * List that we will return, will contain the dimensions of the maze
		 */
		int[] dimensions = new int[2];
		BufferedReader file = null;
		try {
			file = new BufferedReader(new FileReader(fileName));
			String ligneRead = file.readLine();
			if (ligneRead==null) {
//if the first line is null, it neans the file is null, it's a mystake
				file.close();
				throw new MazeReadingException ("le fichier " + fileName + " que vous tentez de lire est nul");
			}
//now that we are sure that the file isn't null we just read the size of the lines(width) and the number of line(height)
			/**
			 * width of the maze
			 */
			int width = ligneRead.length();
			/**
			 * height of the maze
			 */
			int height = 1;
			
			while((file.readLine())!= null) {
				height ++;
			} 
			file.close();
			dimensions[0]=height;
			dimensions[1]=width;
		} catch (FileNotFoundException e) {
				e.printStackTrace();
		} catch (IOException e) {
				e.printStackTrace();
		}
		return dimensions; 
	}

	
	/**		saveToTextFile : saves the maze (that implements GraphInterface) into a textFile, into the Folder data
	 * @param fileName : name of the file that will represent the maze
	 */
	public void saveToTextFile (String fileName) {
		PrintWriter pw = null;
		try {
			pw = new PrintWriter(fileName);
			for (int i=0; i<height; i++) {
				for (int j=0; j<width; j++) {
					pw.print(maze[i][j].getLabel());
					//adds the label of the boxes
				}
				if (i != height -1) {
					pw.println("");
//we don't want the file to be one empty line too long, but we want to skip line sometimes, hence the if
				}
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
			pw.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	/**		testDijkstra : this is the function I programmed in order to test the maze, it will create a file with the shortest path represented with '..' in the folder data, with the name filename
	 * @param maze : the maze that will be tested 
	 * @param shortestPath : shortest path between arrival and departure in the Maze maze
	 * @param fileName : name of the file in which I will save the solution of the maze
	 * @throws MazeReadingException
	 * @throws FileNotFoundException
	 */
	public void testDijkstra(GraphInterface maze, ArrayList<VertexInterface> shortestPath, String fileName) throws MazeReadingException, FileNotFoundException {
		if (!shortestPath.contains(maze.getDeparture())) {
			throw new MazeReadingException ("il n'existe pas de chemin reliant le depart et l'arrivee");
//if we couldn't go back to the departure from the arrival, then there isn't a ath between the arrival and the departure
		}
		try {
			PrintWriter pw = new PrintWriter(new FileOutputStream(fileName));
			/**
			 * Departure of the maze
			 */
			DBox departure = maze.getDeparture();
			/**
			 * Arrival of the maze
			 */
			ABox arrival = maze.getArrival();
			for (int i=0; i<maze.getHeight(); i++) {
				for (int j=0; j<maze.getWidth(); j++) {
// we are going through the maze
					/**
					 * MBox we will try to transform into a letter in a text File
					 */
					MBox box =maze.getMaze()[i][j];
					/**
					 * label of this MBox
					 */
					char label = box.getLabel();
//we are getting the boxes and their label 
					if(shortestPath.contains(box)&& box!=departure && box != arrival) {
//we are writting down a point, which symbolizes the path between the Departure and the Arrival, if the box is part of the shortestPath ArrayList
						pw.print(".");
					}
					else {
						pw.print(label);
//Otherwise, it isn't part of the ArrayList and we can print the Label of the Box in the file
					}
				}
				if (i<maze.getHeight()-1) {
					pw.println("");
//finally, we are skipping  line at the end of the line, execpt for the last line
				}
			}
			pw.close();
			
		} catch (FileNotFoundException e) { e.printStackTrace(); }

	}


//getters and setters
	/**		getHeight : returns the height of the maze (that implements GraphInterface)
	 * @return the height of the maze
	 */
	public int getHeight() {
		return height;
	}

	/**	 setHeight : setter of the height
	 * 
	 * @param height : height to set 
	 */
	public void setHeight(int height){
		this.height = height;
	}
	
	/**		getWidth : returns the width of the maze (that implements GraphInterface)
	 * @return the width of the maze
	 */
	public int getWidth() {
		return width;
	}
	
	/** setWidth : setter of the Width
	 * 
	 * @param width : width to set 
	 */
	public void setWidth(int width){
		 this.width=width;
	}

	/**		getMaze : returns the maze (not the class but the matrix)
	 * @return MBox[][]
	 */
	public MBox[][] getMaze(){
		return maze;
	}

	/**		setMaze : setter of the maze
	 * @param maze : maze to set
	 */
	public void setMaze(MBox[][] maze){
		this.maze =maze;
	}
}