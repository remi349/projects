#include <stdio.h>
#include <string.h>
#include <algorithm>
#include <cmath>
#include <string>
#include <set>
#include <utility>
#include <vector>
using namespace std;

const double EPS = 1e-9;

bool compareByFirst(const pair<long double, int> &a, const pair<long double, int> &b)
{
    if (fabs(a.first - b.first) < EPS) // the min
    {
        return a.second < b.second; // Secondary comparison using the second element
    }
    return a.first < b.first;
}
bool compareByFirst_bis(const pair<long double, int> &a, const pair<long double, int> &b) // max
{
    if (fabs(a.first - b.first) < EPS)
    {
        return a.second > b.second; // Secondary comparison using the second element
    }
    return a.first < b.first;
}
struct Point
{
    long int x, y;
    bool operator==(Point pt2) const
    {
        return (fabs(x - pt2.x) < EPS && (fabs(y - pt2.y) < EPS));
    }

    double get_distance(Point p2)
    {
        return sqrt((p2.x - x) * (p2.x - x) + (p2.y - y) * (p2.y - y));
    }
    bool acceptable(Point p2)
    {
        return (p2.x >= x || p2.y >= y);
    }
    bool too_good(Point p2)
    {
        return (p2.x > x && p2.y > y);
    }
};

bool alined(Point p, Point q, Point r)
{
    return (((q.y - p.y) * (r.x - q.x) - (q.x - p.x) * (r.y - q.y)) == 0);
}

int main()
{
    long int size;
    long int x;
    long int y;
    Point p;
    Point p2;
    long int count;
    long int on_the_left;
    vector<Point> points;
    vector<pair<long double, int>> angles;
    while (scanf("%ld", &size) == 1)
    {
        count = 1;
        on_the_left = 0;
        scanf("%ld", &x);
        scanf("%ld", &y);
        p = {x, y};
        points = {};
        angles = {};
        long int dupl = 0;
        for (int i = 1; i < size; i++)
        {
            scanf("%ld", &x);
            scanf("%ld", &y);
            p2 = {x, y};
            if (p.acceptable(p2))
            {
                if (p.too_good(p2))
                {
                    count++;
                }
                else
                {
                    if (p2 == p)
                    {
                        dupl++;
                    }
                    else
                    {
                        points.push_back(p2);
                        long double temp = atan2(p2.y - p.y, p2.x - p.x);
                        long int sign = signbit(temp); // 1 si négatif, 0 si >=0
                        // tout juste rajouté !!!
                        // mieux regarder les cas p2.y == p.y et p2.x == p.x
                        if (temp == 0 && p2.x > p.x)
                        {
                            sign = 1;
                        }

                        if (sign == 1) // ADDED TEMP
                        {
                            angles.push_back(make_pair(abs(temp), sign));
                        }
                        else
                        {
                            angles.push_back(make_pair(M_PI - abs(temp), sign));
                            temp = M_PI - abs(temp); // V_NEXT
                        }
                        // angles.push_back(make_pair(abs(atan2(p2.y - p.y, p2.x - p.x)), signbit(atan2(p2.y - p.y, p2.x - p.x))));
                        if (p2.x < p.x || temp == 0 && sign == 0 || (p2.x == p.x && temp > 0)) // sure ?
                        {
                            on_the_left++;
                            // if temp==0
                        }
                        // rajouter les angles
                    }
                }
            }
        }

        // now we just have the good points.
        sort(angles.begin(), angles.end(), compareByFirst);
        on_the_left = on_the_left + count;
        long int on_temp = on_the_left;
        /*if (dupl){
            on_the_left --;
        }*/
        vector<long int> size = {on_the_left};

        // find the min :

        for (auto p : angles)
        {
            if (p.first == 0 && p.second == 0)
            {
                on_the_left--;
            }
            else
            {
                if (p.second == 1) // negatif
                {
                    on_the_left++;
                }
                else
                {
                    on_the_left--;
                }
            }
            size.push_back(on_the_left);
            // old = p;
        }
        auto minElement = min_element(size.begin(), size.end());
        printf("%ld ", *minElement);

        // now let's finf the maximal elt :
        sort(angles.begin(), angles.end(), compareByFirst_bis);
        size = {on_temp};
        for (auto p : angles)
        {
            if (p.second == 1) // negatif
            {
                on_temp++;
            }
            else
            {
                on_temp--;
            }
            size.push_back(on_temp);
            // old = p;
        }

        auto maxElement = max_element(size.begin(), size.end());
        printf("%ld\n", *maxElement + dupl);
    }
    return 0;
}
