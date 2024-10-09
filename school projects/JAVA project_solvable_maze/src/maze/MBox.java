package maze;

import dijkstra.VertexInterface;


/**
 * MazeBox, MotherBox : it's the Abstract class that will represent the vertices of the maze.
 * The class is abstract because it will have many daughters
 * @author Remi Ducottet
 *
 */
public abstract class MBox implements VertexInterface{
	/**
	 * Coordinate of the box : height
	 */
	private final int i;
	/**
	 * coordinate of the box : width
	 */
	private final int j;
	/**
	 * label of the box, it's a char ('W' for Walls, 'E' for Empty, 'D' for Departure, 'A'for Arrival and '.' for Path)
	 */
	private final char label;
	/**
	 * the boolean traversable says if you can walk through a box (only the emply Box are Traversable)
	 */
	private final boolean traversable;
	
	/**
	 * Constructor of my MBox
	 * @param i : height
	 * @param j : width 
	 * @param label : char that defines the MBox
	 * @param traversable : boolean that says if the bpx is a wall or no
	 */
	public MBox(int i, int j, char label, boolean traversable) {
		this.i = i;
		this.j = j;
		this.label = label;
		this.traversable = traversable;
		
	}

// given that this parameters aren't going to change,I don't need to write any setters, but here are the getters
	/**
	 * getter of the height
	 * @return i ; the height (an int)
	 */
	public final int geti() {
		return i;
	}
	/**
	 * getter of the width
	 * @return j : the width (an int)
	 */
	public final int getj () {
		return j;
	}
	/**
	 * getter of the label
	 * @return the label : a char
	 */
	public final char getLabel() {
		return label ;
	}
	/**
	 * getter of the boolean traversable
	 * @return true if it's not a wall, false if it is
	 */
	public final boolean getTraversable(){
		return traversable;	
	}
}
