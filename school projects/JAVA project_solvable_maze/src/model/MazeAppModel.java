package model;

import java.util.*;
import javax.swing.JOptionPane;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;
import dijkstra.Dijkstra;
import dijkstra.PreviousInterface;
import dijkstra.VertexInterface;
import maze.EBox;
import maze.ABox;
import maze.WBox;
import maze.DBox;
import maze.PBox;
import maze.MBox;
import maze.Maze;
import maze.MazeReadingException;
import ui.BoxesPanel;
import ui.MBoxPanel;
import ui.MazeApp;
import java.awt.*;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import static javax.swing.JOptionPane.showMessageDialog;

/**
 * Model of my app
 * @author Remi Ducottet
 *
 */

@SuppressWarnings("deprecation")
public class MazeAppModel extends Observable {
	/**
	 * my App
	 */
	private MazeApp mazeApp;
	/**
	 * height of the maze
	 */
	private int height;
	/**
	 * width of the maze
	 */
	private int width;
	/**
	 * maze, martix of MBoxes
	 */
	private static MBox[][] mBoxes; 
	/**
	 * boolean that announces if the boxes panel has been modified (precises if we need to save the maze before exit)
	 */
	private boolean modified; 
	/**
	 * it's composed of a grid layout and of all the MBoxPanel, which are the MBox of the maze
	 */
	private BoxesPanel boxesPanel; 
	/**
	 * ArrayList of ChangeListener
	 */
	private ArrayList<ChangeListener> changeListener = new ArrayList<ChangeListener>();
	/**
	 * color selected : when we click on a MBoxPanel, its background color becomes 'CurrentColor'
	 */
	private Color currentColor; 
	
	public MazeAppModel(MazeApp mazeApp) {
		this.mazeApp=mazeApp;
		//here is the message that is displayed when we open the maze
		showMessageDialog(null,"Bienvenue dans Maze, une application vous proposant de résoudre des labyrinthes.\nVous pouvez créer des labyrinthe de manière dynamique, les résoudre, en importer\n(il existe 5 labyrinthes préentrés, labyrinthe1, labyrinthe2, labyrinthe3, labyrinthe4 et labyrinthe5\nmais vous pouvez également écrire vous même un fichier texte avec un labyrinthe)\net enfin vous pouvez sauvegardez vos labyrinthes créés dans le dossier data.\n                    Amusez-vous bien, j'éspère que l'application vous plaira!\n\n\n PS : J'aimerai avant toute chose remercier Barthélémy Paléologue et Nans Webert, deux Télécomiens\n qui m'ont bien aidés (notamment dans le débeugage) et sans qui mon labyrinthe n'aurait peut-être pas vu le jour.... \n  PPS : Je vous recommande vivement le labyrinthe4 même si ils sont tous fort stimulants");
		/**
		 * default height when we lauch the App : can be modified after
		 */
		height =5; 
		/**
		 * default width when we lauch the App : can be modified after
		 */
		width =5;
		/**
		 *now we are creating and initializing a maze with many Empty MBoxes (so the player can create its own maze)
		 */
		mBoxes = new MBox[height][width]; 
		for (int i = 0; i<height; i++) {
			for  (int j=0; j<width; j++) {
				mBoxes[i][j] = new EBox(i,j);
			}
		}
		modified = false;// modified becomes false, it will become true if the player changes the background of a MBoxPanel
	}

	/** getMazeFromIhm : generates a maze (from the class maze) from the boxesPanel : it basically gets the MBoxPanel and convert them into a maze (which are MBox)
	 * @return Maze : a maze (height, width and MBox[][]) that is created from the IHM
	 * @throws MazeReadingException
	 */
	public final Maze getMazeFromIHM() throws MazeReadingException{
		/**
		 * first, we have to create a maze and to set its height, width and maze. We get it from the Model
		 */
		Maze  newMaze = new Maze();
		/**
		 * height of the new maze
		 */
		int height = mazeApp.getMazeAppModel().getHeight();
		newMaze.setHeight(height);
		/**
		 * width of the new maze
		 */
		int width = mazeApp.getMazeAppModel().getWidth();
		newMaze.setWidth(width);
		/**
		 * newMBox[][] that will be addes in the new Maze
		 */
		MBox [][] mazeBoxes = new MBox[height][width];
		newMaze.setMaze(mazeBoxes);
		/**
		 * Now, we can read the WindowPanel (especially the boxesPanel) get all its component and cast them into MBoxPanel
		 */
		Component[] mBoxesToExport =  boxesPanel.getComponents();
		for (Component component : mBoxesToExport){
			/**
			 * MBoxPanel to export into an MBos of a maze
			 */
			MBoxPanel mBox = (MBoxPanel) component;
			/**
			 * coordinate i of this MBoxPanel
			 */
			int i = mBox.getI();
			/**
			 * coordinate i of this MBoxPanel
			 */
			int j = mBox.getJ();
			//here I coped with a problem, I couldn't make a switch on the color of the Bacground of the MBox Panel
			//This is why I decided to add an attribute 'label' to the class MBoxPanel so I could get easily which box is what (Wall, Empty...)
			/**
			 * label of my MBoxPanel
			 */
			char label = mBox.getLabel();
			switch(label){//Once this attribute created, I could create my maze
				case('e') : {newMaze.getMaze()[i][j]=new EBox(i,j);break;}//empty
				case('w') : {newMaze.getMaze()[i][j]=new WBox(i,j);break;}//wall
				case('a') : {newMaze.getMaze()[i][j]=new ABox(i,j);break;}//Arrival
				case('d') : {newMaze.getMaze()[i][j]=new DBox(i,j);break;}//Departure
				case('.') : {newMaze.getMaze()[i][j]=new PBox(i,j);break;}//Path
				default   : {throw new MazeReadingException("Erreur de label, le problème vient de la fonction getMazeFromIHM de la classe MazeAppModel");}//error
			}
		}
		return newMaze;

	}


