//
//  ViewController.m
//  KKTest
//
//  Created by ZKKMBP on 2020/6/29.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import "ViewController.h"
#import "KKSecondVC.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
  
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UICollectionView *collectionView;
/**之前选中cell的NSIndexPath*/
@property (nonatomic, strong) NSIndexPath *oldIndexPath;
/**单元格的截图*/
@property (nonatomic, strong) UIView *snapshotView;
/**之前选中cell的NSIndexPath*/
@property (nonatomic, strong) NSIndexPath *moveIndexPath;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CGFloat SCREEN_WIDTH = self.view.frame.size.width;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH-40.0)/3, (SCREEN_WIDTH-40.0)/3);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50.0, 414, 400) collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"uicollectionviewcell"];
    [self.view addSubview:self.collectionView = collectionView];
     
    // 添加长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlelongGesture:)];
    [collectionView addGestureRecognizer:longPress];
    
    self.dataArr = [[NSMutableArray alloc] init];
    for (NSInteger index = 0; index < 50; index ++) {
        CGFloat hue = (arc4random()%256/256.0); //0.0 到 1.0
        CGFloat saturation = (arc4random()%128/256.0)+0.5; //0.5 到 1.0
        CGFloat brightness = (arc4random()%128/256.0)+0.5; //0.5 到 1.0
        UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:0.5];
        [self.dataArr addObject:color];
      }
 
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return self.dataArr.count;
}
  
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"uicollectionviewcell" forIndexPath:indexPath];
  cell.backgroundColor = self.dataArr[indexPath.row];
  return cell;
}

#pragma mark - 长按手势
- (void)handlelongGesture:(UILongPressGestureRecognizer *)longPress
{
  [self iOS9_Action:longPress];
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
  // 返回YES允许row移动
  return YES;
}
  
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if (destinationIndexPath.item > 10) {
        NSLog(@"---只能移动在 item 为 10 以内");
        return;
    }
  id color = self.dataArr[sourceIndexPath.row];
  [self.dataArr removeObject:color];
  [self.dataArr insertObject:color atIndex:destinationIndexPath.row];
}
  
- (void)iOS9_Action:(UILongPressGestureRecognizer *)longPress {
  switch (longPress.state) {
    case UIGestureRecognizerStateBegan: { //手势开始
        self.moveIndexPath = [self.collectionView indexPathForItemAtPoint:[longPress locationInView:self.collectionView]];
        if (self.moveIndexPath.item < 7) {
        break;
      }
      UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:self.moveIndexPath];
      [self.view bringSubviewToFront:cell];
      [self.collectionView beginInteractiveMovementForItemAtIndexPath:self.moveIndexPath];
    }
      break;
    case UIGestureRecognizerStateChanged: { // 手势改变
      [self.collectionView updateInteractiveMovementTargetPosition:[longPress locationInView:self.collectionView]];
    }
      break;
    case UIGestureRecognizerStateEnded: { // 手势结束
      [self.collectionView endInteractiveMovement];
    }
      break;
    default: //手势其他状态
      [self.collectionView cancelInteractiveMovement];
      break;
  }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

}

- (void)gotoSecondVC {
    KKSecondVC * VC = [[KKSecondVC  alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}


@end
