'''
    Telecom Paris January 2023
    Mitro 209 : Graph and data partitioning
    Ducottet Rémi

    Project : compute in a linear time the densest subgraph of a Graph
    Teacher : Mauro Sozio
 '''


from numpy import array
from numpy import zeros
from numpy import array2string
from sklearn.linear_model import LinearRegression
import matplotlib.pyplot as plt
import pathlib
from pandas import read_csv
from pandas import to_numeric
import argparse
import timeit

def csv_into_graph(nameFile):
    '''
    Method csv_into_graph
    this method will read a csv file and transorm it into an adjacency list
    @param nameFile: the name of the cvs file you want to read, string
    @return adjacencyList: the adjacenyList created, list of list of int
    @return M: the number of edges in the graph, int
    @return N: the number of nodes in the graph, int
    '''
    # Be careful, the name of your columns must be 'id_1' and 'id_2'
    df = read_csv(nameFile, sep=',', usecols=[
                  'id_1', 'id_2'], low_memory=False)

    # df['id_1] is list of first nodes to the edges, df['id_2'] the list of the second nodes
    df['id_1'] = to_numeric(df['id_1'], errors='coerce')
    df['id_2'] = to_numeric(df['id_2'], errors='coerce')
    temporary_list = [df['id_1'], df['id_2']]

    # now we compute the dimensions of the graph (nodes then edges)
    N = max(max(temporary_list[0]), max(
        temporary_list[1]))+1  # number of nodes
    # (there a "+1", because there is a node 0, so in fact the i-th node is named i+1)
    M = len(temporary_list[0])  # number of edges

    # creation of the adjacency list without counting twice the nodes that are linked to themselves
    adjacencyList = [[] for j in range(N)]
    for i in range(0, len(temporary_list[0])):
        adjacencyList[temporary_list[0][i]].append(temporary_list[1][i])
        if temporary_list[0][i] != temporary_list[1][i]:
            adjacencyList[temporary_list[1][i]].append(temporary_list[0][i])
    return adjacencyList, M, N






def pick_a_node(index_of_smallest_node, nodes_degree_list):
    '''
    Method pick_a_node
    this method will compute the index_of_smallest_node and will return the node we will delete
    @param index_of_smallest_node,the degree of the node we will delete, int
    @param nodes_degree_list, list is sorted by the degree of the nodes,
    @return node, the node to delete
    '''
    while ((index_of_smallest_node < N) & (len(nodes_degree_list[index_of_smallest_node]) == 0)):
        index_of_smallest_node = index_of_smallest_node+1
    return nodes_degree_list[index_of_smallest_node][-1]




def delete_one_node(index_of_smallest_node, nodes_degree_list):
    '''
    delete_one_node
    this method will delete a node from our graph (though it won't modify our adjacencyList!)
    @param index_of_smallest_node,the degree of the node we will delete, int
    @param nodes_degree_list, list is sorted by the degree of the nodes,
    @return degree, the degree of the node that has just been deleted
    '''
    # here is our node we will delete
    node = pick_a_node(index_of_smallest_node, nodes_degree_list)

    # this list if the list of neughbors of our node + the node that are already deleted in the graph, we must be very careful
    node_neighbors = adjacencyList[node]

    degree = number_of_neighbors[node]
    node_deleted.append(node)

    # the index of smallest node may become smaller as some nodes loose a neighbor
    index_of_smallest_node = max(index_of_smallest_node-1, 1)

    # here we delete the node in our graph, without deleting it of the Adjacency list
    nodes_degree_list[0].append(node)
    nodes_degree_list[degree].pop()
    number_of_neighbors[node] = 0
    position_in_nodes_degree_list[node] = len(nodes_degree_list[0])-1

    # removing one node must have some consequencies on the neighbors, but be careful, neighbor might already be suppressed
    for neighbor in node_neighbors:

        # with this if we get rid of the case where neighbor isn't part of the graph anymore
        if number_of_neighbors[neighbor] != 0:

            # real number of neighbors of the node neighbor (that is himself the neighbor of node)
            degree_node = number_of_neighbors[neighbor]

            # list of the nodes with the same number of neighbors as neighbor
            degree_list = nodes_degree_list[degree_node]
            pos = position_in_nodes_degree_list[neighbor]

            # here we want to use the pop() method that is O(1), so we are placing neighbor at the end of his list, by switching his place with the last node
            if (pos < len(degree_list)-1):
                temp = degree_list[-1]
                pos_temp = position_in_nodes_degree_list[temp]
                position_in_nodes_degree_list[temp], position_in_nodes_degree_list[
                    neighbor] = position_in_nodes_degree_list[neighbor], position_in_nodes_degree_list[temp]
                degree_list[pos], degree_list[pos_temp] = degree_list[pos_temp], degree_list[pos]

            # now the degree of neighbor must be disminished by one
            degree_list.pop()
            new_degree = degree_node-1
            number_of_neighbors[neighbor] = new_degree
            new_size = nodes_degree_list[new_degree]
            position_in_nodes_degree_list[neighbor] = len(new_size)
            new_size.append(neighbor)
    return degree



