#include <stdio.h>

int searchInsert(int *nums, int numsSize, int target)
{

  int left = 0;
  int right = numsSize - 1;
  while (left <= right)
  {
    int mid = (left + right) / 2;
    if (target == nums[mid])
      return mid;
    else if (target < nums[mid])
      right = mid - 1;
    else
      left = mid + 1;
  }
  return left;
}

int main()
{
  int data[] = {1, 3, 5, 6};
  int size = 4;
  int tar1 = 5, tar2 = 2, tar3 = 7;
  int index1 = searchInsert(data, size, tar1);
  int index2 = searchInsert(data, size, tar2);
  int index3 = searchInsert(data, size, tar3);
  printf("The target1 insert position is %d\n", index1);
  printf("The target2 insert position is %d\n", index2);
  printf("The target3 insert position is %d\n", index3);
  return 0;
}