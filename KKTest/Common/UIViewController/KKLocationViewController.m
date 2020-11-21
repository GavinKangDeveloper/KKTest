//
//  KKLocationViewController.m
//  App
//
//  Created by kangkang zhu on 2018/10/18.
//  Copyright © 2018年 xinli001. All rights reserved.
//

#import "KKLocationViewController.h"

@interface KKLocationViewController ()<CLLocationManagerDelegate>

//获得定位的地址
@property (strong, nonatomic) CLLocationManager * locationManager;
@property (strong, nonatomic) CLLocation *location;

@end

@implementation KKLocationViewController

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear: animated];
    //        关闭定位
    [self.locationManager stopUpdatingLocation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self openLocation];//加载定位
}

#pragma mark-- 开启定位
-(void)openLocation {
    if ([CLLocationManager locationServicesEnabled]  //确定用户的位置服务启用
        &&[CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied) {
        [self locationResultCLPlacemark:nil location:nil];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"打开定位" message:@"定位服务未开启，请进入系统［设置］> [隐私] > [定位服务]中打开定位服务" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"立即开启" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [KKCommonMethodManager openSetting];
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertController addAction:cancel];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    self.locationManager = [[CLLocationManager alloc] init];
    if ([CLLocationManager locationServicesEnabled]) {
        // 请求验证是否允许开启定位服务
        [self.locationManager requestWhenInUseAuthorization];
        // 开始定位
        [self.locationManager startUpdatingLocation];
        self.locationManager.delegate=self;
        // 可以设置定位服务的精度
        self.locationManager.distanceFilter=kCLLocationAccuracyNearestTenMeters;
    }
}

// 定位失败弹出提示框.点击"打开定位"
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    // 设置提示提醒用户打开定位服务
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"允许\"定位\"提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [KKCommonMethodManager openSetting];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:cancel];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark-- 定位代理方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    self.location= locations[0];//取出第一个位置
    [_locationManager stopUpdatingLocation];
    CLGeocoder *_geocoder = [[CLGeocoder alloc] init];
    
    CLLocation *newLocation = [[CLLocation alloc] initWithLatitude:self.location.coordinate.latitude longitude:self.location.coordinate.longitude];
    
    
    __weak typeof(self) weakSelf = self;
    [_geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            [weakSelf locationResultCLPlacemark:placemarks[0] location:locations[0]];
        }else{
            [weakSelf locationResultCLPlacemark:nil location:nil];
        }
    }];
    
}

-(void)locationResultCLPlacemark:(CLPlacemark*)locationPlace location:(CLLocation *)location {
    
}

-(void)locationResultCLPlacemark:(CLPlacemark *)locationPlace {
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
