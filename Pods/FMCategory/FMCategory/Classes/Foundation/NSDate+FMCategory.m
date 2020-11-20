//
//  NSDate+FMCategory.m
//  FMPrivateLib_Example
//
//  Created by dahl.chen on 2020/8/24.
//  Copyright © 2020 lyon_lzy@sina.cn. All rights reserved.
//

#import "NSDate+FMCategory.h"

@implementation NSDate (FMCategory)
#pragma mark 日期处理
static NSDateFormatter * dateFormatter;
static NSDateFormatter * utcDateForMatter;

/**********************************************************
 *@Description:获取当天的包括“年”，“月”，“日”，“周”，“时”，“分”，“秒”的NSDateComponents
 *@Params:nil
 *@Return:当天的包括“年”，“月”，“日”，“周”，“时”，“分”，“秒”的NSDateComponents
 ***********************************************************/
- (NSDateComponents *)fm_componentsOfDay
{
    static NSDateComponents *dateComponents = nil;
    static NSDate *previousDate = nil;
    
    if (!previousDate || ![previousDate isEqualToDate:self]) {
        previousDate = self;
        dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekOfMonth| NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self];
    }
    
    return dateComponents;
}


//  --------------------------NSDate---------------------------
- (NSInteger)fm_weekdayOrdinal
{
    return self.fm_weekdayOrdinal;
}


/****************************************************
 *@Description:获得NSDate对应的年份
 *@Params:nil
 *@Return:NSDate对应的年份
 ****************************************************/
- (NSUInteger)fm_year
{
    return [self fm_componentsOfDay].year;
}

/****************************************************
 *@Description:获得NSDate对应的月份
 *@Params:nil
 *@Return:NSDate对应的月份
 ****************************************************/
- (NSUInteger)fm_month
{
    return [self fm_componentsOfDay].month;
}


/****************************************************
 *@Description:获得NSDate对应的日期
 *@Params:nil
 *@Return:NSDate对应的日期
 ****************************************************/
- (NSUInteger)fm_day
{
    return [self fm_componentsOfDay].day;
}


/****************************************************
 *@Description:获得NSDate对应的小时数
 *@Params:nil
 *@Return:NSDate对应的小时数
 ****************************************************/
- (NSUInteger)fm_hour
{
    return [self fm_componentsOfDay].hour;
}


/****************************************************
 *@Description:获得NSDate对应的分钟数
 *@Params:nil
 *@Return:NSDate对应的分钟数
 ****************************************************/
- (NSUInteger)fm_minute
{
    return [self fm_componentsOfDay].minute;
}


/****************************************************
 *@Description:获得NSDate对应的秒数
 *@Params:nil
 *@Return:NSDate对应的秒数
 ****************************************************/
- (NSUInteger)fm_second
{
    return [self fm_componentsOfDay].second;
}

/****************************************************
 *@Description:获得NSDate对应的星期
 *@Params:nil
 *@Return:NSDate对应的星期
 ****************************************************/
- (NSUInteger)fm_weekday
{
    return [self fm_componentsOfDay].weekday;
}

- (NSString *)fm_weekdayString
{
    NSUInteger weekday = [self fm_componentsOfDay].weekday;
    NSArray * dayArray = @[@"2",@"3",@"4",@"5",@"6",@"7",@"1"];
    NSArray * weekArray = @[@"一",@"二",@"三",@"四",@"五",@"六",@"日"];
    return [weekArray objectAtIndex:[dayArray indexOfObject:[NSString stringWithFormat:@"%lu",(unsigned long)weekday]]];
}

/****************************************************
 *@Description:获得NSDate对应的周数
 *@Params:nil
 *@Return:NSDate对应的周数
 ****************************************************/
- (NSUInteger)fm_week
{
    return [self fm_componentsOfDay].weekOfMonth;
}

/******************************************
 *@Description:获取当天的起始时间（00:00:00）
 *@Params:nil
 *@Return:当天的起始时间
 ******************************************/
- (NSDate *)fm_beginingOfDay
{
    [[self fm_componentsOfDay] setHour:0];
    [[self fm_componentsOfDay] setMinute:0];
    [[self fm_componentsOfDay] setSecond:0];
    
    return [[NSCalendar currentCalendar] dateFromComponents:[self fm_componentsOfDay]];
}

