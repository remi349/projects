#include <stdio.h>
#include <algorithm>
#include <set>
#include <cmath>
#include <map>
#include <stack>
using namespace std;
const int NMAX = 1000;
const int NBCOLORS = 50;
vector<int> findEulerianCycle(vector<vector<int>> &graph, int firstNode);
void dfs(vector<vector<int>> &graph, vector<bool> &visited, int currentVertex, stack<int> &cycle);
int main()
{

    int T;
    int n_pearls;
    int s1, s2;
    int first;
    scanf("%d", &T);

    for (int n_loop = 0; n_loop < T; n_loop++)
    {

        vector<vector<int>> adjList(NMAX + NBCOLORS);

        vector<int> degree(NMAX + NBCOLORS);
        printf("Case #%d\n", n_loop + 1);
        scanf("%d", &n_pearls);
        int nb_sommets[NBCOLORS] = {};
        pair<int, int> edges[n_pearls] = {};
        for (int i = 0; i < n_pearls; i++)
        {
            scanf("%d", &s1);
            scanf("%d", &s2);
            edges[i] = make_pair(s1, s2);
            if (i == 0)
            {
                nb_sommets[s1]++;
                nb_sommets[s2]++;
                first = s1 - 1;
            }

            adjList[s1 - 1].push_back(NBCOLORS + i);
            adjList[s2 - 1].push_back(NBCOLORS + i);
            adjList[NBCOLORS + i].push_back(s1 - 1);
            adjList[NBCOLORS + i].push_back(s2 - 1);
            degree[s1 - 1]++;
            degree[s2 - 1]++;
            degree[NBCOLORS + i]++;
            degree[NBCOLORS + i]++;
        }
        bool pair = false;
        for (int deg : degree)
        {
            if (deg % 2 != 0)
            {
                pair = true;
            }
        }
        if (pair)
        {
            printf("some beads may be lost\n\n");
            continue;
        }
        vector<int> eulerianCycle = findEulerianCycle(adjList, first);
        int s = eulerianCycle.size();
        // printf("taille = %d\n", s);
        int nb__sommet = 0;
        for (int nb : nb_sommets)
        {
            if (nb != 0)
            {
                nb__sommet++;
            }
        }
        // printf("taille2 = %d\n", n_pearls + nb__sommet);
        if (eulerianCycle.size() < n_pearls + nb__sommet)
        {
            printf("some beads may be lost\n\n");
            continue;
        }
        int old = -1;
        int newn;
        for (int n : eulerianCycle)
        {

            if (n >= 50)
            {
                int s1 = edges[n - NBCOLORS].first;
                int s2 = edges[n - NBCOLORS].second;
                if (old == -1)
                {
                    printf("%d ", s1);
                    printf("%d\n", s2);
                    old = s2;
                }
                else
                {
                    printf("%d ", old);
                    if (old == s1)
                    {
                        old = s2;
                    }
                    else
                    {
                        old = s1;
                    }
                    printf("%d\n", old);
                }
            }
        }
        printf("\n");
    }
    return 0;
}

// Hierholzer's algorithm
void dfs(int v, vector<std::vector<int>> &graph, vector<bool> &visited, vector<int> &cycle)
{
    visited[v] = true;

    for (int u : graph[v])
    {
        if (!visited[u])
        {
            dfs(u, graph, visited, cycle);
        }
    }

    cycle.push_back(v);
}

vector<int> findEulerianCycle(vector<vector<int>> &graph, int firstNode)
{
    vector<int> eulerianCycle;
    vector<bool> visited(NMAX + NBCOLORS, false);

    int startVertex = firstNode;

    dfs(firstNode, graph, visited, eulerianCycle);

    reverse(eulerianCycle.begin(), eulerianCycle.end());

    return eulerianCycle;
}
