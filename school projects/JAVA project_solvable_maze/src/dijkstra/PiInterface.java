package dijkstra;

/**
 * this Interface will be implemented by the class Pi
 * @author Remi Ducottet
 */
public interface PiInterface {

	/**		giveWeightToVertex : in the class Pi (that will be a Hashtable), it gives the Weight weight to a vertex
	 * @param vertex : vertex to be weighted
	 * @param weight : to be addes to the vertex in tthe HashTable
	 */
	public void giveWeightToVertex(VertexInterface vertex, int weight);


	/**		gives the weight of a vertex, which is basically its distance from the Departure
	 * @param vertex : the vertex whose weight is asked
	 * @return the weight of this vertex
	 */
	public int weight(VertexInterface vertex);
}