/******************************************
 *@Description:获取当天的结束时间（23:59:59）
 *@Params:nil
 *@Return:当天的结束时间
 ******************************************/
- (NSDate *)fm_endOfDay
{
    [[self fm_componentsOfDay] setHour:23];
    [[self fm_componentsOfDay] setMinute:59];
    [[self fm_componentsOfDay] setSecond:59];
    
    return [[NSCalendar currentCalendar] dateFromComponents:[self fm_componentsOfDay]];
}

/******************************************
 *@Description:获取当月的第一天
 *@Params:nil
 *@Return:当月的第一天
 ******************************************/
- (NSDate *)fm_firstDayOfTheMonth
{
    [[self fm_componentsOfDay] setDay:1];
    return [[NSCalendar currentCalendar] dateFromComponents:[self fm_componentsOfDay]];
}

/******************************************
 *@Description:获取当月的最后一天
 *@Params:nil
 *@Return:当月的最后一天
 ******************************************/
- (NSDate *)fm_lastDayOfTheMonth
{
    [[self fm_componentsOfDay] setDay:[self fm_numberOfDaysInMonth]];
    return [[NSCalendar currentCalendar] dateFromComponents:[self fm_componentsOfDay]];
}

/******************************************
 *@Description:获取前一个月的第一天
 *@Params:nil
 *@Return:前一个月的第一天
 ******************************************/
- (NSDate *)fm_firstDayOfThePreviousMonth
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = -1;
    
    return [[[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0] fm_firstDayOfTheMonth];
}

/******************************************
 *@Description:获取后一个月的第一天
 *@Params:nil
 *@Return:后一个月的第一天
 ******************************************/
- (NSDate *)fm_firstDayOfTheFollowingMonth
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = 1;

    return [[[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0] fm_firstDayOfTheMonth];
}


/******************************************
 *@Description:获取前一个月中与当天对应的日期
 *@Params:nil
 *@Return:前一个月中与当天对应的日期
 ******************************************/
- (NSDate *)fm_associateDayOfThePreviousMonth
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = -1;
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

/******************************************
 *@Description:获取后两个分
 *@Params:nil
 *@Return:后两分钟
 ******************************************/
- (NSDate *)fm_associateDayOfTheFollowingMinute
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.minute = 10;
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

/******************************************
 *@Description:获取后一个小时
 *@Params:nil
 *@Return:后一个小时
 ******************************************/
- (NSDate *)fm_associateDayOfTheFollowingHour
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.hour = 1;
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

/******************************************
 *@Description:获取后一个月中与当天对应的日期
 *@Params:nil
 *@Return:后一个月中与当天对应的日期
 ******************************************/
- (NSDate *)fm_associateDayOfTheFollowingMonth
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = 1;
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

/******************************************
 *@Description:获取后一个年中与当天对应的日期
 *@Params:nil
 *@Return:后一个年中与当天对应的日期
 ******************************************/
- (NSDate *)fm_associateDayOfTheFollowingYear
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = 1;
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

/******************************************
 *@Description:获取当月的天数
 *@Params:nil
 *@Return:当月的天数
 ******************************************/
- (NSUInteger)fm_numberOfDaysInMonth
{
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
}


/******************************************
 *@Description:获取当月的周数
 *@Params:nil
 *@Return:当月的周数
 ******************************************/
- (NSUInteger)fm_numberOfWeeksInMonth
{
    NSUInteger weekOfFirstDay = [[self fm_firstDayOfTheMonth] fm_componentsOfDay].weekday;
    NSUInteger numberDaysInMonth = [self fm_numberOfDaysInMonth];
    
    return ((weekOfFirstDay - 1 + numberDaysInMonth) % 7) ? ((weekOfFirstDay - 1 + numberDaysInMonth) / 7 + 1): ((weekOfFirstDay - 1 + numberDaysInMonth) / 7);
}


/******************************************
 *@Description:获取这一周的第一天
 *@Params:nil
 *@Return:这一周的第一天
 ******************************************/
