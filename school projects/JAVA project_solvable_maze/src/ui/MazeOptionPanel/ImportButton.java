package ui.MazeOptionPanel;

import java.awt.event.*;
import java.io.IOException;
import javax.swing.*;

import maze.MazeReadingException;
import ui.MazeApp;

/**
 *  the import Button is a JButton of the MazeOptionPanel (ont the left) 
 *  It offers the possibility for a player to import the maze he has created
 * @author Remi Ducottet
 *
 */
@SuppressWarnings("serial")
public final class ImportButton extends JButton implements ActionListener{
	private final MazeApp mazeApp;

	public ImportButton(MazeApp mazeApp) {
		super("Importer Labyrinthe");
		this.mazeApp = mazeApp;
		setFocusPainted(false);//erases the ugly selection rectangle
		addActionListener(this);//in order to be efficient, a button musts gave an Action Listener
	}
/**
 * import a maze (and we can chose which one, if we click on it
 * @param e : a Change Event
 */
	@Override
	public void actionPerformed(ActionEvent e) {
		try {
			mazeApp.getMazeAppModel().importMaze();
		} catch (MazeReadingException | IOException exception) {
			exception.printStackTrace();
		}
	}//cf import method in MazeAppModel

}
