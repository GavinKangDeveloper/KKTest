//
//  ViewController.m
//  KKTest
//
//  Created by ZKKMBP on 2020/6/29.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import "ViewController.h"
#import "KKSecondVC.h"
#import "NSDate+Extension.h"
#import <BRPickerView.h>

@interface ViewController ()<UIScrollViewDelegate ,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnTemp;
@property (weak, nonatomic) IBOutlet UITextView *textV;
@property (weak, nonatomic) IBOutlet UITextField *textF;
@property (nonatomic, strong) NSMutableArray *arrs;
@property (nonatomic, strong) BRDatePickerView* pickerView;
@property (nonatomic, strong) NSDate *selectDate;
@property (nonatomic, strong) NSString *selectDateStr;
@property (nonatomic, strong) BRStringPickerView *pinDaoPickerView;
@property (nonatomic, copy) NSArray <NSNumber *> *linkage2SelectIndexs;

@end

@implementation ViewController

/// 测试 git 添加、推送的流程
- (void)viewDidLoad {
    [super viewDidLoad];

    self.textV.delegate = self;
 
    self.arrs = [[NSMutableArray alloc] initWithObjects:@"0", nil];
   
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.pickerView.selectDate = self.selectDate;
    self.pickerView.title = self.selectDateStr;

    // 3.显示
//    [self.pickerView show];
    
    /// 3.多列字符串选择器
    [self.pinDaoPickerView show];
}

- (BRStringPickerView *)pinDaoPickerView {
    if (!_pinDaoPickerView) {
        kkFuncWeakSelf(self);
        _pinDaoPickerView = [[BRStringPickerView alloc]init];
        _pinDaoPickerView.pickerMode = BRStringPickerComponentLinkage;
        _pinDaoPickerView.title = @"二级联动选择";
        //_pinDaoPickerView.dataSourceArr = [self getLinkag2DataSource];
        _pinDaoPickerView.dataSourceArr = [self getStagesDataSource];
        _pinDaoPickerView.selectIndexs = self.linkage2SelectIndexs;
        _pinDaoPickerView.numberOfComponents = 2;
        _pinDaoPickerView.resultModelArrayBlock = ^(NSArray<BRResultModel *> *resultModelArr) {
            // 1.选择的索引
            NSMutableArray *selectIndexs = [[NSMutableArray alloc]init];
            // 2.选择的值
            NSString *selectValue = @"";
            for (BRResultModel *model in resultModelArr) {
                [selectIndexs addObject:@(model.index)];
                selectValue = [NSString stringWithFormat:@"%@ %@", selectValue, model.value];
            }
            if ([selectValue hasPrefix:@" "]) {
                selectValue = [selectValue substringFromIndex:1];
            }
            weakself.linkage2SelectIndexs = selectIndexs;
            NSLog(@"--Value----%@-----selectIndexs----%@",selectValue,selectIndexs);
        };
        
        // 设置选择器中间选中行的样式
        BRPickerStyle *customStyle = [[BRPickerStyle alloc]init];
        customStyle.selectRowTextFont = [UIFont boldSystemFontOfSize:20.0f];
        customStyle.selectRowTextColor = [UIColor blueColor];
        _pinDaoPickerView.pickerStyle = customStyle;
    }
    return _pinDaoPickerView;
}

- (NSArray <BRResultModel *>*)getStagesDataSource {
    // 获取本地数据源
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"stages.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *responseObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *dataArr = responseObj[@"GetStageInfoDto"];
    
    NSMutableArray *listModelArr = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in dataArr) {
        BRResultModel *model = [[BRResultModel alloc]init];
        model.parentKey = @"-1";
        model.parentValue = @"";
        model.key = dic[@"StageID"];
        model.value = dic[@"Name"];
        [listModelArr addObject:model];
        
        for (NSDictionary *param in dic[@"GetGradeInfoDto"]) {
            BRResultModel *model1 = [[BRResultModel alloc]init];
            model1.parentKey = param[@"StageID"];
            model1.parentValue = dic[@"Name"];
            model1.key = param[@"GradeID"];
            model1.value = param[@"Name"];
            [listModelArr addObject:model1];
        }
    }
    return [listModelArr copy];
}

- (BRDatePickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[BRDatePickerView alloc]init];
        // 2.设置属性
        _pickerView.pickerMode = BRDatePickerModeYMDHM;
//        _pickerView.selectValue = @"2019-10-30";
        _pickerView.minDate = [NSDate date];
//        _pickerView.maxDate = [NSDate date];
        _pickerView.showToday = YES;
        _pickerView.isAutoSelect = YES;
        kkFuncWeakSelf(self);
        _pickerView.resultBlock = ^(NSDate *selectDate, NSString *selectValue) {
            NSLog(@"选择的值：++++++ %@", selectValue);
            weakself.selectDate = selectDate;
            weakself.selectDateStr = selectValue;
        };
        // 设置自定义样式
        BRPickerStyle *customStyle = [[BRPickerStyle alloc]init];
        customStyle.pickerColor = BR_RGB_HEX(0xd9dbdf, 1.0f);
        customStyle.pickerTextColor = [UIColor redColor];
        customStyle.separatorColor = [UIColor redColor];
        customStyle.selectRowColor = [UIColor redColor];
        customStyle.selectRowTextColor = [UIColor greenColor];
        _pickerView.pickerStyle = customStyle;
    }
    return _pickerView;
}

- (IBAction)onButtonClicked:(UIButton *)sender {
    NSLog(@"--------");
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

- (void)gotoSecondVC {
    KKSecondVC * VC = [[KKSecondVC  alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}


@end
