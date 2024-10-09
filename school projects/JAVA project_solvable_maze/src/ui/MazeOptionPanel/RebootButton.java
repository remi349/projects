package ui.MazeOptionPanel;

import java.awt.event.*;
import javax.swing.*;
import ui.MazeApp;

/**
 *  the reboot Button is a JButton of the MazeOptionPanel (ont the left) 
 *  it offers the possibility for a player to reboot the boxesPanel
 * @author Remi Ducottet
 *
 */
@SuppressWarnings("serial")
public final class RebootButton extends JButton implements ActionListener{
	private final MazeApp mazeApp;

	public RebootButton(MazeApp mazeApp) {
		super("Reinitialiser Labyrinthe");
		this.mazeApp = mazeApp;
		setFocusPainted(false);//erases the ugly selection rectangle
		addActionListener(this);//in order to be efficient, a button musts gave an Action Listener
	}
/**
 * if the button is clicked on, we can reboot the maze
 * @param e : an ActionEvent, the button has been clicked on
 */
	@Override
	public void actionPerformed(ActionEvent e) {
		mazeApp.getMazeAppModel().rebootMaze();		
	}
}//cf reboot method in MazeAppModel
