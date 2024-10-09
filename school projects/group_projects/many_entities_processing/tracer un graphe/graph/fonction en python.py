import csv
import math
import matplotlib.pyplot as plt
import numpy as np
from mpl_toolkits.mplot3d import Axes3D

chemin = "./csv/deplacement_date"

differentPlotsSwarnI()

def readcsv():
    f=open(chemin)
    myReader=csv.reader(f)
    tracer=[]
    nrow=0
    for row in myReader:
        if nrow==0:
            for i in range(0,len(row)//3):
                tracer+=[[[],[],[]]]
        if nrow!=0:
            ncolumn=0
            for element in row :
                if (element != ""):
                    tracer[ncolumn//3][ncolumn%3]+=[float(element)]
                    ncolumn+=1
        nrow+=1
    f.close()
    return tracer

def plot3D() :
    tracer = readcsv()
    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')

    for i in range (0, len(tracer)) :
        X=tracer[i][0]
        Y=tracer[i][1]
        T=tracer[i][2]
        ax.plot(xs=X, ys=Y, zs=T,label="courbe 3D, X,Y et T")

    plt.legend()
    plt.show()



def differentPlotsSwarnI():
    tracer = readcsv()
    #tracé courbe 1
    plot=plt.figure(1)
    plt.axis('equal')
    plt.axis ([0,800,0,maxTime(tracer)])
    for i in range (0, len(tracer)) :
        X=tracer[i][0]
        T=tracer[i][2]
        plt.plot(T,X, label="X en fonction de T, Courbe"+ str(i))
    plt.legend()

    #tracé courbe 2
    plot=plt.figure(2)
    plt.axis('equal')
    plt.axis ([0,800,0,maxTime(tracer)])
    for i in range (0, len(tracer)) :
        Y=tracer[i][1]
        T=tracer[i][2]
        plt.plot(T,Y, label="Y en fonction de T, Courbe"+ str(i))
    plt.legend()


    #tracé courbe 3
    plot=plt.figure(3)
    plt.axis('equal')
    plt.axis ([0,800,0,800])
    for i in range (0, len(tracer)) :
        X=tracer[i][0]
        Y=tracer[i][1]
        plt.plot(X,Y, label="Y en fonction de X, Courbe"+ str(i))
    plt.legend()

    #tracé courbe 3D
    plot3D()

    #afficher tout ça
    plt.show()


#fonction qui permet juste de choisir un bon odg pour la fenêtre
def maxTime(tracer):
    t=0
    for i in range (0, len(tracer)) :
        if(len(tracer[i][2])>t):
            t=len(tracer[i][2])
    return t