- (NSDate *)fm_firstDayOfTheWeek
{
    NSDate *firstDay = nil;
    if ([[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitWeekOfMonth startDate:&firstDay interval:NULL forDate:self]) {
        return firstDay;
    }
    
    return firstDay;
}

/******************************************
 *@Description:获取当月中，前一周的第一天
 *@Params:nil
 *@Return:前一周的第一天
 ******************************************/
- (NSDate *)fm_firstDayOfThePreviousWeekInTheMonth
{
    NSDate *firstDayOfTheWeekInTheMonth = [self fm_firstDayOfTheWeekInTheMonth];
    if ([firstDayOfTheWeekInTheMonth fm_componentsOfDay].weekday > 1) {
        return nil;
    } else {
        if ([firstDayOfTheWeekInTheMonth fm_componentsOfDay].day > 7) {
            NSDateComponents *components = [[NSDateComponents alloc] init];
            components.day = -7;
            return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
        } else if ([firstDayOfTheWeekInTheMonth fm_componentsOfDay].day > 1) {
            return [self fm_firstDayOfTheMonth];
        } else {
            return nil;
        }
    }
}

/******************************************
 *@Description:获取前一个月中，最后一周的第一天
 *@Params:nil
 *@Return:前一个月中，最后一周的第一天
 ******************************************/
- (NSDate *)fm_firstDayOfTheLastWeekInPreviousMonth
{
    NSDate *firstDayOfThePreviousMonth = [self fm_firstDayOfThePreviousMonth];
    NSUInteger numberOfDaysInPreviousMonth = [firstDayOfThePreviousMonth fm_numberOfDaysInMonth];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = [firstDayOfThePreviousMonth fm_componentsOfDay].year;
    components.month = [firstDayOfThePreviousMonth fm_componentsOfDay].month;
    components.day = numberOfDaysInPreviousMonth;
    NSDate *lastDayOfThePreviousMonth = [[NSCalendar currentCalendar] dateFromComponents:components];
    
    return [lastDayOfThePreviousMonth fm_firstDayOfTheWeekInTheMonth];
}


/******************************************
 *@Description:获取当月中，后一周的第一天
 *@Params:nil
 *@Return:后一周的第一天
 ******************************************/
- (NSDate *)fm_firstDayOfTheFollowingWeekInTheMonth
{
    NSDate *firstDayOfTheWeekInTheMonth = [self fm_firstDayOfTheWeekInTheMonth];
    NSUInteger numberOfDaysInMonth = [self fm_numberOfDaysInMonth];
    if (([firstDayOfTheWeekInTheMonth fm_componentsOfDay].day + 6) >= numberOfDaysInMonth) {
        return nil;
    } else {
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.day = 6;
        return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
    }
}

/******************************************
 *@Description:获取下一个月中，最前一周的第一天
 *@Params:nil
 *@Return:下一个月中，最前一周的第一天
 ******************************************/
- (NSDate *)fm_firstDayOfTheFirstWeekInFollowingMonth
{
    NSDate *firstDayOfTheFollowingMonth = [self fm_firstDayOfTheFollowingMonth];
    
    return [firstDayOfTheFollowingMonth fm_firstDayOfTheWeekInTheMonth];
}


/******************************************
 *@Description:获取当月中，这一周的第一天
 *@Params:nil
 *@Return:当月中，这一周的第一天
 ******************************************/
- (NSDate *)fm_firstDayOfTheWeekInTheMonth
{
    NSDate *firstDayOfTheWeek = nil;
    if ([[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitWeekOfMonth startDate:&firstDayOfTheWeek interval:NULL forDate:self]) {
        NSDate *firstDayOfTheMonth = [self fm_firstDayOfTheMonth];
        if ([firstDayOfTheWeek fm_componentsOfDay].month == [firstDayOfTheMonth fm_componentsOfDay].month) {
            return firstDayOfTheWeek;
        } else {
            return firstDayOfTheMonth;
        }
    }
    
    return firstDayOfTheWeek;
}


/******************************************
 *@Description:获取当月中，这一周的天数
 *@Params:nil
 *@Return:当月中，这一周的天数
 ******************************************/
- (NSUInteger)fm_numberOfDaysInTheWeekInMonth
{
    NSDate *firstDayOfTheWeek = [self fm_firstDayOfTheWeek];
    NSDate *firstDayOfTheWeekInTheMonth = [self fm_firstDayOfTheWeekInTheMonth];
    
    if ([firstDayOfTheWeek fm_componentsOfDay].month == [firstDayOfTheWeekInTheMonth fm_componentsOfDay].month) {
        return (firstDayOfTheWeek.fm_numberOfDaysInMonth - [firstDayOfTheWeek fm_componentsOfDay].day + 1) >= 7 ? 7 : (firstDayOfTheWeek.fm_numberOfDaysInMonth - [firstDayOfTheWeek fm_componentsOfDay].day + 1);
    } else {
        return (8 - [firstDayOfTheWeekInTheMonth fm_componentsOfDay].weekday);
    }
}

/******************************************
 *@Description:获取当天是当月的第几周
 *@Params:nil
 *@Return:当天是当月的第几周
 ******************************************/
- (NSUInteger)fm_weekOfDayInMonth
{
    NSDate *firstDayOfTheMonth = [self fm_firstDayOfTheMonth];
    NSUInteger weekdayOfFirstDayOfTheMonth = [firstDayOfTheMonth fm_componentsOfDay].weekday;
    NSUInteger day = [self fm_componentsOfDay].day;
    
    return ((day + weekdayOfFirstDayOfTheMonth - 1)%7) ? ((day + weekdayOfFirstDayOfTheMonth - 1)/7) + 1: ((day + weekdayOfFirstDayOfTheMonth - 1)/7);
}

/******************************************
 *@Description:获取当天是当年的第几周
 *@Params:nil
 *@Return:当天是当年的第几周
 ******************************************/
- (NSUInteger)fm_weekOfDayInYear
{
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitWeekOfYear inUnit:NSCalendarUnitYear forDate:self];
}

/******************************************
 *@Description:获取前一周中与当天对应的日期
 *@Params:nil
 *@Return:前一个周中与当天对应的日期
 ******************************************/
- (NSDate *)fm_associateDayOfThePreviousWeek
{
    NSUInteger day = [self fm_componentsOfDay].day;
    NSUInteger weekday = [self fm_componentsOfDay].weekday;
    
    if (day > 7) {
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.day = -7;
                
        return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
    } else if (day > weekday) {
        
        return [self fm_firstDayOfTheMonth];
    } else {
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.day = -1;
        
        return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:[self fm_firstDayOfTheWeekInTheMonth] options:0];
    }
}

