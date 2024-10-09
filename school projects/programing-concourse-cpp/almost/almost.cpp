#include <stdio.h>
#include <algorithm>
#include <cmath>
#include <queue>

using namespace std;
int N; // npoints
int M; // n_edges
int S; // Starting point
int D; // arrival point
int a, b, c;
const int MAXLEN = 1e7;

void Dijkstra(int S, int N, vector<pair<unsigned int, int>> *Adj, vector<int> *predecessors);
void deleteEdgesFromAdjList(vector<pair<unsigned int, int>> *Adj, vector<pair<int, int>> &edgesToDelete);
void Dijkstra2(int root, int N, vector<pair<unsigned int, int>> *Adj, unsigned int *Dist);

int main()
{
    scanf("%d", &N);
    scanf("%d", &M);
    while (N != 0)
    {
        scanf("%d", &S);
        scanf("%d", &D);
        int tab[M][3];
        for (int i = 0; i < M; i++)
        {
            scanf("%d%d%d", &a, &b, &c);
            tab[i][0] = a;
            tab[i][1] = b;
            tab[i][2] = c;
        }
        vector<pair<unsigned int, int>> Adj[N] = {}; // weight first
        for (auto truc : tab)
        {
            Adj[truc[0]].push_back(make_pair(truc[2], truc[1]));
            // Adj[truc[1]].push_back(make_pair(truc[2], truc[0]));
        }

        vector<int> predecessors[N] = {};
        Dijkstra(S, N, Adj, predecessors);
        vector<pair<int, int>> remove = {};
        queue<int> Q;
        Q.push(D);
        int temp;
        while (!Q.empty())
        {
            temp = Q.front();
            Q.pop();
            for (int tmp : predecessors[temp])
            {
                if (tmp != -1)
                {
                    remove.push_back(make_pair(tmp, temp));
                    Q.push(tmp);
                }
            }
        }
        deleteEdgesFromAdjList(Adj, remove);
        unsigned int Dist[N];
        Dijkstra2(S, N, Adj, Dist);
        if (Dist[D] != MAXLEN)
        {
            printf("%d\n", Dist[D]);
        }
        else
        {
            int x = -1;
            printf("%d\n", x);
        }

        scanf("%d", &N);
        scanf("%d", &M);
    }
    return 0;
}

void Dijkstra(int S, int N, vector<pair<unsigned int, int>> *Adj, vector<int> *predecessors)
{
    unsigned int Dist[N];
    typedef pair<pair<unsigned int, int>, int> WeightNode; //<<poids, père>, sommet>
    priority_queue<WeightNode, vector<WeightNode>, greater<WeightNode>> Q;
    fill_n(Dist, N, MAXLEN);
    Q.push(make_pair(make_pair(0, -1), S));
    while (!Q.empty())
    {
        int d = Q.top().first.first, u = Q.top().second; // node of least priority
        int pred = Q.top().first.second;
        Q.pop();
        if (Dist[u] < MAXLEN)
        {
            // node already processed, ignore leftover in queue
            if (Dist[u] == d && u != 0)
            {
                predecessors[u].push_back(pred);
            }
            continue;
        }
        if (Dist[u] > d)
        {
            Dist[u] = d;
            predecessors[u] = {pred};
        }

        for (auto tmp : Adj[u])
        {
            int v = tmp.second;
            unsigned int weight = tmp.first;
            Q.push(make_pair(make_pair(Dist[u] + weight, u), v)); // push with new estim
        }
    }
}

void deleteEdgesFromAdjList(vector<pair<unsigned int, int>> *Adj, vector<pair<int, int>> &edgesToDelete)
{
    for (const auto &edge : edgesToDelete)
    {
        unsigned int u = edge.first;
        int v = edge.second;
        auto &adj_u = Adj[u];
        auto it = find_if(adj_u.begin(), adj_u.end(),
                          [v](const pair<unsigned int, int> &p)
                          { return p.second == v; });
        if (it != adj_u.end())
        {
            adj_u.erase(it);
        }
    }
}

void Dijkstra2(int root, int N, vector<pair<unsigned int, int>> *Adj, unsigned int *Dist)
{
    typedef pair<unsigned int, int> WeightNode;
    priority_queue<WeightNode, vector<WeightNode>, greater<WeightNode>> Q;
    fill_n(Dist, N, MAXLEN);
    Q.push(make_pair(0, root));
    while (!Q.empty())
    {
        int d = Q.top().first, u = Q.top().second; // node of least priority
        Q.pop();
        if (Dist[u] < MAXLEN)
            continue; // node already processed, ignore leftover in queue
        Dist[u] = d;
        for (auto tmp : Adj[u])
        {
            int v = tmp.second;
            unsigned int weight = tmp.first;
            Q.push(make_pair(Dist[u] + weight, v)); // push with new estim
        }
    }
}