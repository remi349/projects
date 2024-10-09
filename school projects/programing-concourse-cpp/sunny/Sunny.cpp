#include <stdio.h>
#include <string.h>
#include <algorithm>
#include <cmath>
#include <string>
#include <set>
using namespace std;

const double EPS = 1e-9;

struct point
{
    int x, y;
    bool operator==(point pt2) const
    {
        return (fabs(x - pt2.x) < EPS && (fabs(y - pt2.y) < EPS));
    }
    static bool bigger_x(const point &p1, const point &p2)
    {
        return p1.x > p2.x;
    }
    double get_distance(point p2)
    {
        return sqrt((p2.x - x) * (p2.x - x) + (p2.y - y) * (p2.y - y));
    }
};

int main()
{
    int C;
    int N;
    int x;
    int y;
    int height;
    double to_return;
    scanf("%d", &C);

    for (int n_test = 0; n_test < C; n_test++)
    {
        set<point, decltype(&point::bigger_x)> Points(&point::bigger_x);
        to_return = 0;
        height = 0;
        scanf("%d", &N);
        for (int i = 0; i < N; i++)
        {
            scanf("%d", &x);
            scanf("%d", &y);
            Points.insert({x, y});
        }
        // let's suppose they are already ordened.
        point old;
        int parity = 0;
        point floor;
        point middle;
        for (point p : Points)
        {
            if (parity == 0)
            {
                old = p;
                parity = 1;
            }
            else
            {
                // thales formula
                floor = {p.x, old.y};
                middle = {p.x, height};
                if (p.y >= height)
                {
                    to_return = to_return + p.get_distance(middle) / p.get_distance(floor) * p.get_distance(old);
                    height = p.y;
                }

                // thales
                parity = 0;
            }
        }
        printf("%.2f\n", to_return);
    }

    return 0;
}
