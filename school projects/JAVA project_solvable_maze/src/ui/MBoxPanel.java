package ui;

import java.awt.Color;
import javax.swing.BorderFactory;
import javax.swing.JPanel;
import maze.MazeReadingException;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
/**
 * MBox Panel is the Panel that represents the MBox of the Maze. They are put int the gridLayout of the BoxesPannel
 * They can be red (arrival), blue (departure), white (empty), gray (wall) or green (path)
 * @author Remi Ducottet
 */
@SuppressWarnings("serial")
public class MBoxPanel extends JPanel implements MouseListener{
	private final MazeApp mazeApp;
	/**
	 * coordinate i = height in the maze
	 */
	private final int i ; 
	/**
	 * coordinate j = width in the maze
	 */
	private final int j;	
	/**
	 * Color of the box
	 */
	private Color boxColor;
	/**
	 * label that represents the color of the box
	 */
	private char label;

	public MBoxPanel(MazeApp mazeApp, int i, int j) {
		super();
		this.mazeApp = mazeApp;
		this.i = i;
		this.j=j;
		this.addMouseListener(this);
		setBackground(Color.WHITE);
		setBorder(BorderFactory.createLineBorder(Color.black));
		//allows us to see the gridPanel, otherWise the reboot function would only return awhite screen
	}
	
	
	/**
	 * this function converts the colors into char because it is easier to deal with chars
	 * @param boxColor : color of the box : to convert into a char
	 * @return a char ; 'e' if the color is white (empty).....
	 * @throws MazeReadingException
	 */
	public char ColorToChar (Color boxColor) throws MazeReadingException{
		if (boxColor == Color.WHITE) {return 'e';}
		else if (boxColor == Color.BLUE){return 'd';}
		else if (boxColor == Color.RED){return 'a';}
		else if (boxColor== Color.GRAY){return 'w';}
		else if (boxColor == Color.GREEN){return '.';}
		else {throw new MazeReadingException("Erreur de label, le problème vient de la fonction ColorToChar de la classe MBoxPanel");}


	}
/**
 * changes CurrentColor when a JButton is clicked
 */
	@Override
	public void mouseClicked(MouseEvent e) {
		Color currentColor = this.mazeApp.getMazeAppModel().getCurrentColor();
		try {
			setBoxColor(currentColor);
		} catch (MazeReadingException e1) {
			e1.printStackTrace();
		}
		boxColor = currentColor;
		this.repaint(getVisibleRect());
	}


	//getters and setters 
	public void setBoxColor(Color boxColor) throws MazeReadingException {//set the color of the box
		this.boxColor = boxColor;
		this.setBackground(boxColor);
		setLabel(ColorToChar(boxColor));//we modify the label in the same time that we change the color
	
	}
	public Color getBoxColor(){
		return boxColor;
	}
	public int getI(){
		return i;
	}
	public int getJ(){
		return j;
	}
	
	public void setLabel (char label){
		this.label = label;
	}
	
	public char getLabel(){
		return label;
	}



	//useless function that I must Implement...
	
	@Override
	public void mousePressed(MouseEvent e) {
		//useless in our case
	}
	@Override
	public void mouseReleased(MouseEvent e) {
		//useless in our case
	}
	@Override
	public void mouseEntered(MouseEvent e) {
		//useless in our case
	}
	@Override
	public void mouseExited(MouseEvent e) {
		//useless in our case
	}

}
