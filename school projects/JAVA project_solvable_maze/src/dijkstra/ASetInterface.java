package dijkstra;
/**
 * Interface of the class ASet
 * @author Remi Ducottet
 */
public interface ASetInterface {

	/**
	 * addInA : method of the class ASetInterface, adds in the ASetInterface the Vertex interface vertex
	 * @param vertex : the vertex to add in the ASetInterface
	 */
	public void addInA(VertexInterface vertex);


	/**
	 * isInA : method of the class ASetInterface, that says if the VertexInterface vertex is in the ASetInterface 
	 * @param vertex : the vertex that is asked if t is in the ASetInterface
	 * @return boolean : the boolean is true if vertex is in the ASetInterface and false if it isn't...
	 */
	public boolean isInA(VertexInterface vertex);
	
}
