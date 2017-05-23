//
//  WJTime.m
//  TheMoment
//
//  Created by wangjun on 16/7/12.
//  Copyright (c) 2016年 wangjun. All rights reserved.
//

#import "WJTime.h"

@implementation WJTime

#pragma mark - 时间--->时间戳
- (NSString *)getTimeStampWithTime:(NSDate *)date {
    
    NSString *timeStamp = [NSString stringWithFormat:@"%lf",[date timeIntervalSince1970]];
    NSLog(@"timeStamp:%@", timeStamp);
    return timeStamp;
}

+ (NSString *)wjTimeGetTimeStampWithTime:(NSDate *)date {
    WJTime *time = [[self alloc] init];
    NSString *timeStr = [time getTimeStampWithTime:date];
    return timeStr;
}



#pragma mark - 时间戳--->时间
- (NSString *)getTimeWithTimeStamp:(NSString *)timeStamp {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Chongqing"];
    [formatter setDateFormat:@"YYYY.MM.dd HH:mm:ss"]; // 24小时制
//    [formatter setDateFormat:@"hh:mm:ss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp.doubleValue];
    
    // 将时间转化为字符串返回
    NSString *dateStr = [formatter stringFromDate:date];
    
    return dateStr;
}

+ (NSString *)wjTimeGetTimeWithTimeStamp:(NSString *)timeStamp {
    WJTime *time = [[self alloc] init];
    NSString *timeStr = [time getTimeWithTimeStamp:timeStamp];
    return timeStr;
}




#pragma mark - 分别转换成时分秒
- (int)getSecondsWithTimeStamp:(NSString *)timeStamp {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Chongqing"];
    [formatter setDateFormat:@"ss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp.doubleValue];
    NSString *dateStr = [formatter stringFromDate:date];
    return [dateStr intValue];
}

+ (int)wjTimeSecondsWithTimeStamp:(NSString *)timeStamp {
    WJTime *time = [[self alloc] init];
    int seconds = [time getSecondsWithTimeStamp:timeStamp];
    return seconds;
}


- (int)getMinuteWithTimeStamp:(NSString *)timeStamp {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Chongqing"];
    [formatter setDateFormat:@"mm"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp.doubleValue];
    
    NSString *dateStr = [formatter stringFromDate:date];
    
    return [dateStr intValue];
}

+ (int)wjTimeMinuteWithTimeStamp:(NSString *)timeStamp {
    WJTime *time = [[self alloc] init];
    int minute = [time getMinuteWithTimeStamp:timeStamp];
    return minute;
}


- (int)getHourWithTimeStamp:(NSString *)timeStamp {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Chongqing"];
    [formatter setDateFormat:@"HH"]; // 24小时制
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp.doubleValue];
    
    NSString *dateStr = [formatter stringFromDate:date];
    
    return [dateStr intValue];
}

+ (int)wjTimeHourWithTimeStamp:(NSString *)timeStamp {
    WJTime *time = [[self alloc] init];
    int hour = [time getHourWithTimeStamp:timeStamp];
    return hour;
}


#pragma mark - 将时分秒放在字典中
- (NSDictionary *)getTimeDictWithTimeStamp:(NSString *)timeStamp {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Chongqing"];
    [formatter setDateFormat:@"HH:mm:ss"]; // 24小时制
    //    [formatter setDateFormat:@"hh:mm:ss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp.doubleValue];
    
    // 将时间转化为字符串返回
    NSString *dateStr = [formatter stringFromDate:date];
    
    int hour = [dateStr substringWithRange:NSMakeRange(0, 2)].intValue;
    int minute = [dateStr substringWithRange:NSMakeRange(3, 2)].intValue;
    int seconds = [dateStr substringWithRange:NSMakeRange(6, 2)].intValue;
    NSDictionary *dict = @{
                           @"hour" : @(hour),
                           @"minute" : @(minute),
                           @"seconds" : @(seconds)
                           };
    
    return dict;
}



+ (NSDictionary *)wjTimeGetTimeDictWithTimeStamp:(NSString *)timeStamp {
    WJTime *time = [[self alloc] init];
    NSDictionary *dict = [time getTimeDictWithTimeStamp:timeStamp];
    return dict;
}


@end
