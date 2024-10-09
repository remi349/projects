#include <stdio.h>
#include <algorithm>

using namespace std;

int main()
{
    int n_test;
    scanf("%d", &n_test);
    for (int i = 0; i < n_test; i++)
    {
        int C; // max, capacity
        scanf("%d", &C);
        int available_space = C;
        int N; // number of packages to deliver
        scanf("%d", &N);
        // read the N lines
        int tab[N];
        for (int h = 0; h < N; h++)
        {
            tab[h] = h;
        }
        for (int j : tab)
        {
            printf(% d, j);
        }
    }
    return (0);
}