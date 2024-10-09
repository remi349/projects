
import csv
import math
import matplotlib.pyplot as plt
import numpy as np
from mpl_toolkits.mplot3d import Axes3D

files = ["deplacement_30_6_10_46_55.csv",
"deplacement_30_6_10_47_37.csv",
"deplacement_30_6_10_48_18.csv",
"deplacement_30_6_10_48_58.csv",
"deplacement_30_6_10_49_35.csv",
"deplacement_30_6_10_50_16.csv",
"deplacement_30_6_10_51_7.csv",
"deplacement_30_6_10_51_45.csv",
"deplacement_30_6_10_53_17.csv"]

chemin = ""


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

def calcAverageVelocity(tab) :
    """
    input :
    tab : a list of 3 lists : x, y, t
    output :
    vel : velocity vector
    """
    #print(tab)
    x_reg = np.polyfit(tab[2], tab[0], 1)
    y_reg = np.polyfit(tab[2], tab[1], 1)
    return (x_reg [0], y_reg[0])



def normalize_angle(angle):
    """
    set the angle between 0 and 2pi
    input : float
    output : float
    """
    if angle<0 :
        return angle+2*np.pi
    if angle>2*np.pi :
        return angle-2*np.pi
    return angle



angles = []
angles2 = []
error_angle = 0

norm = []
norm2 = []
error_norm = 0

fig, axs = plt.subplots(3,3)

for i in range(9) :
    chemin = files[i]
    tracer = readcsv()

    #define the index slices corresponding to the
    #period just before the merge
    i_min = len(tracer[1][1])-70
    i_max = len(tracer[1][1])
    tab1 = [tracer[0][0][i_min:i_max], tracer[0][1][i_min:i_max], tracer[0][2][i_min:i_max]]
    tab2 = [tracer[1][0][i_min:i_max], tracer[1][1][i_min:i_max], tracer[1][2][i_min:i_max]]

    #v1 and v2 are the velocities of the two clusters before they merge
    v1 = calcAverageVelocity(tab1)
    v2 = calcAverageVelocity(tab2)

    #define the index slices corresponding to the
    #period after the merge
    i_min = len(tracer[1][1])+20
    i_max = len(tracer[1][1])+90
    tab3 = [tracer[0][0][i_min:i_max], tracer[0][1][i_min:i_max], tracer[0][2][i_min:i_max]]

    #v3 is the velocity of the remaining cluster after the merge
    v3 = calcAverageVelocity(tab3)

    #direction of the movement for each velocity
    angle1 = np.arctan2(v1[0],v1[1])
    angle2 = np.arctan2(v2[0],v2[1])
    angle3 = np.arctan2(v3[0],v3[1])

    diff1 = normalize_angle(angle2-angle3)
    diff2 = normalize_angle(angle2-angle1)


    angle = diff1 /diff2
    angles.append(angle)
    norm.append(np.linalg.norm(v3))



    #v4 : prediction using conservation of momentum
    p1 = (i+1)*0.1 #proportion of the boids from the first cluster
    p2 = 1-p1 #proportion of the boids from the second cluster
    v4 = [p1*v1[0]+p2*v2[0],p1*v1[1]+p2*v2[1]]

    #direction of the movement for each velocity
    angle4 = np.arctan2(v4[0],v4[1])
    diff1 = normalize_angle(angle2-angle4)
    angle2 = diff1 /diff2
    angles2.append(angle2)
    norm2.append(np.linalg.norm(v4))

    error_angle += abs(angle2-angle)/angle
    error_norm += abs(np.linalg.norm(v4)-np.linalg.norm(v3))/np.linalg.norm(v3)

    axs[i//3, i%3].plot([0,v1[0]], [0,v1[1]], color = 'blue', label='v1 before the merge')
    axs[i//3, i%3].plot([0,v2[0]], [0,v2[1]], color = 'green',label='v2 before the merge')
    axs[i//3, i%3].plot([0,v3[0]], [0,v3[1]], color = 'red',label='velocity after the merge')
    axs[i//3, i%3].plot([0,v4[0]], [0,v4[1]], color = 'grey',label='velocity predicted with conservation of momentum')
    axs[i//3, i%3].set_title('N1 = '+str(10*(i+1))+', N2 = '+str(90-10*i), fontsize=10)
    axs[i//3, i%3].set_aspect('equal','box')





fig.tight_layout()
plt.show()


fig, axs = plt.subplots(2,1)


axs[0].scatter([0.1*(1+k) for k in range(9)], angles2, color = 'grey',label = 'predicted angles')

axs[0].scatter([0.1*(1+k) for k in range(9)], angles, color = 'red',label = 'observed angles')
axs[0].set_title('angles of the velocities')
axs[0].set_xlabel('N1/N')
axs[0].set_ylabel('relative angle')
axs[0].legend()

plt.ylim([0,2])

axs[1].scatter([0.1*(1+k) for k in range(9)], norm2, color = 'grey',label = 'predicted norm')

axs[1].scatter([0.1*(1+k) for k in range(9)], norm, color = 'red',label = 'observed norm')
axs[1].set_title('norms of the velocities')
axs[1].set_xlabel('N1/N')
axs[1].set_ylabel('norm of velocity')

axs[1].legend()
plt.ylim([0,2])
fig.tight_layout()
plt.show()

print("error angle :",error_angle/9)
print("error norm :",error_norm/9)

