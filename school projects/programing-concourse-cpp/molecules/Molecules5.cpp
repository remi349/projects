#include <stdio.h>
#include <algorithm>
#include <cmath>

using namespace std;
bool isCyclicUtil(int v, vector<int> adj[], bool visited[], bool recStack[]);

bool isCyclic(int V, vector<int> adj[]);

struct mol
{
    int number;
    int letter;
    int sign;
    // int orientation; // N = 1 ; S = -1 ; O = 2 ; E = - 2
    bool can_it_be_fixed(mol mol)
    {
        return (sign + mol.sign == 0 && letter == mol.letter);
    }
};

int main()
{
    int n_tests;
    while (scanf("%d", &n_tests) == 1)
    {
        char useless;
        scanf("%c", &useless);
        // printf("%d", n_tests);
        char temp[5];
        char sign[5];
        int nsign[5];
        vector<int> Adj[40 * n_tests] = {};
        mol mols[40 * n_tests];

        for (int i = 0; i < n_tests; i++)
        {

            for (int j = 1; j < 5; j++)
            {
                scanf("%c %c", &temp[j], &sign[j]);
                // printf("c1=%c\n", temp[j]);
                // printf("c2=%c\n", sign[j]);
                if (sign[j] == 0)
                {
                    nsign[j] = 3;
                }
                else if (sign[j] == '+')
                {
                    nsign[j] = 1;
                }
                else
                {
                    nsign[j] = -1;
                }
            }
            scanf("%c", &useless);

            // first
            mols[40 * i] = {40 * i, '0', 0};
            mols[40 * i + 1] = {40 * i + 1, temp[1], nsign[1]}; // 2 3
            mols[40 * i + 3] = {40 * i + 3, temp[2], nsign[2]};
            mols[40 * i + 2] = {40 * i + 2, temp[3], nsign[3]};
            mols[40 * i + 4] = {40 * i + 4, temp[4], nsign[4]};
            Adj[40 * i] = {40 * i + 1, 40 * i + 4};
            Adj[40 * i + 2] = {40 * i};
            Adj[40 * i + 3] = {40 * i};

            // second
            mols[40 * i + 5] = {40 * i + 5, '0', 0}; //- 8
            mols[40 * i + 7] = {40 * i + 7, temp[1], nsign[1]};
            mols[40 * i + 8] = {40 * i + 8, temp[2], nsign[2]};
            mols[40 * i + 6] = {40 * i + 6, temp[3], nsign[3]};
            mols[40 * i + 9] = {40 * i + 9, temp[4], nsign[4]};
            Adj[40 * i + 5] = {40 * i + 6, 40 * i + 9};
            Adj[40 * i + 8] = {40 * i + 5};
            Adj[40 * i + 7] = {40 * i + 5};

            // third
            mols[40 * i + 10] = {40 * i + 10, '0', 0}; // 11 12 13 14
            mols[40 * i + 13] = {40 * i + 13, temp[1], nsign[1]};
            mols[40 * i + 11] = {40 * i + 11, temp[2], nsign[2]};
            mols[40 * i + 14] = {40 * i + 14, temp[3], nsign[3]};
            mols[40 * i + 12] = {40 * i + 12, temp[4], nsign[4]};
            Adj[40 * i + 10] = {40 * i + 11, 40 * i + 14};
            Adj[40 * i + 12] = {40 * i + 10};
            Adj[40 * i + 13] = {40 * i + 10};

            // fourth
            mols[40 * i + 15] = {40 * i + 15, '0', 0}; // 17 19
            mols[40 * i + 16] = {40 * i + 16, temp[1], nsign[1]};
            mols[40 * i + 19] = {40 * i + 19, temp[2], nsign[2]};
            mols[40 * i + 17] = {40 * i + 17, temp[3], nsign[3]};
            mols[40 * i + 18] = {40 * i + 18, temp[4], nsign[4]};
            Adj[40 * i + 15] = {40 * i + 16, 40 * i + 19};
            Adj[40 * i + 18] = {40 * i + 15};
            Adj[40 * i + 17] = {40 * i + 15};

            // fifth
            mols[40 * i + 20] = {40 * i + 20, '0', 0}; // 21 23
            mols[40 * i + 22] = {40 * i + 22, temp[1], nsign[1]};
            mols[40 * i + 23] = {40 * i + 23, temp[2], nsign[2]};
            mols[40 * i + 21] = {40 * i + 21, temp[3], nsign[3]};
            mols[40 * i + 24] = {40 * i + 24, temp[4], nsign[4]};
            Adj[40 * i + 20] = {40 * i + 21, 40 * i + 24};
            Adj[40 * i + 23] = {40 * i + 20};
            Adj[40 * i + 22] = {40 * i + 20};

            // sixth
            mols[40 * i + 25] = {40 * i + 25, '0', 0}; // 26 27 28 29
            mols[40 * i + 28] = {40 * i + 28, temp[1], nsign[1]};
            mols[40 * i + 26] = {40 * i + 26, temp[2], nsign[2]};
            mols[40 * i + 29] = {40 * i + 29, temp[3], nsign[3]};
            mols[40 * i + 27] = {40 * i + 27, temp[4], nsign[4]};
            Adj[40 * i + 25] = {40 * i + 26, 40 * i + 29};
            Adj[40 * i + 27] = {40 * i + 25};
            Adj[40 * i + 28] = {40 * i + 25};

            // seventh
            mols[40 * i + 30] = {40 * i + 30, '0', 0}; // 32 34
            mols[40 * i + 31] = {40 * i + 31, temp[1], nsign[1]};
            mols[40 * i + 34] = {40 * i + 34, temp[2], nsign[2]};
            mols[40 * i + 32] = {40 * i + 32, temp[3], nsign[3]};
            mols[40 * i + 33] = {40 * i + 33, temp[4], nsign[4]};
            Adj[40 * i + 30] = {40 * i + 31, 40 * i + 34};
            Adj[40 * i + 33] = {40 * i + 30};
            Adj[40 * i + 32] = {40 * i + 30};

            // heigth
            mols[40 * i + 35] = {40 * i + 35, '0', 0};
            mols[40 * i + 36] = {40 * i + 36, temp[1], nsign[1]};
            mols[40 * i + 38] = {40 * i + 38, temp[2], nsign[2]};
            mols[40 * i + 37] = {40 * i + 37, temp[3], nsign[3]};
            mols[40 * i + 39] = {40 * i + 39, temp[4], nsign[4]};
            Adj[40 * i + 35] = {40 * i + 36, 40 * i + 39};
            Adj[40 * i + 37] = {40 * i + 35};
            Adj[40 * i + 38] = {40 * i + 35};
        }

        for (int i = 1; i < 40 * n_tests; i += 5)
        {
            for (int j = 2; j < 40 * n_tests; j += 5)
            {
                if (mols[i].can_it_be_fixed(mols[j]))
                {
                    Adj[i].push_back(j);
                }
            }
        }

        for (int i = 4; i < 40 * n_tests; i += 5)
        {
            for (int j = 3; j < 40 * n_tests; j += 5)
            {
                if (mols[i].can_it_be_fixed(mols[j]))
                {
                    Adj[i].push_back(j);
                }
            }
        }

        if (isCyclic(40 * n_tests, Adj))
        {
            printf("unbounded\n");
        }
        else
        {
            printf("bounded\n");
        }
    }
    return 0;
}

// code borrowed to check if there is a cycle in a graph
bool isCyclicUtil(int v, vector<int> adj[], bool visited[], bool recStack[])
{
    visited[v] = true;
    recStack[v] = true;

    for (int u : adj[v])
    {
        if (!visited[u] && isCyclicUtil(u, adj, visited, recStack))
            return true;
        else if (recStack[u])
            return true;
    }

    recStack[v] = false;
    return false;
}

bool isCyclic(int V, vector<int> adj[])
{
    bool visited[V] = {false};
    bool recStack[V] = {false};

    for (int v = 0; v < V; v++)
    {
        if (!visited[v])
        {
            if (isCyclicUtil(v, adj, visited, recStack))
                return true;
        }
    }

    return false;
}
