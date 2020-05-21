#include<iostream>
#include<cstdio>
#include<vector>
using namespace std;

const int MAXN = 300257;
int N, M;
vector<int> graph[MAXN];
bool used[MAXN];
bool cut[MAXN];
int preorder[MAXN];
int lowest[MAXN];
int in = 1;

int mini (int a, int b) {
  return a > b ? b : a;
}

void dfs(int s) {
  preorder[s] = in++;
  lowest[s] = preorder[s];
  int children = 0;

  for (int i=0; i<graph[s].size(); ++i) {
    int child = graph[s][i];
    if (used[child]) {
      // back edge
      lowest[s] = mini(lowest[s], preorder[child]);
    } else {
      // dfs tree edge
      ++children;
      used[child] = true;
      dfs(child);
      lowest[s] = mini(lowest[s], lowest[child]);
      if (preorder[s] <= lowest[child]) {
        cut[s] = true;
      }
    }
  }
  if (s == 1) {
    cut[s] = children > 1;
  }
}

void print() {
  for (int i=1; i<=N; ++i) {
    printf ("preorder %d -> %d\n", i, preorder[i]);
  }
  printf("\n");

  for (int i=1; i<=N; ++i) {
    printf ("lowest %d -> %d\n", i, lowest[i]);
  }
  printf("\n");
}

void read() {
  scanf("%d %d", &N, &M);
  int a, b;
  for (int i=0; i<M; ++i) {
    scanf("%d %d", &a, &b);
    graph[a].push_back(b);
    graph[b].push_back(a);
  }
}

int main() {
  read();

  used[1] = true;
  dfs(1);
  // print();

  printf ("articulation points:\n");
  for (int i=1; i<=N; ++i) {
    if (cut[i]) {
      printf("%d\n", i);
    }
  }
  return 0;
}

/*
example:
8 9
1 3
2 3
1 6
6 4
4 7
4 5
4 8
6 7
6 5
*/