if __name__ == "__main__":

    parser = argparse.ArgumentParser()
    parser.add_argument("--filename", type=str, default="test.csv", help="filename of my csv file")
    parser.add_argument("--lin_reg", type=bool, default=False, help="decide wether we'll plot or not ")
    args = parser.parse_args()

    # Creation of the list
    filename = args.filename
    my_path = pathlib.Path(__file__).parent.resolve()
    path_to_csv = my_path/filename

    adjacencyList, M, N = csv_into_graph(path_to_csv)

    # The following list reprensents the degree of each node, for instance, the node i has number_of_neighbors[i] neighbors
    number_of_neighbors = []
    for i in range(N):
        number_of_neighbors.append(len(adjacencyList[i]))

    # density of the graph
    density = M/N

    # The following list is sorted by the degree of the nodes. For instance nodes_degree_list[i] is the list of the nodes that have a degree of i.
    nodes_degree_list = [[] for _ in range(N+1)]

    # The following list is more or less a list of pointers. It tells the position of a node in the list nodes_degree_list
    position_in_nodes_degree_list = []
    for i in range(0, N):
        nodes_degree_list[len(adjacencyList[i])].append(i)
        position_in_nodes_degree_list.append(
            len(nodes_degree_list[len(adjacencyList[i])])-1)
    # this index is_the index of the smallest degree in the list of nodes
    index_of_smallest_node = 1

    # this list will be filled by the nodes we delete at each step
    node_deleted = []

    # search of the best degree
    t0 = timeit.default_timer()
    n = N
    m = M
    n_opti = n

    # best graph is the number of time we run the method delete_one_node() before obtaining this density
    best_graph = 0
    step = 0


    while len(nodes_degree_list[0]) != N-2:
        degree = delete_one_node(index_of_smallest_node, nodes_degree_list)
        m = m-degree
        n = N-len(nodes_degree_list[0])+1
        new_density = m/n
        if new_density >= density:
            density = new_density
            best_graph = step
            n_opti = n
        step += 1


    # now we want to know which nodes will still be part of the graph, so first we create the list of N zeros that will represent the deleted nodes.
    complementary_remaining_nodes = zeros(N)
    test = 0

    for deleted in node_deleted:
        if test < best_graph:
            complementary_remaining_nodes[deleted] = 1
            test += 1

    nodes_of_the_densest_subgraph = []
    for i in range(N):
        if complementary_remaining_nodes[i] != 1:
            nodes_of_the_densest_subgraph.append(i)

    t1 = timeit.default_timer()

    # Let's print the result of what we found.

    print(f'Your initial graph  {filename} had {M} edges, {N} nodes, and a density of {round(M/N, 2)}.\n')
    print(f'This algorithm computed in {t1-t0} seconds his densest subgraph.\n')
    print(f'It found that the optimal densest subgraph has {n_opti} nodes, and a density of {round(density, 2)}. We could compare this density to the density of the clique with the same number of nodes : {round((n_opti-1)/2, 2)}. Hence we have the following clique density, {round(density*2/(n_opti-1), 2)} \n')
    print(f'The nodes that are part of the densest subgraph are available in the variable "nodes_of_the_densest_subgraph". Yet, I can not find the best graph in O(n+m).')

    # Here is the part to plot my complexity
    plot_name = ["musae_PTBR_edges", "facebook_combined", "musae_ES_edges",
                "musae_FR_edges", "musae_facebook_edges", "Email-EuAll"]

    if args.lin_reg :
    # Here I executed the code above, and for filename in plot_name, I wrote down the number of edges, of nodes and the time of execution
        plot_nodes = [1912, 4039, 4648, 6549, 22470, 203088]
        plot_edges = [31299, 88234, 59382, 127094, 171002, 420045]

        # here is the list of number of nodes + number of edges
        plot_complexity = [x+y for x, y in zip(plot_nodes, plot_edges)]

        # this list was computd after running the script above 25 times and then i computed the average value
        plot_time_to_execute = [1.12, 3.17, 1.95, 3.7, 5.53, 15.36]


        plt.title("Time of execution\n of the algorithm\n depending on |E|+|V|")
        plt.scatter(plot_complexity, plot_time_to_execute)


        plot_complexity = array(plot_complexity).reshape((-1, 1))
        plot_time_to_execute = array(plot_time_to_execute)
        model = LinearRegression()
        model.fit(plot_complexity, plot_time_to_execute)
        model = LinearRegression().fit(plot_complexity, plot_time_to_execute)
        b = model.intercept_
        a = model.coef_
        plot_reg = [a*x+b for x in plot_complexity]
        st = "R²=" + str(round(model.score(plot_complexity, plot_time_to_execute), 3)
                        ) + "\n y =" + array2string(a) + "x+" + array2string(b)
        # we can plot the equation of the linear regression too but the plot becomes less readable so i would rather not.

        plt.plot(plot_complexity, plot_reg, label=st)
        plt.xlabel("|V|+|E|")
        plt.ylabel("time of execution (in seconds)")
        plt.legend(loc="lower right")
        plt.show()
