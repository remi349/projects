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
│   ├── model
│   │   └── MazeAppModel.class
│   ├── ui
│   │   ├── ButtonPanelpack
│   │   │   ├── ArrivalButton.class
│   │   │   ├── DepartureButton.class
│   │   │   ├── DimensionButton.class
│   │   │   ├── EmptyButton.class
│   │   │   └── WallButton.class
│   │   ├── MazeOptionPanel
│   │   │   ├── ExportButton.class
│   │   │   ├── ImportButton.class
│   │   │   ├── QuitButton.class
│   │   │   ├── RebootButton.class
│   │   │   └── SolveButton.class
│   │   ├── BoxesPanel.class
│   │   ├── ButtonPanel.class
│   │   ├── MBoxPanel.class
│   │   ├── MazeApp.class
│   │   ├── MazeOptions.class
│   │   └── WindowPanel.class
│   └── Main.class
├── data
│   ├── labyrinthe1.txt
│   ├── labyrinthe2.txt
│   ├── labyrinthe3.txt
│   ├── labyrinthe4.txt
│   ├── labyrinthe5.txt
│   ├── labyrinthe_copie.txt
│   └── labyrintheresolu.txt
├── javadoc
│   ├── class-use
│   │   └── Main.html
│   ├── dijkstra
│   │   ├── class-use
│   │   │   ├── ASet.html
│   │   │   ├── ASetInterface.html
│   │   │   ├── Dijkstra.html
│   │   │   ├── GraphInterface.html
│   │   │   ├── Pi.html
│   │   │   ├── PiInterface.html
│   │   │   ├── Previous.html
│   │   │   ├── PreviousInterface.html
│   │   │   └── VertexInterface.html
│   │   ├── ASet.html
│   │   ├── ASetInterface.html
│   │   ├── Dijkstra.html
│   │   ├── GraphInterface.html
│   │   ├── Pi.html
│   │   ├── PiInterface.html
│   │   ├── Previous.html
│   │   ├── PreviousInterface.html
│   │   ├── VertexInterface.html
│   │   ├── package-summary.html
│   │   ├── package-tree.html
│   │   └── package-use.html
│   ├── index-files
│   │   ├── index-1.html
│   │   ├── index-10.html
│   │   ├── index-11.html
│   │   ├── index-12.html
│   │   ├── index-13.html
│   │   ├── index-14.html
│   │   ├── index-15.html
│   │   ├── index-16.html
│   │   ├── index-17.html
│   │   ├── index-18.html
│   │   ├── index-2.html
│   │   ├── index-3.html
│   │   ├── index-4.html
│   │   ├── index-5.html
│   │   ├── index-6.html
│   │   ├── index-7.html
│   │   ├── index-8.html
│   │   └── index-9.html
│   ├── maze
│   │   ├── class-use
│   │   │   ├── ABox.html
│   │   │   ├── DBox.html
│   │   │   ├── EBox.html
│   │   │   ├── MBox.html
│   │   │   ├── Maze.html
│   │   │   ├── MazeReadingException.html
│   │   │   ├── PBox.html
│   │   │   └── WBox.html
│   │   ├── ABox.html
│   │   ├── DBox.html
│   │   ├── EBox.html
│   │   ├── MBox.html
│   │   ├── Maze.html
│   │   ├── MazeReadingException.html
│   │   ├── PBox.html
│   │   ├── WBox.html
│   │   ├── package-summary.html
│   │   ├── package-tree.html
│   │   └── package-use.html
│   ├── model
│   │   ├── class-use
│   │   │   └── MazeAppModel.html
│   │   ├── MazeAppModel.html
│   │   ├── package-summary.html
│   │   ├── package-tree.html
│   │   └── package-use.html
│   ├── resources
│   │   ├── glass.png
│   │   └── x.png
│   ├── script-dir
│   │   ├── images
│   │   │   ├── ui-bg_glass_55_fbf9ee_1x400.png
│   │   │   ├── ui-bg_glass_65_dadada_1x400.png
│   │   │   ├── ui-bg_glass_75_dadada_1x400.png
│   │   │   ├── ui-bg_glass_75_e6e6e6_1x400.png
│   │   │   ├── ui-bg_glass_95_fef1ec_1x400.png
│   │   │   ├── ui-bg_highlight-soft_75_cccccc_1x100.png
│   │   │   ├── ui-icons_222222_256x240.png
│   │   │   ├── ui-icons_2e83ff_256x240.png
│   │   │   ├── ui-icons_454545_256x240.png
│   │   │   ├── ui-icons_888888_256x240.png
│   │   │   └── ui-icons_cd0a0a_256x240.png
│   │   ├── jquery-3.5.1.min.js
│   │   ├── jquery-ui.min.css
│   │   ├── jquery-ui.min.js
│   │   └── jquery-ui.structure.min.css
│   ├── ui
│   │   ├── ButtonPanelpack
│   │   │   ├── class-use
│   │   │   │   ├── ArrivalButton.html
│   │   │   │   ├── DepartureButton.html
│   │   │   │   ├── DimensionButton.html
│   │   │   │   ├── EmptyButton.html
│   │   │   │   └── WallButton.html
│   │   │   ├── ArrivalButton.html
│   │   │   ├── DepartureButton.html
│   │   │   ├── DimensionButton.html
│   │   │   ├── EmptyButton.html
│   │   │   ├── WallButton.html
│   │   │   ├── package-summary.html
│   │   │   ├── package-tree.html
│   │   │   └── package-use.html
│   │   ├── MazeOptionPanel
│   │   │   ├── class-use
│   │   │   │   ├── ExportButton.html
│   │   │   │   ├── ImportButton.html
│   │   │   │   ├── QuitButton.html
│   │   │   │   ├── RebootButton.html
│   │   │   │   └── SolveButton.html
│   │   │   ├── ExportButton.html
│   │   │   ├── ImportButton.html
│   │   │   ├── QuitButton.html
│   │   │   ├── RebootButton.html
│   │   │   ├── SolveButton.html
│   │   │   ├── package-summary.html
│   │   │   ├── package-tree.html
│   │   │   └── package-use.html
│   │   ├── class-use
│   │   │   ├── BoxesPanel.html
│   │   │   ├── ButtonPanel.html
│   │   │   ├── MBoxPanel.html
│   │   │   ├── MazeApp.html
│   │   │   ├── MazeOptions.html
│   │   │   └── WindowPanel.html
│   │   ├── BoxesPanel.html
│   │   ├── ButtonPanel.html
│   │   ├── MBoxPanel.html
│   │   ├── MazeApp.html
│   │   ├── MazeOptions.html
│   │   ├── WindowPanel.html
│   │   ├── package-summary.html
│   │   ├── package-tree.html
│   │   └── package-use.html
│   ├── Main.html
│   ├── allclasses-index.html
│   ├── allpackages-index.html
│   ├── element-list
│   ├── help-doc.html
│   ├── index.html
│   ├── jquery-ui.overrides.css
│   ├── member-search-index.js
│   ├── module-search-index.js
│   ├── overview-summary.html
│   ├── overview-tree.html
│   ├── package-search-index.js
│   ├── package-summary.html
│   ├── package-tree.html
│   ├── package-use.html
│   ├── script.js
│   ├── search.js
│   ├── serialized-form.html
│   ├── stylesheet.css
│   ├── tag-search-index.js
│   └── type-search-index.js
├── src
│   ├── dijkstra
│   │   ├── ASet.java
│   │   ├── ASetInterface.java
│   │   ├── Dijkstra.java
│   │   ├── GraphInterface.java
│   │   ├── Pi.java
│   │   ├── PiInterface.java
│   │   ├── Previous.java
│   │   ├── PreviousInterface.java
│   │   └── VertexInterface.java
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
