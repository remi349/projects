package dijkstra;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import maze.ABox;
import maze.DBox;
import maze.MBox;
import maze.MazeReadingException;



/**
 * This class will be implemented by the class Maze : it is in fact a maze, a matrix of vertices
 * @author Remi Ducottet
 *
 */
public interface GraphInterface {

	/**		
	 * getAllVertices : method of the class GraphInterface, gives the vertices that are part of the maze (which is a MBox[][])
	 * basically, this method transform a matrix of MBox into an ArrayList of vertices 
	 * @param void
	 * @return the ArrayList of the vertices that are part of the Graph
	 */
	public ArrayList<VertexInterface> getAllVertices();


	/** 	
	 *getSuccessors : gives the vertices that are next to the VertexInterface vertex
	 * @param vertex 
	 * @return ArrayList<VertexInterface> : the arrayList of the neighbors
	 */
	public ArrayList<VertexInterface> getSuccessors(VertexInterface vertex);


	/**		
	 * getWeight : gives the weight between the vertex src and the vertex dst 
	 * @param src : the source
	 * @param dst : the destination
	 * @return int weight, the distance between src and dst
	 */
	public int getWeight(VertexInterface src, VertexInterface dst);


	/**		
	 * initFromTextFile : generates a maze (the class Maze implements GraphInterface) froma text file entitled fileName
	 * @param fileName
	 * @throws MazeReadingException
	 * @throws IOException
	 */
	public void initFromTextFile(String fileName) throws MazeReadingException, IOException;


	/** 	
	 * getDeparture : returns the departure of the Maze if there is one (and only one), otherwise it throws an exception
	 * @return a DBox, that is the departure of the maze
	 * @throws MazeReadingException
	 */
	public DBox getDeparture() throws MazeReadingException;


	/**		
	 * getArrival : returns the arrival of the Maze if there is one (and only one), otherwise it throws an exception
	 * @return an ABox, that is the arrival of the maze 
	 * @throws MazeReadingException
	 */
	public ABox getArrival() throws MazeReadingException;


	/** size : takes as argument a String that is the name of a file that will become a maze (thanks to initFromTextFile). It returns the dimensions of this file to become a maze!
	 * @param fileName : the name of the file, that represents a maze
	 * @return an int[] (that we are going to name dimensions) : heightOfTheMaze = dimensions[0] and widthOfTheMAze = dimensions[1]
	 * @throws MazeReadingException
	 */
	public  int[] size( String fileName) throws MazeReadingException;


	/**		saveToTextFile : saves the maze (that implements GraphInterface) into a textFile, into the Folder data
	 * @param fileName : name of the file that will represent the maze
	 */
	public void saveToTextFile (String fileName);
	

	/**		testDijkstra : this is the function I programmed in order to test the maze, it will create a file with the shortest path represented with '..' in the folder data, with the name filename
	 * @param maze : the maze that will be tested 
	 * @param shortestPath : shortest path between arrival and departure in the Maze maze
	 * @param fileName : name of the file in which I will save the solution of the maze
	 * @throws MazeReadingException
	 * @throws FileNotFoundException
	 */
	public void testDijkstra(GraphInterface maze, ArrayList<VertexInterface> shortestPath, String fileName) throws MazeReadingException, FileNotFoundException;


	//From now on all the methods will only be getters be getters :


	/**		getHeight : returns the height of the maze (that implements GraphInterface)
	 * @return the height of the maze
	 */
	public int getHeight();


	/**	 setHeight : setter of the height
	 * 
	 * @param height : height to set 
	 */
	public void setHeight(int height);


	/**		getWidth : returns the width of the maze (that implements GraphInterface)
	 * @return the width of the maze
	 */
	public int getWidth();


	/** setWidth : setter of the Width
	 * 
	 * @param width : width to set 
	 */
	public void setWidth(int width);


	/**		getMaze : returns the maze (not the class but the matrix)
	 * @return MBox[][]
	 */
	public MBox[][] getMaze();


	/**		setMaze : setter of the maze
	 * @param maze : maze to set
	 */
	public void setMaze(MBox[][] maze);
}
