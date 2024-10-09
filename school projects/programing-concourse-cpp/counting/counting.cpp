#include <stdio.h>
#include <string.h>
#include <algorithm>
#include <cmath>
#include <cctype>

using namespace std;

int main()
{
    char string[(long unsigned int)1e6];
    int index, len;
    bool next;
    while (scanf("%s", string) == 1)
    {
        next = false;
        index = 0;
        len = strlen(string);
        vector<int> result[len + 1] = {};
        for (int i = 0; i < len; i++)
        {
            if (isdigit(string[i]))
            {
                result[index].push_back(string[i] - 48);
                next = true;
            }
            else
            {
                if (next)
                {
                    index++;
                    next = false;
                }
            }
        }
        vector<int> subIntegers = {};
        for (int h = 0; h < index + 1; h++)
        {
            int size = result[h].size();
            for (int i = 0; i < size; i++)
            {
                for (int j = i; j < size; j++)
                {
                    int subInteger = 0;
                    for (int k = i; k < j + 1; k++)
                    {
                        int exponent = j - k;
                        subInteger += 10 * subInteger + result[h][k];
                    }
                    subIntegers.push_back(subInteger);
                }
            }
        }
        int to_print = 0;
        for (int sub : subIntegers)
        {
            if (sub % 3 == 0)
            {
                to_print++;
            }
        }
        printf("%d\n", to_print);
    }
    return 0;
}