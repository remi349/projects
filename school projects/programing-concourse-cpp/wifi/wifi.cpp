#include <stdio.h>
#include <stdbool.h>
#include <algorithm>
#include <array>
#include <cmath>

using namespace std;

/* declaration */
bool does_this_r_works(float r, int *sorted_tab, int number_antenna, int n);

int main()
{

    int n_test;
    scanf("%d", &n_test);
    for (int i = 0; i < n_test; i++)
    {
        int n; // number of antennae
        scanf("%d", &n);
        int m;
        scanf("%d", &m);
        int tab[m]; // toutes les villes
        int city;
        for (int h = 0; h < m; h++)
        {
            scanf("%d", &city);
            tab[h] = city;
        }
        // sort the tab
        sort(tab, tab + m);
        // do the dichotomy
        float left = 0;
        float right = (tab[m - 1] - tab[0]) / 2.;
        float mid;
        while (right - left >= 0.05)
        {
            mid = left + (right - left) / 2;
            if (does_this_r_works(mid, tab, n, m))
            {
                right = mid;
            }
            else
            {
                left = mid;
            }
        }
        float sol = round(left * 10) / 10;
        printf("%.1f\n", sol);
    }
    return (0);
}

bool does_this_r_works(float r, int *sorted_tab, int number_antenna, int m)
{
    float sorted_until = 0;
    int sorted_until_index = 0;
    for (int i = 0; i < number_antenna; i++)
    {
        sorted_until = sorted_tab[sorted_until_index] + 2 * r;
        if (sorted_until >= sorted_tab[m - 1])
        {
            return true;
        }
        while (sorted_tab[sorted_until_index] <= sorted_until)
        {
            sorted_until_index++;
            if (sorted_until_index == m)
            {
                return true;
            }
        }
    }
    return false;
}