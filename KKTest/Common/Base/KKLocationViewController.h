//
//  KKLocationViewController.h
//  App
//
//  Created by kangkang zhu on 2018/10/18.
//  Copyright © 2018年 xinli001. All rights reserved.
//

#import "KKBaseViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface KKLocationViewController : KKBaseViewController
-(void)locationResultCLPlacemark:(CLPlacemark*)locationPlace location:(CLLocation *)location;

@end
