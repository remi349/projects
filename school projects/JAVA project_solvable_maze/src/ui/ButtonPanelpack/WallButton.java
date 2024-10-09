package ui.ButtonPanelpack;

import java.awt.Color;
import java.awt.event.*;
import javax.swing.*;
import ui.MazeApp;


/**
 * The wall button is a gray JButton on the ButtonPanel (on the right), 
 * it offers the player the possibility to add a wall on a maze 
 * (once clicked it selects the color gray and if a player clicks on a MBoxPanel, it becomes gray)
 * @author Remi Ducottet
 *
 */
@SuppressWarnings("serial")
public final class WallButton extends JButton implements ActionListener{
	private final MazeApp mazeApp;
	/**
	 * Color of the Wall Button : Gray
	 */
	private final Color buttonColor = Color.GRAY;

	public WallButton(MazeApp mazeApp) {
		super("Mur");
		setBackground(Color.GRAY);// background Color of a Button
		setFocusPainted(false);
		this.mazeApp = mazeApp;
		addActionListener(this);//in order to be efficient, a button musts gave an Action Listener
	}
/**
 * actions comited if we click on it : the CurrentColor becomes gray, cf MazeAppModel
 *  @param e : an ActionEvent, the button has been clicked on
 */
	@Override
	public void actionPerformed(ActionEvent e) {
		mazeApp.getMazeAppModel().setCurrentColor(this.buttonColor);
	}

}
