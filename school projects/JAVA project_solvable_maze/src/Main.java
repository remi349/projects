import java.io.IOException;
import java.util.ArrayList;
import dijkstra.Dijkstra;
import dijkstra.GraphInterface;
import dijkstra.PreviousInterface;
import dijkstra.VertexInterface;
import maze.Maze;
//import maze.MazeReadingException;
import ui.*;

/**
 * here is the class main
 * 
 * @author Remi Ducottet
 */
public class Main {
	/**
	 * method main, it's the one that is run
	 * 
	 * @param args
	 * @throws MazeReadingException
	 * @throws IOException
	 */
	public static void main(String[] args) throws MazeReadingException, IOException {
		// Between the line 22 and 46, is just the code that checks if the methods we
		// have implemented (such as Dijkstra) work
		/**
		 * this GraphInterface is the maze that we will create from the text File
		 * it is only here to test if the methods in the Dijkstra class work
		 */
		GraphInterface maze = new Maze();
		try {
			maze.initFromTextFile("./data/labyrinthe1.txt");
			maze.saveToTextFile("./data/labyrinthe_copie.txt");
		} //catch (Exception e) {
			//e.printStackTrace();
		//}
		/**
		 * this Previous Interface is the Hashtable that is here to define the links
		 * between the vertices
		 */
		PreviousInterface previousInterface = Dijkstra.dijkstra(maze, maze.getDeparture());
		/**
		 * this ArrayList is only the shortest path between the departure and the
		 * arrival, it will be saved in a file later in
		 * order to test the methods in Dijkstra
		 */
		ArrayList<VertexInterface> shortestPath = previousInterface.shortestPath((VertexInterface) maze.getArrival());
		maze.testDijkstra(maze, shortestPath, "./data/labyrintheresolu.txt");
		/**
		 * opens the User Interface
		 */
		new MazeApp();

	}
}