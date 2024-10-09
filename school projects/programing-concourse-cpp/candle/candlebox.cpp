#include <stdio.h>
#include <cmath>

using namespace std;

int main()
{
    int R, T, D, age_of_r, candles_number;
    while (scanf("%d", &D) == 1)
    {
        scanf("%d", &R);
        scanf("%d", &T);
        age_of_r = round(0.5 * (D - 1 + sqrt((1 - D) * (1 - D) - 2 * (D * (D - 1) - 18 - 2 * (R + T)))));
        candles_number = R - (age_of_r - 3) * (age_of_r + 4) / 2;
        printf("%d\n", candles_number);
    }
    return (0);
}