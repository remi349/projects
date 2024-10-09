package ui;

import java.io.IOException;
import java.util.*;

import javax.swing.*;
import javax.swing.event.ChangeEvent;

import maze.MazeReadingException;
import model.*;
/**
 * MazeApp is the Main class of the ui, sets visible the windowPanel
 * @author Remi Ducottet
 *
 */
@SuppressWarnings({ "serial", "deprecation" })
public class MazeApp extends JFrame implements Observer {	
	private MazeAppModel mazeAppModel;
	private WindowPanel windowPanel;
	public MazeApp() {
		super("mon labyrinthe");	
		this.mazeAppModel = new MazeAppModel(this);
		try {
			windowPanel = new WindowPanel(this);
		} catch (MazeReadingException | IOException e) {
			e.printStackTrace();
		}
		setContentPane(windowPanel);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	pack();
	setVisible(true); 
	}

	@Override
	public void update( Observable o, Object arg) {
		notifyForUpdate();
	}
/**
 * notifies if there is any updates
 */
	public void notifyForUpdate() {
		windowPanel.notifyForUpdate();
	}
	

	/**
	 * Warns the mazeAppMOdel when it changes, guarantee the MVC model
	 * @param e : the ChangeEvent
	 * @throws MazeReadingException
	 * @throws IOException
	 */
	public void stateChanged(ChangeEvent e) throws MazeReadingException, IOException {
		setContentPane(windowPanel = new WindowPanel(this));
		mazeAppModel.addObserver(this);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		windowPanel.notifyForUpdate();
	}
//getters and setters :
	public MazeAppModel getMazeAppModel() {
		return mazeAppModel;
	}

	public void setMazeAppModel(MazeAppModel mazeAppModel) {
		this.mazeAppModel = mazeAppModel;
	}
}