/******************************************
 *@Description:获取后一周中与当天对应的日期
 *@Params:nil
 *@Return:后一周中与当天对应的日期
 ******************************************/
- (NSDate *)fm_associateDayOfTheFollowingWeek
{
    NSUInteger numberOfDaysInMonth = [self fm_numberOfDaysInMonth];
    NSUInteger day = [self fm_componentsOfDay].day;
    NSUInteger weekday = [self fm_componentsOfDay].weekday;
    if (day + 7 <= numberOfDaysInMonth) {
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.day = 7;
        
        return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
    } else if ((day + (7 - weekday + 1)) <= numberOfDaysInMonth) {
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.day = numberOfDaysInMonth - day;
        
        return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
    } else {
        return [self fm_firstDayOfTheFollowingMonth];
    }
}


/******************************************
 *@Description:前一天
 *@Params:nil
 *@Return:前一天
 ******************************************/
- (NSDate *)fm_previousDay
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = -1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}



/******************************************
 *@Description:后一天
 *@Params:nil
 *@Return:后一天
 ******************************************/
- (NSDate *)fm_followingDay
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = 1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}


/******************************************
 *@Description:判断与某一天是否为同一天
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一天；NO-不同一天
 ******************************************/
- (BOOL)fm_sameDayWithDate:(NSDate *)otherDate
{
    if (self.fm_year == otherDate.fm_year && self.fm_month == otherDate.fm_month && self.fm_day == otherDate.fm_day) {
        return YES;
    } else {
        return NO;
    }
}


/******************************************
 *@Description:判断与某一天是否为同一周
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一周；NO-不同一周
 ******************************************/
- (BOOL)fm_sameWeekWithDate:(NSDate *)otherDate
{
    if (self.fm_year == otherDate.fm_year  && self.fm_month == otherDate.fm_month && self.fm_weekOfDayInYear == otherDate.fm_weekOfDayInYear) {
        return YES;
    } else {
        return NO;
    }
}

/******************************************
 *@Description:判断与某一天是否为同一月
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一月；NO-不同一月
 ******************************************/
- (BOOL)fm_sameMonthWithDate:(NSDate *)otherDate
{
    if (self.fm_year == otherDate.fm_year && self.fm_month == otherDate.fm_month) {
        return YES;
    } else {
        return NO;
    }
}

