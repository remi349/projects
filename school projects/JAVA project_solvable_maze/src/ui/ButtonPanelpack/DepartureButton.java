package ui.ButtonPanelpack;

import java.awt.Color;
import javax.swing.*;
import java.awt.event.*;
import ui.MazeApp;

/**
 * The Departure button is a Blue JButton on the ButtonPanel (on the right), 
 *it offers the player the possibility to add a departure on a maze 
 *(once clicked it selects the color blue and if a player clicks on a MBoxPanel, it becomes blue)
 * @author Remi Ducottet
 */
@SuppressWarnings("serial")
public final class DepartureButton extends JButton implements ActionListener {
	private final MazeApp mazeApp;
	/**
	 * Color of the Departure Button : Blue
	 */
	private final Color buttonColor = Color.BLUE;

	public DepartureButton(MazeApp mazeApp) {
		super("Depart");
		this.mazeApp = mazeApp;
		setBackground(Color.BLUE);// background Color of a Button
		addActionListener(this);//in order to be efficient, a button musts gave an Action Listener
	}
	/**
	 * actions comited if we click on it : the CurrentColor becomes blue, cf MazeAppModel
	 *  @param e : an ActionEvent, the button has been clicked on
	 */
	@Override
	public void actionPerformed(ActionEvent e) {
		mazeApp.getMazeAppModel().setCurrentColor(this.buttonColor);
		
	}
}
