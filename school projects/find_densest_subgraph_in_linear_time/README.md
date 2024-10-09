# Find Densest Subgraph in a Graph in linear time
## Introduction
This is a project from the class [MITRO209, Graphes et partitionnement de données](https://synapses.telecom-paris.fr/catalogue/2022-2023/ue/11094/MITRO209-graphes-et-partitionnement-de-donnees?from=P4020) I took in my Master 1 in Telecom Paris. The objective was to find the desnsest subgraph in a Graph in linear time.

The libraries used for this project are quite classic and can be found in the file requirements.txt. The results obtained are commented in the code_explained.pdf. 

a simple

```
python code.py --filename <directory of the csv file> --lin_reg <True or False given if you want to plot the results>
```

will execute the code. The result will be printed in terminal.

Nota Bene the CSV_file must be in the same shame as the test.csv file (two columns named "id_1" and "id_2" defining where the edges).

Many big grahs can be found [here](https://snap.stanford.edu/data/).

## Organisation of the project
.<br />
├── README.md<br />
├── code.py<br />
├── code_explained.pdf<br />
├── requirements.txt<br />
└── test.csv<br />