/******************************************
 *@Description:判断是否是早于某一天的
 *@Params:
 *  otherDate:某一天
 *@Return:YES-早于；NO-不早于
 ******************************************/
- (BOOL)fm_isBeforeWithDate:(NSDate *)otherDate
{
    if (self.fm_year<otherDate.fm_year) {
        return YES;
    }
    if (self.fm_year==otherDate.fm_year && self.fm_month<otherDate.fm_month) {
        return YES;
    }
    if (self.fm_year==otherDate.fm_year && self.fm_month==otherDate.fm_month && self.fm_day<otherDate.fm_day) {
        return YES;
    }
    return NO;
}

/******************************************
 *@Description:前多少天
 *@Params:
 *  num:天数
 *@Return:前num天的日期
 ******************************************/
- (NSDate *)fm_previousDayWithNum:(NSInteger)num
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = -num;
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

/******************************************
 *@Description:后多少分钟
 *@Params:
 *  num:分钟
 *@Return:后num分钟的日期
 ******************************************/
- (NSDate *)fm_followingMinuteWithNum:(NSInteger)num
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.minute = num;
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

/******************************************
 *@Description:后多少天
 *@Params:
 *  num:天数
 *@Return:后num天的日期
 ******************************************/
- (NSDate *)fm_followingDayWithNum:(NSInteger)num
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = num;
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

/******************************************
 *@Description:转换字符串 格式yyyy-MM-dd
 *@Return:日期字符串
 ******************************************/
- (NSString *)fm_stringFromDate:(NSString *)dateString
{
    return [[self fm_dateFormatter:dateString] stringFromDate:self];
}

- (NSDateFormatter *)fm_dateFormatter:(NSString *)dateString
{
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    }
    [dateFormatter setDateFormat:dateString];

    return dateFormatter;
}
- (NSString *)fm_UTCStringFromDate:(NSString *)dateString
{
    return [[self fm_utcDateFormatter:dateString] stringFromDate:self];
}
- (NSDateFormatter *)fm_utcDateFormatter:(NSString *)dateString
{
    if (!utcDateForMatter) {
        utcDateForMatter = [[NSDateFormatter alloc] init];
        utcDateForMatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    }
    [utcDateForMatter setDateFormat:dateString];
    return utcDateForMatter;
}
- (NSDate *)fm_dateFormString:(NSString *)dateString
{
    NSDateFormatter * dt = [self fm_dateFormatter:@"yyyy-MM-dd HH:mm:ss +0000"];
    NSDate * date = [dt dateFromString:dateString];
    return date;
}

/** 小视频时区*/
- (NSString *)fm_specialVideoStringFromDate:(NSString *)dateString
{
    return [[self fm_specialVideoStringdateFormatter:dateString] stringFromDate:self];
}

- (NSDateFormatter *)fm_specialVideoStringdateFormatter:(NSString *)dateString
{
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8];
    }
    [dateFormatter setDateFormat:dateString];

    return dateFormatter;
}

/******************************************
 *@Description:开始和结束时间差
 *@Return:天数差
 ******************************************/

- (NSInteger)fm_dayWithEndDate:(NSDate *)end
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned int unitFlag = NSCalendarUnitDay;
    NSDateFormatter * dateMatter = [self fm_dateFormatter:@"yyyy-MM-dd"];
    NSDate * beginDate = [dateMatter dateFromString:[dateMatter stringFromDate:self]];
    NSDate * endDate = [dateMatter dateFromString:[dateMatter stringFromDate:end]];
    NSDateComponents *components = [calendar components:unitFlag fromDate:beginDate toDate:endDate options:0];
    NSInteger days = [components day] + 1;
    return days;
}

/******************************************
 *@Description:开始和结束时间差
 *@Return:分钟差
 ******************************************/

- (NSInteger)fm_minuteWithEndDate:(NSDate *)end
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateFormatter * dateMatter = [self fm_dateFormatter:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * beginDate = [dateMatter dateFromString:[dateMatter stringFromDate:self]];
    NSDate * endDate = [dateMatter dateFromString:[dateMatter stringFromDate:end]];
    NSDateComponents *components = [calendar components:NSCalendarUnitMinute fromDate:beginDate toDate:endDate options:0];
    NSInteger minute = [components minute];
    return minute;
}
@end
