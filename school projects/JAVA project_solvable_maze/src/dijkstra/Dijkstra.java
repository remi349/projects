package dijkstra;
import java.util.ArrayList;

/**
 * Class Dijkstra, it will programm the method that will solve the Maze : Youpi
 * @author lepc-remi
 *
 */
public class Dijkstra {


	/**
	 * here is the first programmation of the method dijkstra
	 * @param g : GraphInterface that is in fact the maze
	 * @param r : the Departure
	 * @param a : hashset of vertices
	 * @param pi : weight of the vertices
	 * @param previous :hashtable of vertices, it represents the link of paternity
	 * @return a Previous Interface, hashtable of the vertices and their father
	 */
	private static PreviousInterface dijkstra(GraphInterface g, VertexInterface r, ASetInterface a, PiInterface pi, PreviousInterface previous)
	{
		a.addInA(r);
		/**
		 * pivot is the VertexInterface of the pivot, it helps to find the shortestpath
		 */
		VertexInterface pivot = r;
		pi.giveWeightToVertex(r,0);
		/**
		 * all the vertices of the GraphInterface (or maze)
		 */
		ArrayList<VertexInterface> sommets = g.getAllVertices();
		/**
		 * here, INFIN = Integer.MAX_VALUE = 21474836472147483647
		 * it just represents a big value
		 */
		final int INFINI = Integer.MAX_VALUE;
		for (VertexInterface x : sommets) {
			if (x!= pivot) {
				pi.giveWeightToVertex(x, INFINI);
			}
		}
		/**
		 * number of vertices less 1
		 */
		int n = sommets.size()-1;
		for (int j=1;j<n;j++) {
			/**
			 * succ is an ArrayList of vertices of all the succesors of the pivot
			 */
			ArrayList<VertexInterface> succ = g.getSuccessors(pivot);
			for (VertexInterface y : sommets) {
				if (!a.isInA(y)){
					if (succ.contains(y)) {
// Ib order to minimize the complexity, I decided to write two different ifs and not a big if (condition 1 && condition 2)
						/**
						 * value is the weight of the vertex y, it will be modified it is smaller than the actual weight of y
						 */
						int value =  pi.weight(pivot) + g.getWeight(pivot, y);
						if (value < pi.weight(y)) {
							pi.giveWeightToVertex(y,value);
							previous.paternity(y, pivot);
						}
					}
				}
			}
			int referenceValue = Integer.MAX_VALUE; 
			/**
			 * this valeurDeReference is an int that represents the smallest weight of the vertices in the ASet a
			 * it isn't final because it will change, we are looking for the shortest path...
			 */
			for (VertexInterface b : sommets) {
				if (!a.isInA(b)) {
					int value = pi.weight(b);
					if ( value < referenceValue) {
						referenceValue = value;	
						pivot =b;
					}
				}
			}
			if (!a.isInA(pivot)) {
				a.addInA(pivot);
			}
		}	
		return previous;
	}	

	/**
	 * second programmation of the method dijkstra (as it is asked in the powerpoint)
	 * @param g : this GraphInterface is the maze we want to solve
	 * @param r : it's the Departure
	 * @return a Previous Interface, hashtable of the vertices and their father
	 */
	public static PreviousInterface dijkstra(GraphInterface g, VertexInterface r) {
		return dijkstra(g, r, (ASetInterface) new ASet(), (PiInterface) new Pi(), (PreviousInterface)new Previous());
	}
}
