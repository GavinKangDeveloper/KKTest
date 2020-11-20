//
//  NSDate+FMCategory.h
//  FMPrivateLib_Example
//
//  Created by dahl.chen on 2020/8/24.
//  Copyright © 2020 lyon_lzy@sina.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (FMCategory)
#pragma mark 日期处理
/**********************************************************
 *@Description:获取当天的包括“年”，“月”，“日”，“周”，“时”，“分”，“秒”的NSDateComponents
 *@Params:nil
 *@Return:当天的包括“年”，“月”，“日”，“周”，“时”，“分”，“秒”的NSDateComponents
 ***********************************************************/
- (NSDateComponents *)fm_componentsOfDay;


- (NSInteger)fm_weekdayOrdinal;

/****************************************************
 *@Description:获得NSDate对应的年份
 *@Params:nil
 *@Return:NSDate对应的年份
 ****************************************************/
- (NSUInteger)fm_year;

/****************************************************
 *@Description:获得NSDate对应的月份
 *@Params:nil
 *@Return:NSDate对应的月份
 ****************************************************/
- (NSUInteger)fm_month;


/****************************************************
 *@Description:获得NSDate对应的日期
 *@Params:nil
 *@Return:NSDate对应的日期
 ****************************************************/
- (NSUInteger)fm_day;


/****************************************************
 *@Description:获得NSDate对应的小时数
 *@Params:nil
 *@Return:NSDate对应的小时数
 ****************************************************/
- (NSUInteger)fm_hour;


/****************************************************
 *@Description:获得NSDate对应的分钟数
 *@Params:nil
 *@Return:NSDate对应的分钟数
 ****************************************************/
- (NSUInteger)fm_minute;


/****************************************************
 *@Description:获得NSDate对应的秒数
 *@Params:nil
 *@Return:NSDate对应的秒数
 ****************************************************/
- (NSUInteger)fm_second;

/****************************************************
 *@Description:获得NSDate对应的星期
 *@Params:nil
 *@Return:NSDate对应的星期
 ****************************************************/
- (NSUInteger)fm_weekday;

/****************************************************
 *@Description:获得NSDate对应的周几
 *@Params:nil
 *@Return:NSDate对应的星期
 ****************************************************/
- (NSString *)fm_weekdayString;

/****************************************************
 *@Description:获得NSDate对应的周数
 *@Params:nil
 *@Return:NSDate对应的周数
 ****************************************************/
- (NSUInteger)fm_week;

/******************************************
 *@Description:获取当天的起始时间（00:00:00）
 *@Params:nil
 *@Return:当天的起始时间
 ******************************************/
- (NSDate *)fm_beginingOfDay;

/******************************************
 *@Description:获取当天的结束时间（23:59:59）
 *@Params:nil
 *@Return:当天的结束时间
 ******************************************/
- (NSDate *)fm_endOfDay;


/******************************************
 *@Description:获取当月的第一天
 *@Params:nil
 *@Return:当月的第一天
 ******************************************/
- (NSDate *)fm_firstDayOfTheMonth;

/******************************************
 *@Description:获取当月的最后一天
 *@Params:nil
 *@Return:当月的最后一天
 ******************************************/
- (NSDate *)fm_lastDayOfTheMonth;


/******************************************
 *@Description:获取前一个月的第一天
 *@Params:nil
 *@Return:前一个月的第一天
 ******************************************/
- (NSDate *)fm_firstDayOfThePreviousMonth;

/******************************************
 *@Description:获取后一个月的第一天
 *@Params:nil
 *@Return:后一个月的第一天
 ******************************************/
- (NSDate *)fm_firstDayOfTheFollowingMonth;

/******************************************
 *@Description:获取前一个月中与当天对应的日期
 *@Params:nil
 *@Return:前一个月中与当天对应的日期
 ******************************************/
- (NSDate *)fm_associateDayOfThePreviousMonth;

/******************************************
 *@Description:获取后两个分
 *@Params:nil
 *@Return:后两分钟
 ******************************************/
- (NSDate *)fm_associateDayOfTheFollowingMinute;
/******************************************
 *@Description:获取后一个小时
 *@Params:nil
 *@Return:后一个小时
 ******************************************/
- (NSDate *)fm_associateDayOfTheFollowingHour;
/******************************************
 *@Description:获取后一个月中与当天对应的日期
 *@Params:nil
 *@Return:后一个月中与当天对应的日期
 ******************************************/
- (NSDate *)fm_associateDayOfTheFollowingMonth;

/******************************************
 *@Description:获取后一个年中与当天对应的日期
 *@Params:nil
 *@Return:后一个年中与当天对应的日期
 ******************************************/
- (NSDate *)fm_associateDayOfTheFollowingYear;

/******************************************
 *@Description:获取当月的天数
 *@Params:nil
 *@Return:当月的天数
 ******************************************/
- (NSUInteger)fm_numberOfDaysInMonth;

/******************************************
 *@Description:获取当月的周数
 *@Params:nil
 *@Return:当月的周数
 ******************************************/
- (NSUInteger)fm_numberOfWeeksInMonth;


/******************************************
 *@Description:获取这一周的第一天
 *@Params:nil
 *@Return:这一周的第一天
 ******************************************/
