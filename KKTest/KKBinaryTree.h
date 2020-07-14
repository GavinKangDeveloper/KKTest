//
//  KKBinaryTree.h
//  KKTest
//
//  Created by ZKKMBP on 2020/7/9.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import <Foundation/Foundation.h>



NS_ASSUME_NONNULL_BEGIN

/*
 树和二叉树有两个主要差别：
 1）树中结点的最大度数没有限制，而二叉树结点的最大度数为2
 2）树的结点无左、右之分，而二叉树的结点有左、右之分。
  
 什么是二叉排序树？（ 二叉查找树或者二叉搜索树 ）
 1）若左子树不空，则左子树上所有结点的值均小于它的根节点的值
 2）若右子树不空，则右子树上所有结点的值均大于它的根结点的值
 3）左、右子树也分别为二叉排序树
 4）没有键值相等的节点
 */

@interface KKBinaryTree : NSObject

@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong) KKBinaryTree * leftTree;
@property (nonatomic, strong) KKBinaryTree * rightTree;
@property (nonatomic, assign) BOOL isNotFirst;

- (NSInteger)depth;    //深度
- (NSInteger)length;   //所有节点的个数
- (NSInteger)maxLength;//满二叉树所有节点数
- (void)print;       //打印基本信息
- (void)BFSPrint;    //广度优先遍历:Breadth First Search
- (void)prePrint;    //先序遍历
- (void)midPrint;    //中序遍历
- (void)sufPrint;    //后序遍历
- (void)prePrintWithoutRecursion;           //非递归先序遍历
- (void)midPrintWithoutRecursion;           //非递归中序遍历
- (void)sufPrintWithoutRecursion;           //非递归后序遍历
- (void)sufPrintWithoutRecursionAndParam;   //非递归后序遍历不带isFirst参数
- (void)reverse;     //反转二叉树
+ (instancetype)createWithArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
