package ui;

import javax.swing.*;
import maze.MazeReadingException;
import java.awt.*;
import java.io.IOException;
/**
 * the windowPanel is composed of The boxesPanel(gridLayout of MBoxPanel) in the center, the MazeOptionsPanel on the left and the MazeButtonsPanel on the right
 * @author Remi Ducottet
 *
 */
@SuppressWarnings("serial")
public class WindowPanel extends JPanel {
	/**
	 * Center Panel, where there is the maze
	 */
	private BoxesPanel boxesPanel;
	/**
	 * Left Panel : where you can solve the maze, import a maze, quit, reboot or export
	 */
	private final MazeOptions mazeOptions;
	/**
	 * Right Panel, where you can change the colo or the dimensions
	 */
	public final ButtonPanel buttonPanel;
	/**
	 * All in all, the maze App
	 */
	private MazeApp mazeApp;
	public WindowPanel (MazeApp mazeApp) throws MazeReadingException, IOException {
		super();
		this.setMazeApp(mazeApp);
		setLayout(new BorderLayout());
		boxesPanel = new BoxesPanel(mazeApp);
		mazeApp.getMazeAppModel().setBoxesPanel(boxesPanel); // save the reference
		add (boxesPanel, BorderLayout.CENTER);
		add (mazeOptions = new MazeOptions(mazeApp), BorderLayout.WEST);
		add (buttonPanel = new ButtonPanel(mazeApp), BorderLayout.EAST);
		
	}
/**
 * Naotifies if ther is any updates
 */
	public void notifyForUpdate() {
		buttonPanel.notifyForUpdate();
		mazeOptions.notifyForUpdate();
		boxesPanel.notifyForUpdate();
	}

	public MazeApp getMazeApp() {
		return mazeApp;
	}

	public void setMazeApp(MazeApp mazeApp) {
		this.mazeApp = mazeApp;
	}
}