- (NSDate *)fm_firstDayOfTheWeek;

/******************************************
 *@Description:获取当月中，前一周的第一天
 *@Params:nil
 *@Return:前一周的第一天
 ******************************************/
- (NSDate *)fm_firstDayOfThePreviousWeekInTheMonth;

/******************************************
 *@Description:获取前一个月中，最后一周的第一天
 *@Params:nil
 *@Return:前一个月中，最后一周的第一天
 ******************************************/
- (NSDate *)fm_firstDayOfTheLastWeekInPreviousMonth;

/******************************************
 *@Description:获取当月中，后一周的第一天
 *@Params:nil
 *@Return:后一周的第一天
 ******************************************/
- (NSDate *)fm_firstDayOfTheFollowingWeekInTheMonth;

/******************************************
 *@Description:获取下一个月中，最前一周的第一天
 *@Params:nil
 *@Return:下一个月中，最前一周的第一天
 ******************************************/
- (NSDate *)fm_firstDayOfTheFirstWeekInFollowingMonth;


/******************************************
 *@Description:获取当月中，这一周的第一天
 *@Params:nil
 *@Return:当月中，这一周的第一天
 ******************************************/
- (NSDate *)fm_firstDayOfTheWeekInTheMonth;

/******************************************
 *@Description:获取当月中，这一周的天数
 *@Params:nil
 *@Return:当月中，这一周的天数
 ******************************************/
- (NSUInteger)fm_numberOfDaysInTheWeekInMonth;


/******************************************
 *@Description:获取当天是当月的第几周
 *@Params:nil
 *@Return:当天是当月的第几周
 ******************************************/
- (NSUInteger)fm_weekOfDayInMonth;

/******************************************
 *@Description:获取当天是当年的第几周
 *@Params:nil
 *@Return:当天是当年的第几周
 ******************************************/
- (NSUInteger)fm_weekOfDayInYear;


/******************************************
 *@Description:获取前一周中与当天对应的日期
 *@Params:nil
 *@Return:前一个周中与当天对应的日期
 ******************************************/
- (NSDate *)fm_associateDayOfThePreviousWeek;

/******************************************
 *@Description:获取后一周中与当天对应的日期
 *@Params:nil
 *@Return:后一周中与当天对应的日期
 ******************************************/
- (NSDate *)fm_associateDayOfTheFollowingWeek;



/******************************************
 *@Description:前一天
 *@Params:nil
 *@Return:前一天
 ******************************************/
- (NSDate *)fm_previousDay;

/******************************************
 *@Description:后多少分钟
 *@Params:
 *  num:分钟
 *@Return:后num分钟的日期
 ******************************************/
- (NSDate *)fm_followingMinuteWithNum:(NSInteger)num;

/******************************************
 *@Description:后一天
 *@Params:nil
 *@Return:后一天
 ******************************************/
- (NSDate *)fm_followingDay;

/******************************************
 *@Description:判断与某一天是否为同一天
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一天；NO-不同一天
 ******************************************/
- (BOOL)fm_sameDayWithDate:(NSDate *)otherDate;

/******************************************
 *@Description:判断与某一天是否为同一周
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一周；NO-不同一周
 ******************************************/
- (BOOL)fm_sameWeekWithDate:(NSDate *)otherDate;

/******************************************
 *@Description:判断与某一天是否为同一月
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一月；NO-不同一月
 ******************************************/
- (BOOL)fm_sameMonthWithDate:(NSDate *)otherDate;

/******************************************
 *@Description:判断是否是早于某一天的
 *@Params:
 *  otherDate:某一天
 *@Return:YES-早于；NO-不早于
 ******************************************/
- (BOOL)fm_isBeforeWithDate:(NSDate *)otherDate;

/******************************************
 *@Description:前多少天
 *@Params:
 *  num:天数
 *@Return:前num天的日期
 ******************************************/
- (NSDate *)fm_previousDayWithNum:(NSInteger)num;

/******************************************
 *@Description:后多少天
 *@Params:
 *  num:天数
 *@Return:后num天的日期
 ******************************************/
- (NSDate *)fm_followingDayWithNum:(NSInteger)num;

/******************************************
 *@Description:转换字符串 格式yyyy-MM-dd
 *@Return:日期字符串
 ******************************************/
- (NSString *)fm_stringFromDate:(NSString *)dateString;
- (NSDate *)fm_dateFormString:(NSString *)dateString;
/******************************************
 UTC时间
*@Description:转换字符串 格式yyyy-MM-dd
*@Return:日期字符串
******************************************/
- (NSString *)fm_UTCStringFromDate:(NSString *)dateString;
/** 小视频时区*/
- (NSString *)fm_specialVideoStringFromDate:(NSString *)dateString;

/******************************************
 *@Description:开始和结束时间差
 *@Return:天数差
 ******************************************/
- (NSInteger)fm_dayWithEndDate:(NSDate *)end;

/******************************************
 *@Description:开始和结束时间差
 *@Return:分钟差
 ******************************************/

- (NSInteger)fm_minuteWithEndDate:(NSDate *)end;

@end

NS_ASSUME_NONNULL_END
