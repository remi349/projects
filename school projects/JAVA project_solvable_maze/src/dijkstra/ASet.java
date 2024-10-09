package dijkstra;
import java.util.HashSet;


/**
 * This class represents the List (implemented as an Hashset here) of all the vertices of A, in the Dijkstra Algorithm
 * @author Remi Ducottet
 *
 */
@SuppressWarnings("serial")
public class ASet extends HashSet<VertexInterface> implements ASetInterface{
	
	public ASet(){
		super();
	}
	
	/**
	 * This method adds a Vertex in the HashSet
	 */
	public void addInA(VertexInterface vertex) {
		this.add(vertex);
	}

	/**
	 * this method Checks if a vertex is in the List A
	 */
	public boolean isInA(VertexInterface vertex)
	{
		return this.contains(vertex);
	}
		
	
	
	
	
	

}
