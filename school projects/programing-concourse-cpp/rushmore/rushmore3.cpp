#include <stdio.h>
#include <algorithm>
#include <cmath>
#include <queue>
#include <stack>
#include <cstring>
using namespace std;

int main()
{
    int m;
    int n;
    char c1;
    char c2;
    char useless;
    int printed = 0;
    int tab[26][26];
    while (scanf("%d", &m) == 1)
    {
        memset(tab, 0, sizeof(int) * 26 * 26);
        // tab = {};
        printed = printed + 100;
        scanf("%d", &n);
        scanf("%c", &useless); // scan new line
        vector<int> adj[26] = {};
        for (int i = 0; i < m; i++)
        {
            scanf("%c", &c1);
            c1 = c1 - 97;
            scanf("%c", &useless); // scan space
            scanf("%c", &c2);
            c2 = c2 - 97;
            scanf("%c", &useless); // scan new line
            adj[c1].push_back(c2);
        }

        for (int i = 0; i < 26; i++)
        {
            tab[i][i] = 1;
        }
        // now let's stack :
        stack<int> sons;
        for (int i = 0; i < 26; i++)
        {
            sons = {};
            for (int neigh : adj[i])
            {
                sons.push(neigh);
            }
            while (!sons.empty())
            {
                int temp = sons.top();
                tab[i][temp] = 1;
                sons.pop();
                for (int neigh : adj[temp])
                {
                    if (!tab[i][neigh])
                    {
                        sons.push(neigh);
                    }
                }
            }
        }

        // now let's scan the words
        char w1[55];
        char w2[55];

        int len1;
        int len2;
        for (int i = 0; i < n; i++) // read the words
        {

            scanf("%s %s", w1, w2);
            len1 = strlen(w1);
            len2 = strlen(w2);
            // for each word does it work ??

            if (len1 == len2)
            {
                bool t = true;
                for (int k = 0; k < len1; k++)
                {
                    if (tab[w1[k] - 'a'][w2[k] - 'a'] != 1)
                    {
                        t = false;
                    }
                }
                if (t)
                {
                    printf("yes\n");
                }
                if (!t)
                {
                    printf("no\n");
                }
            }
            else
            {
                printf("no\n");
            }
            printed++;
            // printf("%d\n", printed);
        }
    }

    return 0;
}