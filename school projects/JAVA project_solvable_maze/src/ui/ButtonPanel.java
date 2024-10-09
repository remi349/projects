package ui;

import javax.swing.*;

import ui.ButtonPanelpack.ArrivalButton;
import ui.ButtonPanelpack.DepartureButton;
import ui.ButtonPanelpack.DimensionButton;
import ui.ButtonPanelpack.EmptyButton;
import ui.ButtonPanelpack.WallButton;

import java.awt.*;

/**
 * this is the button panel that allow  the player to chose between arrival , departures..It's on the right
 * It has 5 buttons (Departure, Arrival, Wall, Empty and Dimensions)
 * @author Remi Ducottet
 *
 */
@SuppressWarnings("serial")
public final class ButtonPanel extends JPanel{
	private final DepartureButton departureButton;
	private final ArrivalButton arrivalButton;
	private final WallButton wallButton;
	private final EmptyButton emptyButton;
	private final DimensionButton dimensionButton;

	
	public ButtonPanel (MazeApp mazeApp) {
		super();
		setLayout(new GridLayout(5,1));
		add(departureButton = new DepartureButton(mazeApp));
		add(arrivalButton = new ArrivalButton(mazeApp));
		add(wallButton = new WallButton(mazeApp));
		add(emptyButton = new EmptyButton(mazeApp));
		add(dimensionButton = new DimensionButton(mazeApp));
	}
	

	/**
	 * notifies if there is any updates
	 */
	public void notifyForUpdate(){
		repaint();
	}
	
	public DepartureButton getDepartureButton() {
		return departureButton;
	}

	public ArrivalButton getArrivalButton() {
		return arrivalButton;
	}

	public WallButton getWallButton() {
		return wallButton;
	}

	public EmptyButton getEmptyButton() {
		return emptyButton;
	}

	public DimensionButton getDimensionButton() {
		return dimensionButton;
	}

}
