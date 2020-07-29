//
//  KKBinaryTree.m
//  KKTest
//
//  Created by ZKKMBP on 2020/7/9.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import "KKBinaryTree.h"

@interface KKBinaryTree ()

@end

@implementation KKBinaryTree

+ (instancetype)createWithArray:(NSArray *)array {
    if (array.count <= 0) {
        return nil;
    }
    KKBinaryTree *rootModel = [[KKBinaryTree alloc] init];
    for (NSInteger i = 0; i < array.count; i++) {
        NSInteger value = [array[i] integerValue];
        [self createBinaryTree:value rootModel:rootModel];
    }
    return rootModel;
}

+ (void)createBinaryTree:(NSInteger)value rootModel:(KKBinaryTree *)model {
    if (model.value <= 0) {
        model.value = value;
        return;
    }
    
    NSInteger midValue = model.value;
    if (value < midValue) {
        if (model.leftTree == nil || model.leftTree.value <= 0) {
            model.leftTree = [[KKBinaryTree alloc] init];
            model.leftTree.value = value;
//            NSLog(@"-----左---当前值--%ld--所在值--%ld",(long)value,(long)model.value);
            return;
        } else {
            [self createBinaryTree:value rootModel:model.leftTree];
        }
    } else {
        if (model.rightTree == nil || model.rightTree.value <= 0) {
            model.rightTree = [[KKBinaryTree alloc] init];
            model.rightTree.value = value;
//            NSLog(@"----右----%ld---%ld",(long)value,(long)model.value);
            return;
        } else {
            [self createBinaryTree:value rootModel:model.rightTree];
        }
    }
}

//排序二叉树，插入数据
+ (BOOL)insterBinaryTree:(NSInteger)value rootModel:(KKBinaryTree *)model {
    if (!model.value) {
        model = [[KKBinaryTree alloc] init];
        model.value = value;
        model.leftTree = nil;
        model.rightTree = nil;
        return YES;
    }
    NSInteger midValue = model.value;
    if (value == midValue) {
        NSLog(@"有相同内容，插入失败");
        return NO;
    } else if (value > midValue) {
       return [self insterBinaryTree:value rootModel:model.rightTree];
    } else {
       return [self insterBinaryTree:value rootModel:model.leftTree];
    }
}

- (NSInteger)length {
    return 1 + self.leftTree.length + self.rightTree.length;
}

- (NSInteger)depth {
    return 1 + MAX(self.leftTree.depth, self.rightTree.depth);
}

- (NSInteger)maxLength {
    NSInteger depth = self.length;
    NSInteger maxLength = 0;
    while (depth) {
        maxLength += pow(2, depth - 1);
        depth--;
    }
    return maxLength;
}

//反转二叉树
- (void)reverse {
    KKBinaryTree * right = self.rightTree;
    self.rightTree = self.leftTree;
    self.leftTree = right;
    [self.leftTree reverse];
    [self.rightTree reverse];
}

//广度优先遍历:Breadth First Search
- (void)BFSPrint {
    NSMutableArray <KKBinaryTree *>* treeArray = [NSMutableArray array];
    [treeArray addObject:self];
    while (treeArray.count > 0) {
        KKBinaryTree * tree = treeArray.firstObject;
        NSLog(@" %zd ",tree.value);
        [treeArray removeObjectAtIndex:0];
        if (tree.leftTree){
            [treeArray addObject:tree.leftTree];
        }
        if (tree.rightTree) {
            [treeArray addObject:tree.rightTree];
        }
    }
}

//先/前 序遍历
- (void)prePrint {
    NSLog(@" %zd ",self.value);
    [self.leftTree prePrint];
    
    NSLog(@"---rightTree----- %zd --leftTree--%ld",self.rightTree.value,(long)self.leftTree.value);
    [self.rightTree prePrint];
}

//中序遍历
- (void)midPrint {
    [self.leftTree midPrint];
    NSLog(@" %zd ",self.value);
    [self.rightTree midPrint];
}

