package ui.ButtonPanelpack;

import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;

import ui.MazeApp;

/**
 * The Diùension button is a cyan JButton on the ButtonPanel (on the right), 
 * it offers the player the possibility to change the dimensions (height, width) of the  maze 
 * @author Remi Ducottet
 *
 */
@SuppressWarnings("serial")
public final class DimensionButton extends JButton implements ActionListener{
	private final MazeApp mazeApp;

	public DimensionButton(MazeApp mazeApp) {
		super("Chager les dimensions du labyrinthe");
		this.mazeApp = mazeApp;
		setBackground(Color.CYAN);// background Color of a Button
		addActionListener(this);//in order to be efficient, a button musts gave an Action Listener
		setFocusPainted(false);//erases the ugly selection rectangle
	}
	/**
	 * this function (cf MazeAppModel) opens a Pop Up that offers the player the possibility to decide new dimensions
	 *  @param e : an ActionEvent, the button has been clicked on
	 */
	@Override
	public void actionPerformed(ActionEvent e) {
		mazeApp.getMazeAppModel().changeTheDimensions();
	}
}