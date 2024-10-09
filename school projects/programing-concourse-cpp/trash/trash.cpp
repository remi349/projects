#include <stdio.h>
#include <string.h>
#include <algorithm>
#include <cmath>
#include <string>
#include <set>
#include <vector>

#include <cfloat>
using namespace std;

const double EPS = 1e-9;

struct Point
{
    int x, y;
    bool operator==(Point pt2) const
    {
        return (fabs(x - pt2.x) < EPS && (fabs(y - pt2.y) < EPS));
    }

    double get_distance(Point p2)
    {
        return sqrt((p2.x - x) * (p2.x - x) + (p2.y - y) * (p2.y - y));
    }
};
int orientation(Point p, Point q, Point r);
double getDistance(Point p1, Point p2, Point p);

int main()
{
    int n;
    int x;
    int y;
    scanf("%d", &n);
    int case_nb = 0;
    while (n != 0)
    {
        case_nb++;
        Point points[n] = {};
        for (int i = 0; i < n; i++)
        {
            scanf("%d", &x);
            scanf("%d", &y);
            points[i] = {x, y};
        }

        // this is the Jarvis algorithm, from the website
        // https://www.geeksforgeeks.org/convex-hull-using-jarvis-algorithm-or-wrapping/
        vector<Point> convex_envelop;

        // Find the leftmost point
        int leftmost = 0;
        for (int i = 1; i < n; i++)
        {
            if (points[i].x < points[leftmost].x)
                leftmost = i;
        }

        int p = leftmost, q;
        int size = 0;
        do
        {
            convex_envelop.push_back(points[p]);
            size++;
            q = (p + 1) % n;
            for (int i = 0; i < n; i++)
            {
                if (orientation(points[p], points[i], points[q]) == 2)
                    q = i;
            }
            p = q;
        } while (p != leftmost);

        // convex_envelop is now the convex enveloppe.
        // let's find the biggest smallest dimension now.
        double max_dim = DBL_MAX;

        for (int i = 0; i < size; i++)
        {
            double max_length = 0;
            Point first = convex_envelop[i];
            Point next = convex_envelop[(i + 1) % size]; // necessary because of the border_nodes

            for (int j = 0; j < size; j++)
            {
                max_length = max(max_length, getDistance(first, next, convex_envelop[j]));
            }
            max_dim = min(max_length, max_dim);
        }
        printf("Case %d: ", case_nb);
        printf("%.2f\n", max_dim);
        scanf("%d", &n);
    }

    return 0;
}

int orientation(Point p, Point q, Point r)
{
    int val = (q.y - p.y) * (r.x - q.x) - (q.x - p.x) * (r.y - q.y);
    if (val == 0)
        return 0; // Collinear points
    else if (val > 0)
        return 1; // turn right
    else
        return 2; // turn left
}

// given diapo 13 :
double getDistance(Point p1, Point p2, Point p)
{
    double crossProduct = abs((p2.y - p1.y) * (p.x - p1.x) - (p2.x - p1.x) * (p.y - p1.y));
    double uNorm = sqrt((p2.y - p1.y) * (p2.y - p1.y) + (p2.x - p1.x) * (p2.x - p1.x));
    return crossProduct / uNorm;
}