package ui.MazeOptionPanel;


import java.awt.event.*;
import javax.swing.*;
import maze.MazeReadingException;
import model.MazeAppModel;
import ui.MazeApp;

/**
 *  the quit Button is a JButton of the MazeOptionPanel (ont the left)
 *  it offers the possibility for a player toquit the maze (and export it) 
 * @author Remi Ducottet
 *
 */
@SuppressWarnings("serial")
public final class QuitButton extends JButton implements ActionListener{
	private final MazeApp mazeApp;

	public QuitButton(MazeApp mazeApp) {
		super("quitter");
		this.mazeApp = mazeApp;
		setFocusPainted(false);//erases the ugly selection rectangle
		addActionListener(this);//in order to be efficient, a button musts gave an Action Listener
	}
	/**
	 * when we click on the button quit, the panel opens a pop-up and we can save the maze if we haven't done so
	 * @param e : an ActionEvent, the button has been clicked on
	 */
	@Override
	public void actionPerformed(ActionEvent e) {
		MazeAppModel model = mazeApp.getMazeAppModel();
		if (model.isModified()) {
//once the player clicks this option, o pop Up opens and he decide if he wants to quit or not ( and if he wants to export his maze before quitting)
			int response = JOptionPane.showInternalOptionDialog(null,"Fichier non sauvegardé, le sauvegarder?","Quitter le labyrinthe", JOptionPane.YES_NO_CANCEL_OPTION, JOptionPane.WARNING_MESSAGE, null, null, null);
			switch (response) {
			case JOptionPane.CANCEL_OPTION:
				return;
			case JOptionPane.OK_OPTION:
					try {
						model.exportMaze();
					} catch (MazeReadingException e1) {
						e1.printStackTrace();
					}
				break;
			case JOptionPane.NO_OPTION:
				break;
			}
		}
		System.exit(0);
	}
}
