#include <cstdio>
#include <cstdlib>
#include <algorithm>
#include <assert.h>
using namespace std;

const int MAXN = 100257;
int arr[MAXN];
int rarr[MAXN];
int mergedArray[MAXN];
int N;

void merge(int start, int mid, int end) {
  int currA = start, currB = mid;
  int i = start;
  while (true) {
    if (currA >= mid) break;
    if (currB >= end) break;

    if (arr[currA] <= arr[currB]) {
      mergedArray[i++] = arr[currA++];
    } else {
      mergedArray[i++] = arr[currB++];
    }
  }

  while (currA < mid)
    mergedArray[i++] = arr[currA++];

  while (currB < end)
    mergedArray[i++] = arr[currB++];

  for (i=start; i<end; ++i)
    arr[i] = mergedArray[i];
}

void merge_sort(int start, int end) {
  if (start + 1 == end) return;

  int mid = (start + end) / 2;
  merge_sort(start, mid);
  merge_sort(mid, end);
  merge(start, mid, end);
}

bool test_ () {
  N = rand()%MAXN;
  for (int i=0; i<N; ++i) {
    arr[i] = rand() % MAXN;
    rarr[i] = arr[i];
  }
  sort(rarr, rarr + N);
  merge_sort(0, N);
  for (int i=0; i<N; i++)
    assert(rarr[i] == arr[i]);

  return true;
}

void tester () {
  srand(13);
  for (int t = 1; t <= 100; ++t) {
    test_();
    printf("test %d passed\n", t);
  }
}

void input () {
  scanf ("%d", &N);
  for (int i=0; i<N; ++i)
    scanf("%d", &arr[i]);

  merge_sort(0, N);

  for (int i=0; i<N; ++i)
    printf("%d ", arr[i]);
  printf("\n");
}

int main() {
  input();
  return 0;
}
