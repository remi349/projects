#include <stdio.h>
#include <algorithm>
#include <cmath>

using namespace std;

int factorial(int n);
double volume_order_crescent(vector<vector<int>> centers, int *corner1, int *corner2, int n_tests);
bool compareRows(const vector<int> &a, const vector<int> &b)
{
    for (int i = 0; i < 3; i++)
    {
        if (a[i] < b[i])
        {
            return true;
        }
        else if (a[i] > b[i])
        {
            return false;
        }
    }
    return false;
}

int main()
{
    bool first_set = false;
    int n_tests;
    int corner1[3];
    int corner2[3];
    int number_of_loop = 0;
    while (scanf("%d", &n_tests) == 1)
    {
        if (n_tests != 0)
        {
            scanf("%d", &corner1[0]);
            scanf("%d", &corner1[1]);
            scanf("%d", &corner1[2]);
            scanf("%d", &corner2[0]);
            scanf("%d", &corner2[1]);
            scanf("%d", &corner2[2]);
            int centers[n_tests][3];
            for (int i = 0; i < n_tests; i++)
            {
                scanf("%d", &centers[i][0]);
                scanf("%d", &centers[i][1]);
                scanf("%d", &centers[i][2]);
            }
            int fac = factorial(n_tests);
            double volumes[fac] = {};

            // bruteforce
            int count = 0;
            vector<vector<int>> rows(n_tests, vector<int>(3));
            for (int i = 0; i < n_tests; i++)
            {
                for (int j = 0; j < 3; j++)
                {
                    rows[i][j] = centers[i][j];
                }
            }

            sort(rows.begin(), rows.end(), compareRows);
            do
            {
                volumes[count] = volume_order_crescent(rows, corner1, corner2, n_tests);
                count++;
            } while (next_permutation(rows.begin(), rows.end()));
            number_of_loop++;
            int vol_final = round(abs((corner2[0] - corner1[0]) * (corner2[1] - corner1[1]) * (corner2[2] - corner1[2])) - *max_element(volumes, volumes + fac));
            // if (first_set)
            //{
            //     printf("\n");
            // }
            printf("Box %d: %d\n", number_of_loop, vol_final);
            printf("\n");
            first_set = true;
        }
        else
        {
            return 0;
        }
    }
}

double volume_order_crescent(vector<vector<int>> centers, int *corner1, int *corner2, int n_tests)
{
    double vol = 0;
    double radius[n_tests];
    double distances[n_tests][n_tests];
    bool null_radius;
    for (int i = 0; i < n_tests; i++)
    {
        for (int j = 0; j < i; j++)
        {
            distances[i][j] = sqrt((centers[i][0] - centers[j][0]) * (centers[i][0] - centers[j][0]) + (centers[i][1] - centers[j][1]) * (centers[i][1] - centers[j][1]) + (centers[i][2] - centers[j][2]) * (centers[i][2] - centers[j][2]));
            distances[j][i] = distances[i][j];
        }
    }
    for (int i = 0; i < n_tests; i++)
    {
        null_radius = false;
        double constraints[6 + i];
        constraints[0] = abs(centers[i][0] - corner1[0]);
        constraints[1] = abs(centers[i][1] - corner1[1]);
        constraints[2] = abs(centers[i][2] - corner1[2]);
        constraints[3] = abs(centers[i][0] - corner2[0]);
        constraints[4] = abs(centers[i][1] - corner2[1]);
        constraints[5] = abs(centers[i][2] - corner2[2]);
        for (int j = 0; j < i; j++)
        {
            if (radius[j] != 0)
            {
                constraints[6 + j] = distances[i][j] - radius[j];
                if (distances[i][j] - radius[j] < 0)
                {
                    null_radius = true;
                }
            }
            else
            {
                constraints[6 + j] = abs(corner1[0] - corner2[0]); // the radius of j is null, so no constraints
            }
        }
        if (null_radius)
        {
            radius[i] = 0;
        }
        else
        {
            radius[i] = *min_element(constraints, constraints + 6 + i);
        }
    }
    double S = 0;
    for (double r : radius)
    {
        S += r * r * r;
    }
    vol = 4. / 3. * M_PI * S;
    return vol;
}

int factorial(int n)
{
    if (n == 0)
    {
        return 1;
    }
    return n * factorial(n - 1);
}

// pi = M_PI;
// min=*min_element(list, list + list_size);
//
//
// g++ baloon.cpp -o baloon.exe -g
// gdb baloon.exe
// break 2
// run
// c (continue)
// step/next ?
// print var
