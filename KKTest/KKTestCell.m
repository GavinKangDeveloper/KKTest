//
//  KKTestCell.m
//  KKTest
//
//  Created by ZhuKangKang on 2020/10/30.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import "KKTestCell.h"

@interface KKTestCell ()

@end

@implementation KKTestCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
        //设置view
        [self setupView];
    }
    return self;
}

#pragma mark - View
- (void)setupView {
    
}

#pragma mark - Private


#pragma mark - Public
+ (CGFloat)getHeight {
    return 50;
}

#pragma mark - Setter


#pragma mark - Getter


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
