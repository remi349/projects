#include <stdio.h>
#include <algorithm>
#include <set>
using namespace std;

int main()
{
    bool first_set = false;
    bool solved;
    int n_tests;
    while (scanf("%d", &n_tests) == 1)
    {
        solved = false;
        char useless;
        scanf("%c", &useless); // scan \n
        int path[n_tests][n_tests] = {};
        int change[n_tests][n_tests] = {};
        char temp;
        for (int i = 0; i < n_tests; i++)
        {
            for (int j = 0; j < n_tests; j++)
            {
                scanf("%c", &temp);
                if (temp == '.')
                {
                    path[i][j] = 1;
                }
                else
                {
                    path[i][j] = 0;
                }
            }
            scanf("%c", &useless);
        }
        int max_period = 0;
        for (int i = 0; i < n_tests; i++)
        {
            for (int j = 0; j < n_tests; j++)
            {
                scanf("%1d", &change[i][j]); // separate the digits
                if (change[i][j] > max_period)
                {
                    max_period = change[i][j];
                }
            }
            getchar();
        }
        // everything is scanned
        int time_max = n_tests * n_tests * max_period;
        int time = 0;
        set<pair<int, int>> position;     // depends on t
        position.insert(make_pair(0, 0)); //
        while (time < time_max)
        {
            time++;
            for (int i = 0; i < n_tests; i++)
            {
                for (int j = 0; j < n_tests; j++)
                {
                    if (change[i][j] > 0)
                    {
                        if (time % change[i][j] == 0)
                        {
                            path[i][j] = 1 - path[i][j];
                        }
                    }
                }
            }
            vector<pair<int, int>> copied_position;
            copy(position.begin(), position.end(), back_inserter(copied_position));
            for (pair<int, int> node : copied_position)
            {
                int i = node.first;
                int j = node.second;
                if (i > 0 && path[i - 1][j] == 1)
                {
                    position.insert(make_pair(i - 1, j));
                }
                if (i < n_tests - 1 && path[i + 1][j] == 1)
                {
                    position.insert(make_pair(i + 1, j));
                }
                if (j > 0 && path[i][j - 1] == 1)
                {
                    position.insert(make_pair(i, j - 1));
                }
                if (j < n_tests - 1 && path[i][j + 1] == 1)
                {
                    position.insert(make_pair(i, j + 1));
                }
                if (path[i][j] == 0)
                {
                    position.erase(make_pair(i, j));
                }
            }
            int test = position.count(make_pair(n_tests - 1, n_tests - 1));

            if (test)
            {
                if (first_set)
                {
                    printf("\n");
                }
                printf("%d\n", time);
                solved = true;
                break;
            }
        }
        // path not found

        if (!solved)
        {
            if (first_set)
            {
                printf("\n");
            }
            printf("NO\n");
        }
        first_set = true;
    }
    return 0;
}