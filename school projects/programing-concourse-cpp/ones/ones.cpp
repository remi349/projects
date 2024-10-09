#include <stdio.h>
#include <algorithm>
#include <cmath>
#include <queue>
#include <stack>
#include <cstring>
#include <bitset>
#include <string>

using namespace std;
long long int give_numbers_ones(long long int n);
long long int tab[55][55];
// ln(10^16)/ln(2) = 53.15

int main()
{

    // PART WHERE I COMPUTE THE BINOMIAL COEFFICIENTS

    for (int i = 1; i < 55; i++)
    {
        tab[i][0] = 1;
        tab[i][i] = 1;
        tab[i][1] = i;
        tab[i][i - 1] = i;
        if (i > 3)
        {
            for (int j = 2; j < i - 1; j++)
            {
                tab[i][j] = tab[i - 1][j - 1] + tab[i - 1][j];
            }
        }
    }

    // NOW FORST I SCAN :
    long long int n1;
    long long int n2;
    long long int n1_1;
    long long int n2_1;
    while (scanf("%lld", &n1) == 1)
    {

        scanf("%lld", &n2);
        if (n1 == n2)
        {
            int to_print = 0;
            bitset<64> binaryBits(n1);
            for (size_t i = 0; i < binaryBits.size(); ++i)
            {
                if (binaryBits.test(i))
                {
                    to_print++;
                }
            }
            printf("%d\n", to_print);
        }
        else
        {
            n1_1 = give_numbers_ones(max(n1 - 1, 0LL));
            n2_1 = give_numbers_ones(n2);
            printf("%lld\n", n2_1 - n1_1);
        }
    }

    return 0;
}

long long int give_numbers_ones(long long int n)
{
    long long int n_ones = 0;
    int count = 0;
    bitset<64> binaryBits(n);
    for (int i = 55; i >= 0; i = i - 1)
    {
        if (binaryBits.test(i))
        {

            // here the i-th bit is 1
            if (i == 0)
            {
                n_ones = n_ones + 1 + count;
            }

            if (i != 0)
            {
                for (int j = 0; j <= i; j++)
                {
                    if (j == 0)
                    {
                        n_ones = n_ones + count + 1;
                    }
                    else
                    {
                        n_ones = n_ones + tab[i][j] * (j + count);
                    }
                }
            }
            count++;
        }
    }
    return n_ones;
}
