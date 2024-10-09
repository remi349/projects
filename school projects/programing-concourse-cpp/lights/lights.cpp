#include <stdio.h>
#include <cmath>
#include <list>
#include <vector>
#include <stack>
#include <algorithm>

using namespace std;
vector<int> f(vector<int> tab, int N){
    vector<int> tab2 = tab;
    for (int i = 1; i<N+1; i++){
        if (tab[i-1]==1){
            tab2[i%N]=1-tab2[i%N];
        }
    }
    return tab2;
}

int main (){
    long long int N;
    long long int B;
    int temp;
    while (scanf("%lld",&N)==1){
        scanf("%lld",&B);
        vector<int> tab={};
        for (int i = 0; i<N; i++){
            scanf("%d",&temp);
            tab.push_back(temp);
        }
        vector<int> l = tab;
        vector<int> t = tab;
        vector<int> x0 = tab;
        l=f(l,N);
        l=f(l,N);//l=f°f
        t=f(t,N);//t=f(x0)
        while(l!=t){
            l=f(l,N);
            l=f(l,N);
            t=f(t,N);
        }
        long long int mu = 0;
        t = x0;
        while (l!=t){
            l=f(l,N);
            t=f(t,N);
            mu ++;
        }
        long long int lambda = 1;
        l=f(l,N);
        while (l!=t){
            l=f(l,N);
            lambda ++;
        }


        for (int i = 0; i< mu; i++){
            x0=f(x0,N);
        }
        long long int real_p = (B-mu)%lambda;
        for (int i = 0; i< real_p; i++){
            x0=f(x0,N);
        }
        for (int x : x0){
            printf("%d\n",x);
        }
    }
    return 0;
}

