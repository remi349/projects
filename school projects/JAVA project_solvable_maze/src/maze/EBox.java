package maze;

/**
 * class that represents an empty box, it extends the Class MBox that implements Vertex Interface
 * @author Remi Ducottet
 */
public class EBox extends MBox{
	public EBox(final int i,final int j) {
		super(i, j, 'E', true);
	}
}
