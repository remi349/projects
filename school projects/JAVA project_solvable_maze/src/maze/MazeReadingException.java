package maze;

/**
 * Class of the Exceptions, it is mainly here in order to understand where I did a mystake while programming my App 
 * @author Remi Ducottet
 *
 */
@SuppressWarnings("serial")
public class MazeReadingException extends Exception {
	
	/**
	 * The error message will say where is the mystake that has been made in the program
	 */
	private String errorMessage;

	public MazeReadingException  (String errorMessage) {
		super(errorMessage );
	}

/**
 * getter of my errorMessage	
 * @return the ErrorMessage, a String
 */
	public String getErrorMessage() {
		return errorMessage;
	}


	
	


	
}
