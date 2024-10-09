# MAZE
## Introduction
This project was developped during my License 3 in Telecom Paris, in the course [INF103, Langage JAVA] (https://synapses.telecom-paris.fr/catalogue/2020-2021/ue/287/INF103-langage-java) . It is Java code that allows to create a maze with an interactive user Interface, and solves the maze by finding the shortest path from the start to the finishing. This shortest Path is found by using a Dijkstra Algorithm.
More details can be found on how the code is structured in the javadoc generated along this code

## Structure of the code

.<br />
├── bin<br />
│   ├── dijkstra<br />
│   │   ├── ASet.class<br />
│   │   ├── ASetInterface.class<br />
│   │   ├── Dijkstra.class<br />
│   │   ├── GraphInterface.class<br />
│   │   ├── Pi.class<br />
│   │   ├── PiInterface.class<br />
│   │   ├── Previous.class<br />
│   │   ├── PreviousInterface.class<br />
│   │   └── VertexInterface.class<br />
│   ├── maze<br />
│   │   ├── ABox.class<br />
│   │   ├── DBox.class<br />
│   │   ├── EBox.class<br />
│   │   ├── MBox.class<br />
│   │   ├── Maze.class<br />
│   │   ├── MazeReadingException.class<br />
│   │   ├── PBox.class<br />
│   │   └── WBox.class<br />
│   ├── model<br />
│   │   └── MazeAppModel.class<br />
│   ├── ui<br />
│   │   ├── ButtonPanelpack<br />
│   │   │   ├── ArrivalButton.class<br />
│   │   │   ├── DepartureButton.class<br />
│   │   │   ├── DimensionButton.class<br />
│   │   │   ├── EmptyButton.class<br />
│   │   │   └── WallButton.class<br />
│   │   ├── MazeOptionPanel<br />
│   │   │   ├── ExportButton.class<br />
│   │   │   ├── ImportButton.class<br />
│   │   │   ├── QuitButton.class<br />
│   │   │   ├── RebootButton.class<br />
│   │   │   └── SolveButton.class<br />
│   │   ├── BoxesPanel.class<br />
│   │   ├── ButtonPanel.class<br />
│   │   ├── MBoxPanel.class<br />
│   │   ├── MazeApp.class<br />
│   │   ├── MazeOptions.class<br />
│   │   └── WindowPanel.class<br />
│   └── Main.class<br />
├── data<br />
│   ├── labyrinthe1.txt<br />
│   ├── labyrinthe2.txt<br />
│   ├── labyrinthe3.txt<br />
│   ├── labyrinthe4.txt<br />
│   ├── labyrinthe5.txt<br />
│   ├── labyrinthe_copie.txt<br />
│   └── labyrintheresolu.txt<br />
├── javadoc<br />
│   ├── class-use<br />
│   │   └── Main.html<br />
│   ├── dijkstra<br />
│   │   ├── class-use<br />
│   │   │   ├── ASet.html<br />
│   │   │   ├── ASetInterface.html<br />
│   │   │   ├── Dijkstra.html<br />
│   │   │   ├── GraphInterface.html<br />
│   │   │   ├── Pi.html<br />
│   │   │   ├── PiInterface.html<br />
│   │   │   ├── Previous.html<br />
│   │   │   ├── PreviousInterface.html<br />
│   │   │   └── VertexInterface.html<br />
│   │   ├── ASet.html<br />
│   │   ├── ASetInterface.html<br />
│   │   ├── Dijkstra.html<br />
│   │   ├── GraphInterface.html<br />
│   │   ├── Pi.html<br />
│   │   ├── PiInterface.html<br />
│   │   ├── Previous.html<br />
│   │   ├── PreviousInterface.html<br />
│   │   ├── VertexInterface.html<br />
│   │   ├── package-summary.html<br />
│   │   ├── package-tree.html<br />
│   │   └── package-use.html<br />
│   ├── index-files<br />
│   │   ├── index-1.html<br />
│   │   ├── index-10.html<br />
│   │   ├── index-11.html<br />
│   │   ├── index-12.html<br />
│   │   ├── index-13.html<br />
│   │   ├── index-14.html<br />
│   │   ├── index-15.html<br />
│   │   ├── index-16.html<br />
│   │   ├── index-17.html<br />
│   │   ├── index-18.html<br />
│   │   ├── index-2.html<br />
│   │   ├── index-3.html<br />
│   │   ├── index-4.html<br />
│   │   ├── index-5.html<br />
│   │   ├── index-6.html<br />
│   │   ├── index-7.html<br />
│   │   ├── index-8.html<br />
│   │   └── index-9.html<br />
│   ├── maze<br />
│   │   ├── class-use<br />
│   │   │   ├── ABox.html<br />
│   │   │   ├── DBox.html<br />
│   │   │   ├── EBox.html<br />
│   │   │   ├── MBox.html<br />
│   │   │   ├── Maze.html<br />
│   │   │   ├── MazeReadingException.html<br />
│   │   │   ├── PBox.html<br />
│   │   │   └── WBox.html<br />
│   │   ├── ABox.html<br />
│   │   ├── DBox.html<br />
│   │   ├── EBox.html<br />
│   │   ├── MBox.html<br />
│   │   ├── Maze.html<br />
│   │   ├── MazeReadingException.html<br />
│   │   ├── PBox.html<br />
│   │   ├── WBox.html<br />
│   │   ├── package-summary.html<br />
│   │   ├── package-tree.html<br />
│   │   └── package-use.html<br />
│   ├── model<br />
│   │   ├── class-use<br />
│   │   │   └── MazeAppModel.html<br />
│   │   ├── MazeAppModel.html<br />
│   │   ├── package-summary.html<br />
│   │   ├── package-tree.html<br />
│   │   └── package-use.html<br />
│   ├── resources<br />
│   │   ├── glass.png<br />
│   │   └── x.png<br />
│   ├── script-dir<br />
│   │   ├── images<br />
│   │   │   ├── ui-bg_glass_55_fbf9ee_1x400.png<br />
│   │   │   ├── ui-bg_glass_65_dadada_1x400.png<br />
│   │   │   ├── ui-bg_glass_75_dadada_1x400.png<br />
│   │   │   ├── ui-bg_glass_75_e6e6e6_1x400.png<br />
│   │   │   ├── ui-bg_glass_95_fef1ec_1x400.png<br />
│   │   │   ├── ui-bg_highlight-soft_75_cccccc_1x100.png<br />
│   │   │   ├── ui-icons_222222_256x240.png<br />
│   │   │   ├── ui-icons_2e83ff_256x240.png<br />
│   │   │   ├── ui-icons_454545_256x240.png<br />
│   │   │   ├── ui-icons_888888_256x240.png<br />
│   │   │   └── ui-icons_cd0a0a_256x240.png<br />
│   │   ├── jquery-3.5.1.min.js<br />
│   │   ├── jquery-ui.min.css<br />
│   │   ├── jquery-ui.min.js<br />
│   │   └── jquery-ui.structure.min.css<br />
│   ├── ui<br />
│   │   ├── ButtonPanelpack<br />
│   │   │   ├── class-use<br />
│   │   │   │   ├── ArrivalButton.html<br />
│   │   │   │   ├── DepartureButton.html<br />
│   │   │   │   ├── DimensionButton.html<br />
│   │   │   │   ├── EmptyButton.html<br />
│   │   │   │   └── WallButton.html<br />
│   │   │   ├── ArrivalButton.html<br />
│   │   │   ├── DepartureButton.html<br />
│   │   │   ├── DimensionButton.html<br />
│   │   │   ├── EmptyButton.html<br />
│   │   │   ├── WallButton.html<br />
│   │   │   ├── package-summary.html<br />
│   │   │   ├── package-tree.html<br />
│   │   │   └── package-use.html<br />
│   │   ├── MazeOptionPanel<br />
│   │   │   ├── class-use<br />
│   │   │   │   ├── ExportButton.html<br />
│   │   │   │   ├── ImportButton.html<br />
│   │   │   │   ├── QuitButton.html<br />
│   │   │   │   ├── RebootButton.html<br />
│   │   │   │   └── SolveButton.html<br />
│   │   │   ├── ExportButton.html<br />
│   │   │   ├── ImportButton.html<br />
│   │   │   ├── QuitButton.html<br />
│   │   │   ├── RebootButton.html<br />
│   │   │   ├── SolveButton.html<br />
│   │   │   ├── package-summary.html<br />
│   │   │   ├── package-tree.html<br />
│   │   │   └── package-use.html<br />
│   │   ├── class-use<br />
│   │   │   ├── BoxesPanel.html<br />
│   │   │   ├── ButtonPanel.html<br />
│   │   │   ├── MBoxPanel.html<br />
│   │   │   ├── MazeApp.html<br />
│   │   │   ├── MazeOptions.html<br />
│   │   │   └── WindowPanel.html<br />
│   │   ├── BoxesPanel.html<br />
│   │   ├── ButtonPanel.html<br />
│   │   ├── MBoxPanel.html<br />
│   │   ├── MazeApp.html<br />
│   │   ├── MazeOptions.html<br />
│   │   ├── WindowPanel.html<br />
│   │   ├── package-summary.html<br />
│   │   ├── package-tree.html<br />
│   │   └── package-use.html<br />
│   ├── Main.html<br />
│   ├── allclasses-index.html<br />
│   ├── allpackages-index.html<br />
│   ├── element-list<br />
│   ├── help-doc.html<br />
│   ├── index.html<br />
│   ├── jquery-ui.overrides.css<br />
│   ├── member-search-index.js<br />
│   ├── module-search-index.js<br />
│   ├── overview-summary.html<br />
│   ├── overview-tree.html<br />
│   ├── package-search-index.js<br />
│   ├── package-summary.html<br />
│   ├── package-tree.html<br />
│   ├── package-use.html<br />
│   ├── script.js<br />
│   ├── search.js<br />
│   ├── serialized-form.html<br />
│   ├── stylesheet.css<br />
│   ├── tag-search-index.js<br />
│   └── type-search-index.js<br />
├── src<br />
│   ├── dijkstra<br />
│   │   ├── ASet.java<br />
│   │   ├── ASetInterface.java<br />
│   │   ├── Dijkstra.java<br />
│   │   ├── GraphInterface.java<br />
│   │   ├── Pi.java<br />
│   │   ├── PiInterface.java<br />
│   │   ├── Previous.java<br />
│   │   ├── PreviousInterface.java<br />
│   │   └── VertexInterface.java<br />
│   ├── maze
│   │   ├── ABox.java
│   │   ├── DBox.java
│   │   ├── EBox.java
│   │   ├── MBox.java
│   │   ├── Maze.java
│   │   ├── MazeReadingException.java
│   │   ├── PBox.java
│   │   └── WBox.java
│   ├── model
│   │   └── MazeAppModel.java
│   ├── ui
│   │   ├── ButtonPanelpack
│   │   │   ├── ArrivalButton.java
│   │   │   ├── DepartureButton.java
│   │   │   ├── DimensionButton.java
│   │   │   ├── EmptyButton.java
│   │   │   └── WallButton.java
│   │   ├── MazeOptionPanel
│   │   │   ├── ExportButton.java
│   │   │   ├── ImportButton.java
│   │   │   ├── QuitButton.java
│   │   │   ├── RebootButton.java
│   │   │   └── SolveButton.java
│   │   ├── BoxesPanel.java
│   │   ├── ButtonPanel.java
│   │   ├── MBoxPanel.java
│   │   ├── MazeApp.java
│   │   ├── MazeOptions.java
│   │   └── WindowPanel.java
│   └── Main.java
└── README.md
