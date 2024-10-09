package ui.ButtonPanelpack;

import java.awt.Color;
import java.awt.event.*;
import javax.swing.*;

import ui.MazeApp;
/**
 * The arrival button is a Red JButton on the ButtonPanel (on the right), 
 * it offers the player the possibility to add an arrival on a maze 
 * (once clicked it selects the color red and if a player clicks on a MBoxPanel, it becomes red)
 * @author Remi Ducottet
 *
 */

@SuppressWarnings("serial")
public final class ArrivalButton extends JButton implements ActionListener {
	private final MazeApp mazeApp;
	/**
	 * color of the arrival button : red
	 */
	private final Color buttonColor = Color.RED; 

	public ArrivalButton(MazeApp mazeApp) {
		super("Arrivee");
		setBackground(Color.RED);// background Color of a Button
		this.mazeApp = mazeApp;
		addActionListener(this);//in order to be efficient, a button musts gave an Action Listener
	}

	/**
	 * actions performed if we click on it : the CurrentColor becomes red, cf MazeAppModel
	 *  @param e : an ActionEvent, the button has been clicked on
	 */
	@Override
	public void actionPerformed(ActionEvent e) {
		mazeApp.getMazeAppModel().setCurrentColor(this.buttonColor);
	}

}
