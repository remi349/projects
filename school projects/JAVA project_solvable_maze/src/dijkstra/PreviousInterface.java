package dijkstra;
import java.util.ArrayList;

/**
 * this Interface will be implemented by Previous
 * @author Remi Ducottet
 */
public interface PreviousInterface {

	/** 
	 * paternity : defines the relation of fatherhood between two vertices in a Hashtable
	 * @param vertex : the son
	 * @param father : the father 
	 */
	public void paternity(VertexInterface vertex, VertexInterface father);


	/** father : returns the father of a vertex (in the HashTable)
	 * @param vertex ; the vertex of whiwh we want to know the father 
	 * @return the father
	 */
	public VertexInterface father(VertexInterface vertex);


	/** shortestPath : gives the shortest path to this vertex (this vertex will be the Arrival in our case)
	 * @param vertex : give the arrival vertex
	 * @return the ArrayList of vertices that represents the shortest path to the arrival
	 */
	public ArrayList<VertexInterface> shortestPath (VertexInterface vertex); 

}
