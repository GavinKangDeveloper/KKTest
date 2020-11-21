//
//  KKDateManager.h
//  App
//
//  Created by kangkang zhu on 2018/11/5.
//  Copyright © 2018年 xinli001. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKDateManager : NSObject

/**
 *  获取本地当前时间
 *
 *  @return 本地当前时间
 */
+ (NSDate *)localeDate;

/**
 *  根据时间字符串和其格式，获取对应的时间
 *
 *  @param dateStr 时间字符串
 *  @param format  时间字符串格式（默认值为@"yyyy-MM-dd HH:mm"）
 *
 *  @return 对应的时间
 */
+ (NSDate *)dateFromString:(NSString *)dateStr withFormat:(NSString *)format;

/**
 *  根据时间和其格式，获取对应的时间字符串
 *
 *  @param date    时间
 *  @param format  时间字符串格式（默认值为@"yyyy-MM-dd HH:mm"）
 *
 *  @return 对应的时间字符串
 */
+ (NSString *)dateToString:(NSDate *)date withFormat:(NSString *)format;

@end

NS_ASSUME_NONNULL_END
