#include <iostream>
#include <cstdio>
using namespace std;

void swap_(int &a, int &b) {
  int c = a;
  a = b;
  b = c;
}

// Quick sort with pivoting around the last element in the array
void quickSort(int arr[], int l, int r) {
  if (l + 1 >= r) return;

  int x = arr[r-1];
  int nextPosition = l;
  for (int i=l; i<r-1; ++i) {
    if (arr[i] < x) {
      swap_(arr[nextPosition], arr[i]);
      ++nextPosition;
    }
  }
  swap_(arr[nextPosition], arr[r-1]);
  quickSort(arr, l, nextPosition);
  quickSort(arr, nextPosition+1, r);
}

int main ()  {
  const int MAXN = 100257;
  int N;
  int array[MAXN];

  scanf("%d", &N);
  for (int i=0; i<N; ++i)
    scanf("%d", &array[i]);

  quickSort(array, 0, N);

  for (int i=0; i<N; ++i)
    printf("%d ", array[i]);
  printf("\n");
  return 0;
}
