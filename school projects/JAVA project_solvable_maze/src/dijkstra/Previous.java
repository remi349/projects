package dijkstra;
import java.util.ArrayList;
import java.util.Hashtable;



/**
 * This class defines the link of paternity between vertices (it will be implemented with a HashTable)
 * It is essential for the programmation of the Dijkstra Method
 * @author Remi Ducottet
 *
 */
@SuppressWarnings("serial")
public class Previous extends Hashtable<VertexInterface, VertexInterface> implements PreviousInterface {
	
	//the hashtable will be formed with a list of  <a vertex, its father>
	public Previous(){
		super();
	}
	
	/**
	 * defines the relation of paternity between two vertices
	 * @param vertex : the son
	 * @param father : the new father
	 */
	public void paternity(VertexInterface vertex, VertexInterface father) {
		this.put(vertex, father);		
	}

	/**
	 *returns the father of a vertex, in the HashTable
	 *@param vertex :the vertex we want to know the father of 
	 *@return father : the father of the vertex vertex
	 */
	public VertexInterface father(VertexInterface vertex) {
		return this.get(vertex);
	}

	/**
	 * finds the shortest path to the departure, to the arrival thanks to the definition of paternity
	 * @param the Arrival
	 * @return The shortest path from the departure to the Arrival : it's an ArrayList of VertexInterfaces
	 */
	public ArrayList<VertexInterface> shortestPath(VertexInterface vertex) {
		ArrayList<VertexInterface> path = new ArrayList<VertexInterface>();
		while (vertex != null) {
			path.add(vertex);
			vertex = father(vertex);
		}
		return path;
	}
}
