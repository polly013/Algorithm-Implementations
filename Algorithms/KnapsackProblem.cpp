#include <iostream>
#include <cstdio>
#include <cstring>
using namespace std;

const int MAXN = 1024, MAXW = 1024;
int N, W;
int weight[MAXN], value[MAXN];
int dp[MAXN][MAXW];

int main () {
  scanf("%d %d", &N, &W);

  for (int i=1; i<=N; ++i)
    scanf("%d %d", &weight[i], &value[i]);

  for (int i=0; i<=W; ++i)
    dp[0][i] = 0;

  for (int i=1; i<=N; ++i)
    for (int j=0; j<=W; ++j) {
      if (weight[i] > j) dp[i][j] = dp[i-1][j];
      else dp[i][j] = max(dp[i-1][j], dp[i-1][j-weight[i]] + value[i]);
    }

  printf ("%d\n", dp[N][W]);
  return 0;
}
