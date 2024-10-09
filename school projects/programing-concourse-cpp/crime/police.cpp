#include <stdio.h>
#include <cmath>
#include <list>
#include <vector>
#include <stack>
#include <algorithm>

using namespace std;
const int NMAX = 1001;

int connex_parts(vector<int> adjacency_list[], int flag[]);
int main()
{
    int nodes, edges, node1, node2, number_police_men;
    int mistaken;
    number_police_men = 0;
    mistaken = 0;
    while (scanf("%d", &nodes) == 1)
    {
        int flag[nodes];
        // initialisation of the list
        scanf("%d", &edges);
        // vector<list<int> > adj(nodes);
        vector<int> adj[nodes]; // careful
        for (int i = 0; i < edges; i++)
        {
            scanf("%d", &node1);
            scanf("%d", &node2);
            adj[node1].push_back(node2);
            adj[node2].push_back(node1);
        }
        // count the number of convex components
        int number_connected_components = connex_parts(adj, flag);
        for (int connex = 0; connex < number_connected_components; connex++)
        {
            vector<int> connex_part;
            for (int i = 0; i < nodes; i++)
            {
                if (flag[i] == connex)
                {
                    connex_part.push_back(i);
                }
            }
            int size_connex = connex_part.size();

            if (size_connex > 1)
            {
                int n_ones = 0;
                int colors[size_connex];
                for (int i = 0; i < size_connex; i++)
                {
                    colors[i] = -1;
                }
                colors[0] = 0;
                stack<int> numbersStack;
                for (auto neighbor : adj[0])
                {
                    colors[neighbor] = 1;
                    n_ones += 1;
                    numbersStack.push_back(neighbor);
                }
                while (!numbersStack.empty())
                {
                    int temp = numbersStack.top();
                    numbersStack.pop();
                    int c = colors[temp];
                    for (auto neighbor : adj[temp])
                    {
                        if (colors[neighbor] == -1)
                        {
                            numbersStack.push_back(neighbor);
                            colors[neighbor] = 1 - c;
                            n_ones += 1 - c;
                        }
                        if (colors[neighbor] == c)
                        {
                            mistaken = 1;
                        }
                    }
                }
                number_police_men += min(n_ones, size_connex - n_ones);
            }
        }
        if (mistaken == 1)
        {
            printf("Impossible\n")
        }
        else
        {
            printf("%d\n", number_police_men);
        }
    }
    return (0);
}

// count the number of convexes components
int connex_parts(vector<int> adjacency_list[], int flag[])
{
    int N = adjacency_list.size();
    for (int i = 0; i < N; i++)
    {
        flag[i] = -1;
    }
    int number_connected_components = 0;
    for (int node = 0; node < N; node++)
    {
        if (flag[node] != -1)
        {
            flag[node] = number_connected_components;
            stack<int> numbersStack;
            for (int neighbor : adjacency_list[node])
            {
                if (flag[neighbor] != -1)
                {
                    numbersStack.push_back(neighbor);
                }
            }
            while (!numbersStack.empty())
            {
                int temp = numberStack.top();
                numbersStack.pop();
                flag[temp] = number_connected_components;
                for (int neighbor : adjacency_list[temp])
                {
                    if (flag[neighbor] == -1)
                    {
                        numbersStack.push_back(neighbor);
                    }
                }
            }
            number_connected_components++;
        }
    }
    return number_connected_components;
}