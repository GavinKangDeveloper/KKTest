//
//  KKCountDownButton.m
//  KKTest
//
//  Created by ZhuKangKang on 2020/11/24.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import "KKCountDownButton.h"
#import <NSTimer+KKWeakTimer.h>

@interface KKCountDownButton ()

@property (nonatomic, strong) UILabel *secondLbl;
@property (nonatomic, strong) UILabel *wordLbl;
@property (nonatomic, assign) NSUInteger remainSeconds;
@property (nonatomic, strong) NSTimer *secondTimer;
@property (nonatomic, strong) NSString *originalContent;

@end

@implementation KKCountDownButton

/**
 1、init
 2、new
 3、initWithFrame:(CGRect)frame
 4、initWithFrame:(CGRect)frame style:(UITableViewStyle)style
 用代码创建的 TableView 走以下方法
 **/
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatContent];
    }
    return self;
}

/**
 用 xib 或者 storyboard 创建的 TableView 走以下方法
**/
- (instancetype)initWithCoder:(NSCoder*)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self creatContent];
      }
    return self;
}

- (void)creatContent {
    UIFont *font = [UIFont systemFontOfSize:14.0f];
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:20.0f]};

    CGSize secondLblSize = [@"60秒" boundingRectWithSize:self.frame.size
                                                 options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                              attributes:attribute
                                                 context:nil].size;

    CGSize wordLblSize = [@"后重新获取" boundingRectWithSize:self.frame.size
                                                     options:
                                                         NSStringDrawingTruncatesLastVisibleLine |
                                                         NSStringDrawingUsesLineFragmentOrigin |
                                                         NSStringDrawingUsesFontLeading
                                                  attributes:attribute
                                                     context:nil].size;

    float LABEL_LEFT = (self.frame.size.width - secondLblSize.width - wordLblSize.width) / 2;
    float LABEL_TOP = (self.frame.size.height - secondLblSize.height) / 2;
    
    CGRect rect = CGRectMake(LABEL_LEFT+5, LABEL_TOP, secondLblSize.width, secondLblSize.height);
    self.secondLbl = [[UILabel alloc] initWithFrame:rect];
    self.secondLbl.font = font;
    self.secondLbl.textColor = [UIColor whiteColor];
    self.secondLbl.textAlignment = NSTextAlignmentRight;
    self.secondLbl.hidden = YES;
    [self addSubview:self.secondLbl];
    
    rect.origin.x += rect.size.width;
    rect.size.width = wordLblSize.width;
    self.wordLbl = [[UILabel alloc] initWithFrame:rect];
    self.wordLbl.font = font;
    self.wordLbl.textColor = [UIColor whiteColor];
    self.wordLbl.textAlignment = NSTextAlignmentLeft;
    self.wordLbl.text = @"后重新获取";
    self.wordLbl.hidden = YES;
    [self addSubview:self.wordLbl];
    
    self.originalContent = @"获取验证码";
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
}

- (void)startTimer:(NSUInteger)seconds {
    self.originalContent = [self titleForState:UIControlStateNormal];
    [self setTitle:@"" forState:UIControlStateNormal];
    
    self.enabled = NO;
    self.titleLabel.hidden = YES;
    self.secondLbl.hidden = NO;
    self.wordLbl.hidden = NO;
    self.remainSeconds = seconds;
    
    self.secondLbl.text = [NSString stringWithFormat:@"%d秒", (int)self.remainSeconds];
    self.secondTimer = [NSTimer kk_scheduledWeakTimerWithTimeInterval:1.0
                                                               target:self
                                                             selector:@selector(timerExpired)
                                                             userInfo:nil
                                                              repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.secondTimer
                                 forMode:NSRunLoopCommonModes];
}

- (void)timerExpired {
    self.remainSeconds --;
    if(self.remainSeconds == 0) {
        [self stopTimer];
    } else {
        self.secondLbl.text = [NSString stringWithFormat:@"%d秒", (int)self.remainSeconds];
    }
}

- (void)stopTimer {
    self.originalContent = @"重新获取验证码";
    [self setTitle:self.originalContent forState:UIControlStateNormal];
    if([self.secondTimer isValid]) {
        [self.secondTimer invalidate];
        self.secondTimer = nil;
    }
    self.enabled = YES;
    self.titleLabel.hidden = NO;
    self.secondLbl.hidden = YES;
    self.wordLbl.hidden = YES;
}

@end