	/**	
	 * 	exportMaze : once the button export maze is clicked, we can export a maze.
	 * It's up to the player to decide what is the name of the File exported, but it's located in the folder data
	 */

	public final void exportMaze() throws MazeReadingException {
		/**
		 * maze to export
		 */
		Maze newMaze = getMazeFromIHM();
		String fileNameGiven = "Sous quel nom voulez vous sauvegarder le fichier?";//we ask the player a fileName
		String fileName = JOptionPane.showInputDialog(fileNameGiven);//we read this fileName 
		newMaze.saveToTextFile("./data/"+ fileName+".txt");//we use the method 'saveToTextFile'
		mazeApp.getMazeAppModel().setModified(false);//finally, once the maze is saved, there is no needto save it once more
		//so we give the boolean modified the value 'false'
	}
	
	
	/**
	 * importMaze : once the button export maze is clicked, we can import a maze.
	 * It's up to the player to decide what is the name of the File he wants to import, but the file has to be located in the folder data
	 */

	public final void importMaze() throws MazeReadingException, IOException, FileNotFoundException {
		this.boxesPanel.removeAll();//first we clean the boxesPanel before asking the player the name of the file he wants to import
		String messageImport = "Quel est le nom du labyrinthe que vous voulez exporter (ex : écrivez «labyrinthe4» dan la barre de recherche)\n nous vous avons déjà préprogrammé les labyrinthes labyrinthe1 à labyrinthe5 si vous voulez vous amuser\n mais vous pouvez bien évidemment importer des fichiers que vous avez vous-même écrit";
		String fileNameReceived = JOptionPane.showInputDialog(messageImport);
		String fileName = "./data/" + fileNameReceived + ".txt";//treatment of the fileName
		/**
		 * new Maze to import
		 */
		Maze maze = new Maze();
		maze.initFromTextFile(fileName);//we are ,now creating the maze from the text file thanks to the method already written
		MBoxPanel mBoxPanel;
		/**
		 * height of this new Maze
		 */
		height = maze.getHeight();//we are getting the dimensions in order to create the new gridLayout
		/**
		 * Width of this new maze
		 */
		width = maze.getWidth();
		boxesPanel.setLayout(new GridLayout(height,width));
		//finally we are looping on the coordinates in order to create the MBoxPanel, one by one
		for (int i =0; i<height;i++) {
			for (int j=0; j<width; j++) {
				boxesPanel.add(mBoxPanel = new MBoxPanel(mazeApp,i,j));
				switch(maze.getMaze()[i][j].getLabel()) {
				case 'W' : {mBoxPanel.setBackground(Color.GRAY);mBoxPanel.setLabel('w'); break;}
				case 'D' : {mBoxPanel.setBackground(Color.BLUE);mBoxPanel.setLabel('d'); break;}
				case 'A' : {mBoxPanel.setBackground(Color.RED) ;mBoxPanel.setLabel('a'); break;}
				case 'E' : {mBoxPanel.setBackground(Color.WHITE);mBoxPanel.setLabel('e');break;}
				case '.' : {mBoxPanel.setBackground(Color.GREEN);mBoxPanel.setLabel('.');break;}
				default :  {mBoxPanel.setBackground(Color.PINK);mBoxPanel.setLabel('x'); break;}// Color Pink or char x  = error
				}
			}
		}
		mazeApp.notifyForUpdate();// all in all, we have to notify the maze, in order to respect the MVC way
	}
	

	/**		rebootMaze : once the button Reboot Maze is clicked, we have to clear the mBoxesPanel.
	 * this method just converts every MBoxPanel (Wall, Path..) into an EmptyBox
	 */

	public final void rebootMaze() {
		this.boxesPanel.init();//the function init removes everything and creates empty Boxes thanks to a loop
		mazeApp.notifyForUpdate();//don't forget to notify the maze
	}


