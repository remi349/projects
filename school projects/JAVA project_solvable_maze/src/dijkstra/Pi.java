package dijkstra;

import java.util.Hashtable;
import java.lang.Integer;


/**
 * class that represents the function pi, that gives the weight of vertices, in the Djikstra Algorithm 
 * @author Remi Ducottet
 *
 */
@SuppressWarnings("serial")
public class Pi extends Hashtable<VertexInterface, Integer> implements PiInterface{
	
	public Pi(){
		super();
	}

	
	
	/**
	 * gives a weight to a vertex (in the HashTable), it represents the weight between this vertex and the arrival
	 * @param vertex : the vertex we want to give a weight to
	 * @param weight : an int, its new weight
	 */
	@Override
	public void giveWeightToVertex(VertexInterface vertex, int weight) {
		this.put(vertex, weight);
	}

	
	/**
	 * returns the Weight of a vertex
	 * @param vertex : a vertex that we want to know the weight
	 * @return an int that represents the weight of the vertex
	 */
	@Override
	public int weight(VertexInterface vertex) {
		return this.get(vertex).intValue();
	}
}
