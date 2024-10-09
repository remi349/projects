package ui;

import javax.swing.*;

import maze.MazeReadingException;
import java.awt.*;
import java.io.IOException;
/**
 *This is the class of the Center Panel : it's a GridLayout filled with MBoxPanel (it's basically the maze) 
 * @author Remi Ducottet
 *
 */
@SuppressWarnings("serial")
public class BoxesPanel extends JPanel{
	private MBoxPanel mBoxPanel;
	private MazeApp mazeApp;
	
	public BoxesPanel(MazeApp mazeApp) throws MazeReadingException, IOException {
		super();
		this.mazeApp = mazeApp;
		//initialisation (backGround white, gridlayout and emptyBoxes)
		setBackground(Color.WHITE);
		setPreferredSize(new Dimension(1024, 650));
		setLayout(new GridLayout(mazeApp.getMazeAppModel().getHeight(),mazeApp.getMazeAppModel().getWidth()));
		this.init();
	}
	

	/**		Init : this method fills the gridLayout with EmptyBoxes : it removes everything
	 * 
	 **/
	public void init(){
		this.removeAll();
		for (int i=0; i<mazeApp.getMazeAppModel().getHeight();i++) {
			for (int j=0; j<mazeApp.getMazeAppModel().getWidth(); j++) {
				add(mBoxPanel = new MBoxPanel(mazeApp, i ,j));
				mBoxPanel.setBackground(Color.WHITE);
				mBoxPanel.setLabel('e');
			}
		}
	}
/**
 * notifies if there is any updates
 */
	public void notifyForUpdate(){
		this.revalidate();
		repaint();
	}
}