	/**		solveMaze : once the button Solve Maze is clicked, we have to print on screen the solution
	 * this method just converts gets the maze from the IHM, uses the Dijkstra method to solve it and print the solution
	 */	
	public final void solveMaze() throws MazeReadingException, IOException {
		/**
		 * maze to solve, got from ihm
		 */
		Maze maze = getMazeFromIHM(); 
		/**
		 * previous interface of this maze
		 */
		PreviousInterface previousInterface = Dijkstra.dijkstra(maze ,maze.getDeparture());//then we create a temporary file with the solution (in the folder data)
		/**
		 * shortest path in this maze
		 */
		ArrayList<VertexInterface> shortestPath = previousInterface.shortestPath((VertexInterface) maze.getArrival());
		maze.testDijkstra(maze, shortestPath, "./data/labyrinthetemporaire.txt");
		//from now on, we just have to charge this maze.. But we can't use the import method because this method asks the player which maze to import, here we already know this fileName..We just have to adapt it 
		/**
		 * maze solved
		 */
		Maze maze2 = new Maze();//creation of the new maze solved
		this.boxesPanel.removeAll();
		maze2.initFromTextFile("./data/labyrinthetemporaire.txt");//the maze2 is the Maze maze with the solution Path
		MBoxPanel mBoxPanel;
		/**
		 * height of the maze
		 */
		height = maze2.getHeight();//dimensions of the maze (=maze.getHeight() too)
		/**
		 * width of the maze
		 */
		width = maze2.getWidth();
		boxesPanel.setLayout(new GridLayout(height,width));//creation of the gridLayout
		for (int i =0; i<height;i++) {//loop on the maze in order to create the boxesPanel with the  MBoxPanel
			for (int j=0; j<width; j++) {
				boxesPanel.add(mBoxPanel = new MBoxPanel(mazeApp,i,j));
				switch(maze2.getMaze()[i][j].getLabel()) {
				case 'W' : {mBoxPanel.setBackground(Color.GRAY);mBoxPanel.setLabel('w'); break;}
				case 'D' : {mBoxPanel.setBackground(Color.BLUE);mBoxPanel.setLabel('d'); break;}
				case 'A' : {mBoxPanel.setBackground(Color.RED) ;mBoxPanel.setLabel('a'); break;}
				case 'E' : {mBoxPanel.setBackground(Color.WHITE);mBoxPanel.setLabel('e');break;}
				case '.' : {mBoxPanel.setBackground(Color.GREEN);mBoxPanel.setLabel('.');break;}
				default :  {mBoxPanel.setBackground(Color.PINK);mBoxPanel.setLabel('x'); break;}// Color Pink or char x  = error
				}
			}
		}
		mazeApp.notifyForUpdate();//NOTIFY !!!
		/**
		 * this file is only here to be deleted, it represents the maze that we have solved but in a text file
		 * I created it in order to use the method init from text file while programming
		 */
		File f= new File("./data/labyrinthetemporaire.txt");//Now, we delete the File with the maze solved because we won't use it anymore
		f.delete();
	}


	/**		chngeTheDimensions : once the button change Dimensions is clicked, the player can chose the new dimensions
	 * this method just receives the new dimensions from the player and create a GridLayout (on the boxesPanel) full of empty MBoxPanel
	*/

	public void changeTheDimensions() {
		this.boxesPanel.removeAll();//first clean the boxesPanel
		String messageNewH = "Entrez la nouvelle Hauteur du labyrinthe svp";//get new Height
		String newHeight = JOptionPane.showInputDialog(messageNewH);
		/**
		 * new height of the maze
		 */
		height =Integer.parseInt(newHeight);
		String messageNewW = "Entrez la nouvelle Largeur du labyrinthe svp";//get new Width
		String newWidth = JOptionPane.showInputDialog(messageNewW);
		/**
		 * new width of the maze
		 */
		width =Integer.parseInt(newWidth);
		/**
		 * new grid Layout of the boxes Panel
		 */
		boxesPanel.setLayout(new GridLayout(height,width));//create new GridLayout in the boxesPanel
		this.boxesPanel.init();//initializes this GridLayout with Empty MBoxPanel
		mazeApp.notifyForUpdate();//alxays end with a notifyForUpdate
	}
	
	
	/**
	 * this method warns if the player has clicked on a MBoxPanel, thanks to th elisteners
	 */
	
	public void stateChanges() {
		ChangeEvent evt = new ChangeEvent(this);
		for (ChangeListener listener : changeListener ) {
			listener.stateChanged(evt);
		}
	}

//here are my getters and my setters
	
	public Color getCurrentColor() {
		return currentColor;
	}
	
	public void setCurrentColor(Color currentColor) {
		if (this.currentColor!= currentColor) {
			this.currentColor= currentColor;
			modified=true;
			stateChanges();
	
		}
	}


	public void setBoxesPanel(BoxesPanel newBoxesPanel){
		this.boxesPanel = newBoxesPanel;
	}

	public boolean isModified() {
		return modified;
	}

	public void setModified(boolean modified) {
		this.modified = modified;
	}
	
	public int getHeight() {
		return height;
	}
	public void setHeight(int height) {
		this.height = height;
	}
	
	public void setWidth(int width) {
		this.width = width;
	}

	public int getWidth() {
		return width;
	}
}
