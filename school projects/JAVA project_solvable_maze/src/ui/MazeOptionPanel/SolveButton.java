package ui.MazeOptionPanel;

import java.awt.event.*;
import java.io.IOException;
import javax.swing.*;
import maze.MazeReadingException;
import ui.MazeApp;

/**
 *  the solve Button is a JButton of the MazeOptionPanel (ont the left) 
 *  it offers the possibility for a player to solve a maze
 * @author Remi Ducottet
 *
 */
@SuppressWarnings("serial")
public final class SolveButton extends JButton implements ActionListener {
	private final MazeApp mazeApp;

	public SolveButton(MazeApp mazeApp) {
		super("Resoudre Labyrinthe");
		this.mazeApp = mazeApp;
		setFocusPainted(false);//erases the ugly selection rectangle
		addActionListener(this);//in order to be efficient, a button musts gave an Action Listener
	}
/**
 * When the sove button is clicked on, the player can save the actual maze if he wants to
 * @param e : an ActionEvent, the button has been clicked on
 */
	@Override
	public void actionPerformed(ActionEvent e) {
		try {
			mazeApp.getMazeAppModel().solveMaze();
		} catch (MazeReadingException | IOException e1) {
			e1.printStackTrace();
		}
	}
}//cf solve method in MazeAppModel
