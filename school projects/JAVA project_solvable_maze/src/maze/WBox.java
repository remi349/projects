package maze;
/**
 * class that represents a wall, it extends the Class MBox that implements Vertex Interface
 * @author Remi Ducottet
 *
 */
public class WBox extends MBox{

	public WBox(final int i,final int j) {
		super(i,j,'W', false);
	}

}
