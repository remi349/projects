#include <stdio.h>
#include <string.h>
#include <algorithm>
#include <cmath>
#include <string>
#include <sstream>
using namespace std;

int main()
{
    char sentence[100 * 31];
    string longestSubsequence;
    vector<string> words1, words2;
    int nw1;
    int nw2;
    bool first; // print the space at right place
    while (scanf("%[^\n]%*c", sentence) == 1)
    {
        words1 = {};
        words2 = {};

        nw1 = 0;
        nw2 = 0;

        // syntax of scanning a sentence repeated twice to get the two sentences.
        while (strcmp(sentence, "#") != 0)
        {

            stringstream ss(sentence);
            string word;

            while (ss >> word)
            {
                nw1++;
                words1.push_back(word);
            }
            scanf("%[^\n]%*c", sentence);
        }
        scanf("%[^\n]%*c", sentence);
        while (strcmp(sentence, "#") != 0)
        {

            stringstream ss(sentence);
            string word;

            while (ss >> word)
            {
                nw2++;
                words2.push_back(word);
            }
            scanf("%[^\n]%*c", sentence);
        }

        // This code was inspired by the Longest Subsequence problem.
        //  cf link  : https://www.geeksforgeeks.org/find-length-longest-subsequence-one-string-substring-another-string/
        // so the code below is adaptated from an already existing code
        int tab[nw1 + 1][nw2 + 1] = {};
        for (int i = 1; i <= nw1; i++)
        {
            for (int j = 1; j <= nw2; j++)
            {
                // to optimize the comparison of two strings I first compare the sizes. This may append complexity on the imbricated loops...
                if (words1[i - 1].size() == words2[j - 1].size())
                {
                    if (words1[i - 1] == words2[j - 1])
                    {
                        tab[i][j] = 1 + tab[i - 1][j - 1];
                    }
                    else
                    {
                        tab[i][j] = max(tab[i - 1][j], tab[i][j - 1]);
                    }
                }
                else
                {
                    tab[i][j] = max(tab[i - 1][j], tab[i][j - 1]);
                }
            }
        }
        // nw1 and nw2 are now useless.

        longestSubsequence = "";
        first = false;
        while (min(nw1, nw2) > 0)
        {
            if (words1[nw1 - 1].size() == words2[nw2 - 1].size())
            {
                if (words1[nw1 - 1] == words2[nw2 - 1])
                {

                    if (first)
                    {
                        longestSubsequence = words1[nw1 - 1] + " " + longestSubsequence;
                    }
                    else
                    {
                        longestSubsequence = words1[nw1 - 1] + longestSubsequence;
                    }
                    nw1--;
                    nw2--;
                    first = true;
                }
                else
                {
                    if (tab[nw1 - 1][nw2] > tab[nw1][nw2 - 1])
                    {
                        nw1--;
                    }
                    else
                    {
                        nw2--;
                    }
                }
            }
            else if (tab[nw1 - 1][nw2] > tab[nw1][nw2 - 1])
            {
                nw1--;
            }
            else
            {
                nw2--;
            }
        }
        printf("%s\n", longestSubsequence.c_str());
    }
    return 0;
}