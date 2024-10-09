package ui;

import javax.swing.*;
import ui.MazeOptionPanel.ExportButton;
import ui.MazeOptionPanel.ImportButton;
import ui.MazeOptionPanel.QuitButton;
import ui.MazeOptionPanel.RebootButton;
import ui.MazeOptionPanel.SolveButton;
import java.awt.*;
/**
 * MazeOption is the Jpanel on the left that can take actions on the maze
 * it has 5 buttons : import, export, quit, solve and reboot
 * @author Remi Ducottet
 */
@SuppressWarnings("serial")
public final class MazeOptions extends JPanel{
	private final ImportButton importButton;
	private final ExportButton exportButton;
	private final QuitButton quitButton;
	private final SolveButton solveButton;
	private final RebootButton rebootButton;
	
	public MazeOptions(MazeApp mazeApp) {
		super();
		setLayout(new GridLayout(5,1));
		add(importButton = new ImportButton(mazeApp));
		add(exportButton = new ExportButton(mazeApp));
		add(solveButton = new SolveButton(mazeApp));
		add(rebootButton = new RebootButton(mazeApp));
		add(quitButton = new QuitButton(mazeApp));
	}
	
	
	/**
	 * notifies if there is any updates
	 */
	public void notifyForUpdate(){
		repaint();
	}

	public ImportButton getImportButton() {
		return importButton;
	}

	public ExportButton getExportButton() {
		return exportButton;
	}

	public QuitButton getQuitButton() {
		return quitButton;
	}

	public SolveButton getSolveButton() {
		return solveButton;
	}

	public RebootButton getRebootButton() {
		return rebootButton;
	}

}
