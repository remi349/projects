package ui.MazeOptionPanel;

import javax.swing.*;
import maze.MazeReadingException;
import ui.MazeApp;
import java.awt.event.*;

/**
 *  the export Button is a JButton of the MazeOptionPanel (ont the left) 
 * it offers the possibility for a player to export the maze he has created
 * @author Remi Ducottet
 *
 */
@SuppressWarnings("serial")
public final class ExportButton extends JButton implements ActionListener {
	private final MazeApp mazeApp;

	public ExportButton(MazeApp mazeApp) {
		super("Exporter Labyrinthe");
		this.mazeApp = mazeApp;
		setFocusPainted(false);//erases the ugly selection rectangle
		addActionListener(this);//in order to be efficient, a button musts gave an Action Listener
	}
	/**
	 * exports the maze if we click on the button
	 * @param e : an ActionEvent, the button has been clicked on
	 */
	@Override
	public final void actionPerformed(ActionEvent e) {
		try {
			mazeApp.getMazeAppModel().exportMaze();
		} catch (MazeReadingException e1) {
			e1.printStackTrace();
		}//cf export method in MazeAppModel
	}

}
