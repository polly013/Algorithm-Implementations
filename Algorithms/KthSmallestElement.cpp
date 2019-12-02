#include <iostream>
#include <cstdio>
using namespace std;

void swap_(int &a, int &b) {
  int c = a;
  a = b;
  b = c;
}

// Worst-case scenario O(N^2)
// Average O(N)
int findKthSmallest(int arr[], int l, int r, int k) {
  if (l + 1 >= r) return arr[l];

  int x = arr[r-1];
  int nextPosition = l;
  for (int i=l; i<r-1; ++i) {
    if (arr[i] < x) {
      swap_(arr[nextPosition], arr[i]);
      ++nextPosition;
    }
  }
  swap_(arr[nextPosition], arr[r-1]);
  if (nextPosition == k) {
    return arr[nextPosition];
  }

  return nextPosition < k ? findKthSmallest(arr, nextPosition+1, r, k) :
    findKthSmallest(arr, l, nextPosition, k);
}

int main ()  {
  const int MAXN = 100257;
  int N, K;
  int array[MAXN];

  scanf("%d", &N);
  for (int i=0; i<N; ++i)
    scanf("%d", &array[i]);
  scanf("%d", &K);

  printf ("%d\n", findKthSmallest(array, 0, N, K-1));
  return 0;
}