//后序遍历
- (void)sufPrint {
    [self.leftTree sufPrint];
    [self.rightTree sufPrint];
    NSLog(@" %zd ",self.value);
}

// 非递归 先/前 序遍历
- (void)prePrintWithoutRecursion {
    NSMutableArray <KKBinaryTree *>* treeArray = [NSMutableArray array];
    KKBinaryTree * tree = self;
    while (tree != nil || treeArray.count) {
        while (tree != nil) {
            NSLog(@" %zd ",tree.value);
            [treeArray insertObject:tree atIndex:0];        //模仿栈的先进后出,后进先出
            tree = tree.leftTree;
        }
        if (treeArray.count) {
            tree = treeArray.firstObject.rightTree;
            [treeArray removeObjectAtIndex:0];
        }
    }
}

// 非递归 - 中序遍历
- (void)midPrintWithoutRecursion {
    NSMutableArray <KKBinaryTree *>* treeArray = [NSMutableArray array];
    KKBinaryTree * tree = self;
    while (tree != nil || treeArray.count) {
        while (tree != nil) {
            [treeArray insertObject:tree atIndex:0];        //模仿栈的先进后出,后进先出
            tree = tree.leftTree;
        }
        if (treeArray.count) {
            tree = treeArray.firstObject;
            NSLog(@" %zd ",tree.value);
            tree = tree.rightTree;
            [treeArray removeObjectAtIndex:0];
        }
    }
}

// 非递归 - 后序遍历
- (void)sufPrintWithoutRecursion {
    NSMutableArray <KKBinaryTree *>* treeArray = [NSMutableArray array];
    KKBinaryTree * tree = self;
    while (tree != nil || treeArray.count) {
        while (tree != nil) {
            [treeArray insertObject:tree atIndex:0];        //模仿栈的先进后出,后进先出
            tree = tree.leftTree;
        }
        if (treeArray.count) {
            tree = treeArray.firstObject;
            if (tree.isNotFirst) {
                NSLog(@" %zd ",tree.value);
                [treeArray removeObjectAtIndex:0];
                tree = nil;
            }else{
                tree.isNotFirst = YES;
                tree = tree.rightTree;
            }
        }
    }
}

// 非递归 - 后序遍历
- (void)sufPrintWithoutRecursionAndParam {
    NSMutableArray <KKBinaryTree *>* treeArray = [NSMutableArray array];
    KKBinaryTree * curTree = self;
    KKBinaryTree * preTree ;//前一次访问的结点
    [treeArray insertObject:self atIndex:0];
    while (treeArray.count) {
        curTree = treeArray.firstObject;
        if ((curTree.leftTree == nil && curTree.rightTree == nil) || (preTree != nil && (preTree == curTree.leftTree || preTree == curTree.rightTree))) {
            NSLog(@" %zd ",curTree.value);
            [treeArray removeObjectAtIndex:0];
            preTree = curTree;
        } else {
            if (curTree.rightTree != nil) {
                [treeArray insertObject:curTree.rightTree atIndex:0];
            }
            if (curTree.leftTree != nil) {
                [treeArray insertObject:curTree.leftTree atIndex:0];
            }
        }
    }
}

#pragma mark -
- (void)print {
    NSLog(@"\nlength:%zd    depth:%zd\n",self.length,self.depth);

    NSLog(@"广度优先遍历:\n");

    [self BFSPrint];

    NSLog(@"\n先序遍历:\n");

    [self prePrint];

    NSLog(@"\n非递归先序遍历:\n");

    [self prePrintWithoutRecursion];

    NSLog(@"\n中序遍历:\n");

    [self midPrint];

    NSLog(@"\n非递归中序遍历\n");

    [self midPrintWithoutRecursion];

    NSLog(@"\n后序遍历:\n");

    [self sufPrint];

    NSLog(@"\n非递归后序遍历:\n");

    [self sufPrintWithoutRecursion];

    NSLog(@"\n非递归后序遍历且不带isFirst参数:\n");

    [self sufPrintWithoutRecursionAndParam];
}

@end
