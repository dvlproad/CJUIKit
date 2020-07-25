//
//  CJSortUtil.m
//  CJUIKitDemo
//
//  Created by 李超前 on 2018/3/19.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CJSortUtil.h"

@implementation CJSortUtil

/**
 *  冒泡排序
 *
 *  @param array        要排序的数组
 */
+ (void)maopaoSortArray:(NSMutableArray *)array {
    BOOL isSort = true;
    //冒泡改进：里面一层循环在某次扫描中没有执行交换，则说明此时数组已经全部有序列，无需在扫描了。\
    因此，增加一个标记，每次发生交换，就标记，如果某次循环没有标记，则说明已经完成排序。
    for (int i = 0; i < array.count; i ++) {
        isSort = false;
        for (int j = 0; j < array.count - i - 1;j ++ ) {
            if (array[j] > array[j+1]) {
                [array exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                isSort = YES;
            }
        }
        if (!isSort) {
            break;
        }
    }
}



/**
 *  选择排序
 *
 *  @param array        要排序的数组
 */
+ (void)choseSortArray:(NSMutableArray *)array {
    int min = 0;
    for (int i = 0; i < array.count-1; i++) {
        min = i;
        for (int j = i + 1; j < array.count; j++) {
            if (array[min] > array[j]) {  /*如果有小于当前的最小值的关键字*/
                min = j;  /*将此关键字的下标赋值给min*/
            }
        }
        if (i != min) {  /*若min不等于i，说明找到最小值，交换*/
            [array exchangeObjectAtIndex:i withObjectAtIndex:min];
        }
    }
}


/**
 *  快速排序
 *
 *  @param array        要排序的数组
 *  @param leftIndex    leftIndex
 *  @param rightIndex   rightIndex
 */
+ (void)quickSortArray:(NSMutableArray *)array withLeftIndex:(NSInteger)leftIndex andRightIndex:(NSInteger)rightIndex {
    if (leftIndex >= rightIndex) {  //如果数组长度为0或1时返回
        return ;
    }
    NSInteger i = leftIndex;
    NSInteger j = rightIndex;
    NSInteger key = [array[i] integerValue];    //记录比较基准数
    
    while (i < j) {
        /**** 首先从右边j开始查找比基准数小的值 ***/
        while (i < j && [array[j] integerValue] >= key) {//如果比基准数大，继续查找
            j--;
        }
        //如果比基准数小，则将查找到的小值调换到i的位置
        array[i] = array[j];
        
        /**** 当在右边查找到一个比基准数小的值时，就从i开始往后找比基准数大的值 ***/
        while (i < j && [array[i] integerValue] <= key) {//如果比基准数小，继续查找
            i++;
        }
        //如果比基准数大，则将查找到的大值调换到j的位置
        array[j] = array[i];
        
    }
    
    //将基准数放到正确位置
    array[i] = @(key);
    
    /**** 递归排序 ***/
    //排序基准数左边的
    [self quickSortArray:array withLeftIndex:leftIndex andRightIndex:i-1];
    //排序基准数右边的
    [self quickSortArray:array withLeftIndex:i+1 andRightIndex:rightIndex];
}


/**
 *  归并排序(https://github.com/MisterBooo/Play-With-Sort-OC)
 *
 *  @param array array
 *  @param lowIndex lowIndex
 *  @param highIndex highIndex
 */
+ (void)mergeSortArray:(NSMutableArray *)array lowIndex:(NSInteger)lowIndex highIndex:(NSInteger)highIndex
{
    if (lowIndex >= highIndex) {
        return;
    }
    NSInteger midIndex = lowIndex + (highIndex - lowIndex) / 2;
    [self mergeSortArray:array lowIndex:lowIndex highIndex:midIndex];
    [self mergeSortArray:array lowIndex:midIndex + 1 highIndex:highIndex];
    [self mergeArray:array lowIndex:lowIndex midIndex:midIndex highIndex:highIndex];
}

+ (NSMutableArray *)mergeArray:(NSMutableArray *)array lowIndex:(NSInteger)lowIndex midIndex:(NSInteger)midIndex highIndex:(NSInteger)highIndex
{
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    for (NSInteger i = lowIndex; i <= highIndex; i ++) {
        tempArr[i] = array[i];
    }

    NSInteger k = lowIndex;
    NSInteger l = midIndex + 1;
    for (NSInteger j = lowIndex; j <= highIndex; j ++) {
        if (l > highIndex) {
            array[j] = tempArr[k];
            k++;

        } else if (k > midIndex) {
            array[j] = tempArr[l];
            l++;

        } else if ([tempArr[k] integerValue] > [tempArr[l] integerValue]) {
            array[j] = tempArr[l];
            l++;

        } else {
            array[j] = tempArr[k];
            k++;
        }
    }

    return tempArr;
}

@end
