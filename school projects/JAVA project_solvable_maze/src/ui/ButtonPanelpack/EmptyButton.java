package ui.ButtonPanelpack;

import java.awt.Color;
import java.awt.event.*;
import javax.swing.*;

import ui.MazeApp;

/**
 * The empty button is a White JButton on the ButtonPanel (on the right), 
 * it offers the player the possibility to add an empty MBoxPanel on a maze 
 * (once clicked it selects the color white and if a player clicks on a MBoxPanel, it becomes white)
 * @author Remi Ducottet
 *
 */
@SuppressWarnings("serial")
public final class EmptyButton extends JButton implements ActionListener{
	private final MazeApp mazeApp;
	/**
	 * Color of the Empty Button : White
	 */
	private final Color buttonColor = Color.WHITE;

	public EmptyButton(MazeApp mazeApp) {
		super("Case vide");
		setFocusPainted(false);
		this.mazeApp = mazeApp;
		setBackground(Color.WHITE);// background Color of a Button
		addActionListener(this);//in order to be efficient, a button musts gave an Action Listener
	}
/**
 * actions comited if we click on it : the CurrentColor becomes white, cf MazeAppModel
 *  @param e : an ActionEvent, the button has been clicked on
 */
	@Override
	public void actionPerformed(ActionEvent e) {
		mazeApp.getMazeAppModel().setCurrentColor(buttonColor);	
	}
}
