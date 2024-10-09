#include <stdio.h>
#include <algorithm>
#include <set>
#include <cmath>
#include <map>
using namespace std;

map<int, pair<int, unsigned int>> Sets;
void MakeSet(int x);
int Find(int x);
void Union(int x, int y);

struct Point
{
    int x;
    int y;
    double get_distance(Point P2)
    {
        return sqrt((P2.x - x) * (P2.x - x) + (P2.y - y) * (P2.y - y));
    }
};

int main()
{
    int N;
    Point P;
    int M;
    vector<Point> points;
    pair<int, int> cords;
    set<pair<int, int>> A;                      // Final minimum spanning tree
    vector<pair<double, pair<int, int>>> Edges; // edges
    while (scanf("%d", &N) == 1)
    {
        Sets = {};
        points = {};
        for (int i = 0; i < N; i++)
        {
            scanf("%d %d", &P.x, &P.y);
            points.push_back(P);
        }
        scanf("%d", &M);
        // build the edges :
        Edges = {};
        A = {};
        vector<vector<int>> Mat(N + 1, vector<int>(N + 1, 0));
        for (int i = 0; i < M; i++)
        {
            scanf("%d %d", &cords.first, &cords.second);
            A.insert(make_pair(cords.first, cords.second));
            Mat[cords.first][cords.second] = 1;
        }

        for (int i = 0; i < N; i++)
        {
            for (int j = i + 1; j < N; j++)
            {
                if (Mat[i + 1][j + 1] != 1)
                {
                    Edges.push_back(make_pair(points[i].get_distance(points[j]), make_pair(i + 1, j + 1)));
                }
            }
        }

        for (int u = 0; u < N; u++)
        {
            MakeSet(u);
        } // Initialize Union-Find
        // Edges maybe delete those already taken
        sort(Edges.begin(), Edges.end());

        for (auto node : A)
        {
            Union(node.first, node.second);
        }

        double dist = 0;

        for (auto tmp : Edges)
        {
            auto edge = tmp.second;
            if (Find(edge.first) != Find(edge.second))
            {
                Union(edge.first, edge.second); // update Union-Find
                A.insert(edge);                 // include edge in MST
                dist += tmp.first;
            }
        }
        float rounded_dist = round(dist * 100) / 100;
        printf("%.2f\n", rounded_dist);
    }

    return 0;
}

// map to parent & rank

// algorithm from lectures :
void MakeSet(int x)
{
    Sets.insert(make_pair(x, make_pair(x, 0)));
}
int Find(int x)
{
    if (Sets[x].first == x)
        return x; // Parent == x ?
    else
        return Sets[x].first = Find(Sets[x].first); // Get Parent
}
void Union(int x, int y)
{
    int parentX = Find(x), parentY = Find(y);
    int rankX = Sets[parentX].second, rankY = Sets[parentY].second;
    if (parentX == parentY)
        return;
    else if (rankX < rankY)
        Sets[parentX].first = parentY;
    else
        Sets[parentY].first = parentX;
    if (rankX == rankY)
        Sets[parentX].second++;
}